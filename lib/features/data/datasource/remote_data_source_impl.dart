import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:startup_saathi/core/constants.dart';
import 'package:startup_saathi/features/data/datasource/errors/firebase_error_handler.dart';
import 'package:startup_saathi/features/data/datasource/remote_data_source.dart';
import 'package:startup_saathi/features/data/model/user_model.dart';

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

    log(user.toString());

    final imageUrl = await uploadImageToStorage(user.imageFile);

    user = user.copyWith(
      profileUrl: imageUrl,
    );

    log(user.toString());
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
    } catch (e) {
      log(e.toString());
      throw Exception('Failed to register user');
    }
  }

  @override
  Future<String> getCurrentUid() async {
    return firebaseAuth.currentUser!.uid;
  }

  @override
  Future<String> uploadImageToStorage(File? file) async {
    Uint8List imageData;
    if (file == null) {
      // load default image from assets
      ByteData byteData = await rootBundle.load('assets/profile_default.png');
      imageData = byteData.buffer.asUint8List();
    } else {
      imageData = await file.readAsBytes();
    }
    Reference ref = firebaseStorage.ref().child(firebaseAuth.currentUser!.uid);

    final uploadTask = ref.putData(imageData);
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
  Future<UserModel> getSingleUser(String uid) async {
    try {
      final user = await firebaseFirestore
          .collection(FirebaseConst.users)
          .doc(uid)
          .get();

      if (user.exists && user.data() != null) {
        return UserModel.fromSnapshot(user);
      }
      log('user not found');
      throw Exception('User not found');
    } catch (e) {
      log(e.toString());
      throw Exception('Failed to fetch user data');
    }
  }

  @override
  Stream<List<UserModel>> getAllUsers(String currentUser) {
    try {
      return firebaseFirestore
          .collection(FirebaseConst.users)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs
            .where((doc) => doc.id != currentUser) // Exclude the current user
            .map((doc) => UserModel.fromSnapshot(doc))
            .toList();
      });
    } catch (e) {
      log(e.toString());
      return const Stream.empty();
    }
  }
}
