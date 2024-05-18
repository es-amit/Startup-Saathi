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
  Future<void> createUserWithImage(UserEntity user) async {
    final userCollection = firebaseFirestore.collection(FirebaseConst.users);

    final imageUrl = await uploadImageToStorage(user.imageFile);

    final uid = await getCurrentUid();

    userCollection.doc(uid).get().then((userDoc) {
      final newUser = UserModel(
        email: userDoc.get('email'),
        phoneNumber: userDoc.get('phoneNumber'),
        uid: uid,
        profileUrl: imageUrl,
        firstName: user.firstName,
        lastName: user.lastName,
        college: user.college,
        city: user.city,
      ).toJson();

      if (!userDoc.exists) {
        userCollection.doc(uid).set(newUser);
      } else {
        userCollection.doc(uid).update(newUser);
      }
    }).catchError((error) {});
  }

  @override
  Future<bool> isSignIn() async {
    return firebaseAuth.currentUser != null;
  }

  @override
  Future<void> logInUser(UserEntity user) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: user.email!,
        password: user.password!,
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
  Future<void> registerUser(UserEntity user) async {
    try {
      await firebaseAuth
          .createUserWithEmailAndPassword(
              email: user.email!, password: user.password!)
          .then((currentUser) async {
        if (currentUser.user?.uid != null) {
          await firebaseFirestore
              .collection(FirebaseConst.users)
              .doc(currentUser.user!.uid)
              .set({
            'uid': currentUser.user!.uid,
            'email': user.email,
            'phoneNumber': user.phoneNumber,
          });
        }
      });
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
    Reference ref = firebaseStorage.ref().child(firebaseAuth.currentUser!.uid);

    final uploadTask = ref.putFile(file!);
    final imageUrl =
        (await uploadTask.whenComplete(() {})).ref.getDownloadURL();

    return await imageUrl;
  }

  @override
  Future<void> updateUser(UserEntity user, String? uid, bool update) async {
    final userCollection = firebaseFirestore.collection(FirebaseConst.users);
    Map<String, dynamic> userInformation = {};

    if (user.email != "" && user.email != null) {
      userInformation['email'] = user.email;
    }

    if (user.phoneNumber != "" && user.phoneNumber != null) {
      userInformation['phoneNumber'] = user.phoneNumber;
    }

    if (user.firstName != "" && user.firstName != null) {
      userInformation['firstName'] = user.firstName;
    }

    if (user.lastName != "" && user.lastName != null) {
      userInformation['lastName'] = user.lastName;
    }

    if (uid != "" && uid != null) userInformation['uid'] = uid;

    if (update) {
      userCollection.doc(uid).update(userInformation);
    } else {
      userCollection.doc(uid).set(userInformation);
    }
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
