import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:startup_saathi/src/components/enums/skills.dart';
import 'package:startup_saathi/src/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.phoneNumber,
    required super.city,
    required super.college,
    required super.skills,
    required super.lookingFor,
    required super.whoYouAre,
    super.businessStage,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      city: json['city'],
      college: json['college'],
      skills: json['skills'].map<Skills>((e) => Skills.values[e]).toList(),
      lookingFor: json['lookingFor'],
      whoYouAre: json['whoYouAre'],
      businessStage: json['businessStage'],
    );
  }

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    return UserModel(
      firstName: snapshot.get('firstName'),
      lastName: snapshot.get('lastName'),
      email: snapshot.get('email'),
      phoneNumber: snapshot.get('phoneNumber'),
      city: snapshot.get('city'),
      college: snapshot.get('college'),
      skills:
          snapshot.get('skills').map<Skills>((e) => Skills.values[e]).toList(),
      lookingFor: snapshot.get('lookingFor'),
      whoYouAre: snapshot.get('whoYouAre'),
      businessStage: snapshot.get('businessStage'),
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'city': city,
      'college': college,
      'skills': skills.map((e) => e.index).toList(),
      'lookingFor': lookingFor,
      'whoYouAre': whoYouAre,
      'businessStage': businessStage,
    };
  }
}
