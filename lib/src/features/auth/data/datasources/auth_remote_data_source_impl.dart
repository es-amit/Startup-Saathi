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
      final userModel = UserModel(
        email: email,
        phoneNumber: phoneNumber,
        uid: userCredential.user!.uid,
      );
      await storeUserDetails(user: userModel);
      return userModel;
    } on FirebaseAuthException catch (e) {
      throw authErrorMapping[e.code.toLowerCase().trim()] as Object;
    }
  }

  @override
  Future<void> storeUserDetails({required UserModel user}) async {
    try {
      await firebaseFirestore.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'email': user.email,
        'phoneNumber': user.phoneNumber,
      });
    } catch (e) {
      throw const AuthErrorUnknown();
    }
  }
}
