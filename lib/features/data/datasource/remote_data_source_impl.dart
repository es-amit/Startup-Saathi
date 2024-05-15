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

  Future<void> createUserWithImage(UserEntity user, String profileUrl) async {
    final userCollection = firebaseFirestore.collection(FirebaseConst.users);

    final uid = await getCurrentUid();

    userCollection.doc(uid).get().then((userDoc) {
      final newUser = UserModel(
        uid: uid,
        email: user.email,
        firstName: user.firstName,
        lastName: user.lastName,
        profilePicture: user.profilePicture,
        phoneNumber: user.phoneNumber,
      ).toJson();

      if (!userDoc.exists) {
        userCollection.doc(uid).set(newUser);
      } else {
        userCollection.doc(uid).update(newUser);
      }
    }).catchError((error) {
      log("error: $error");
    });
  }

  @override
  Future<bool> isSignIn() async {
    log('isSignin remote datasource');
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
      log(e.code);
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
          await updateUser(user, currentUser.user?.uid, false);
        }
      });
    } on FirebaseAuthException catch (e) {
      log(e.code);
      throw authErrorMapping[e.code.toLowerCase().trim()] as AuthError;
    }
  }

  @override
  Future<String> getCurrentUid() async {
    log('getCurrentUid remote datasource');
    return firebaseAuth.currentUser!.uid;
  }

  @override
  Future<String> uploadImageToStorage(File? file, String childName) async {
    Reference ref = firebaseStorage
        .ref()
        .child(childName)
        .child(firebaseAuth.currentUser!.uid);

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
}
