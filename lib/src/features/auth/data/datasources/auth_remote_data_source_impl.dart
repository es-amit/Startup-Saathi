import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:startup_saathi/src/features/auth/data/datasources/auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseFirestore fireStore;
  final FirebaseAuth auth;

  AuthRemoteDataSourceImpl(
    this.fireStore,
    this.auth,
  );
  @override
  Future<void> forgotPassword({required String email}) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<String> getCurrentUId() async {
    return auth.currentUser!.uid;
  }

  @override
  Future<bool> isUserLoggedIn() async {
    return auth.currentUser?.uid != null;
  }

  @override
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> logOut() async {
    await auth.signOut();
  }

  @override
  Future<void> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String phoneNumber,
  }) async {
    await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await fireStore.collection('users').doc(auth.currentUser!.uid).set({
      'email': email,
      'uid': auth.currentUser!.uid,
      'phoneNumber': phoneNumber,
    });
  }

  @override
  Future<void> saveUserDetails({
    required String firstName,
    required String lastName,
    required String city,
    required String college,
  }) async {
    await fireStore.collection('users').doc(auth.currentUser!.uid).set({
      'firstName': firstName,
      'lastName': lastName,
      'city': city,
      'college': college,
    });
  }
}
