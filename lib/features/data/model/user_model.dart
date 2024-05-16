import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:startup_saathi/features/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    super.uid,
    super.email,
    super.phoneNumber,
    super.profileUrl,
    super.firstName,
    super.lastName,
    super.city,
    super.college,
    super.imageFile,
  }) : super();

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      profileUrl: json['profileUrl'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      college: json['college'],
      city: json['city'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'phoneNumber': phoneNumber,
      'profileUrl': profileUrl,
      'firstName': firstName,
      'lastName': lastName,
      'college': college,
      'city': city,
    };
  }

  factory UserModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserModel(
      uid: snapshot['uid'],
      email: snapshot['email'],
      phoneNumber: snapshot['phoneNumber'],
      profileUrl: snapshot['profileUrl'],
      firstName: snapshot['firstName'],
      lastName: snapshot['lastName'],
      college: snapshot['college'],
      city: snapshot['city'],
    );
  }
}
