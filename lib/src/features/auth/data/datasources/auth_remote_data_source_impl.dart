// import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:startup_saathi/src/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:startup_saathi/src/features/auth/data/model/user_model.dart';
import 'package:startup_saathi/src/features/auth/data/network/firebase_error_handler.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  AuthRemoteDataSourceImpl(
    this.firebaseAuth,
    this.firebaseFirestore,
  );
  @override
  Future<UserModel> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String phoneNumber,
  }) async {
    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user == null) {
        throw const AuthErrorUnknown();
      }
      await storePhoneNumber(
        uid: userCredential.user!.uid,
        phoneNumber: phoneNumber,
      );
      return UserModel(
        email: email,
        phoneNumber: phoneNumber,
      );
    } on FirebaseAuthException catch (e) {
      // log(e.toString());
      // log(authErrorMapping[e.code.toLowerCase().trim()].toString());
      throw authErrorMapping[e.code.toLowerCase().trim()] as Object;
    }
  }

  @override
  Future<void> storePhoneNumber({
    required String uid,
    required String phoneNumber,
  }) async {
    try {
      await firebaseFirestore.collection('users').doc(uid).set({
        'phoneNumber': phoneNumber,
      });
    } catch (e) {
      throw const AuthErrorUnknown();
    }
  }
}
