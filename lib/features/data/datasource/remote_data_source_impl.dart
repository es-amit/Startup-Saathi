import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:startup_saathi/core/constants.dart';
import 'package:startup_saathi/features/data/datasource/errors/firebase_error_handler.dart';
import 'package:startup_saathi/features/data/datasource/remote_data_source.dart';
import 'package:startup_saathi/features/data/model/user_model.dart';
import 'package:startup_saathi/features/domain/entities/user_entity.dart';

class FirebaseRemoteDataSourceImpl implements FirebaseRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;

  FirebaseRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.firebaseFirestore,
    required this.firebaseStorage,
  });

  @override
  Future<void> storeUserInfo(UserModel user) async {
    final userCollection = firebaseFirestore.collection(FirebaseConst.users);

    final uid = await getCurrentUid();

    final imageUrl = await uploadImageToStorage(user.imageFile);

    user.copyWith(
      profileUrl: imageUrl,
    );
    userCollection
        .doc(uid)
        .set(
          user.toMap(),
        )
        .catchError((error) {
      log(error.toString());
    });
  }

  @override
  Future<bool> isSignIn() async {
    return firebaseAuth.currentUser != null;
  }

  @override
  Future<void> logInUser(
    String email,
    String password,
  ) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      // handling error
      throw authErrorMapping[e.code.toLowerCase().trim()] as AuthError;
    }
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<void> registerUser(String email, String password) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw authErrorMapping[e.code.toLowerCase().trim()] as AuthError;
    }
  }

  @override
  Future<String> getCurrentUid() async {
    return firebaseAuth.currentUser!.uid;
  }

  @override
  Future<String> uploadImageToStorage(File? file) async {
    Reference ref = firebaseStorage
        .ref()
        .child('${firebaseAuth.currentUser!.uid}/profileImage');

    final uploadTask = ref.putFile(file!);
    final imageUrl =
        (await uploadTask.whenComplete(() {})).ref.getDownloadURL();

    return await imageUrl;
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw authErrorMapping[e.code.toLowerCase().trim()] as AuthError;
    }
  }

  @override
  Stream<List<UserEntity>> getSingleUser(String uid) {
    final userCollection = firebaseFirestore
        .collection(FirebaseConst.users)
        .where("uid", isEqualTo: uid)
        .limit(1);
    return userCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList());
  }
}
