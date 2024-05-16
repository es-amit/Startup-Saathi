import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:startup_saathi/features/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    super.uid,
    super.firstName,
    super.lastName,
    super.email,
    super.phoneNumber,
    super.profilePicture,
  }) : super();

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      profilePicture: json['profilePicture'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'profilePicture': profilePicture,
    };
  }

  factory UserModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserModel(
      uid: snapshot['uid'],
      email: snapshot['email'],
      phoneNumber: snapshot['phoneNumber'],
      firstName: snapshot['firstName'],
      lastName: snapshot['lastName'],
      profilePicture: snapshot['profilePicture'],
    );
  }
}
