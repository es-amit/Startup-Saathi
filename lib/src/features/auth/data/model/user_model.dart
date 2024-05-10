// ignore_for_file: must_be_immutable

import 'package:startup_saathi/src/components/enums/skills.dart';
import 'package:startup_saathi/src/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    super.uid,
    super.firstName,
    super.lastName,
    required super.email,
    required super.phoneNumber,
    super.city,
    super.college,
    super.skills,
    super.lookingFor,
    super.whoYouAre,
    super.businessStage,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      city: json['city'],
      college: json['college'],
      skills: List<Skills>.from(json['skills']),
      lookingFor: json['lookingFor'],
      whoYouAre: json['whoYouAre'],
      businessStage: json['businessStage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'city': city,
      'college': college,
      'skills': skills,
      'lookingFor': lookingFor,
      'whoYouAre': whoYouAre,
      'businessStage': businessStage,
    };
  }
}
