import 'dart:io';

import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? uid;
  final String? email;
  final String? phoneNumber;
  final String? profileUrl;
  final String? firstName;
  final String? lastName;
  final String? college;
  final String? city;
  final String? lookingFor;
  final String? whoYouAre;
  final List<String>? skills;

  // will going to store in storage
  final File? imageFile;

  const UserEntity({
    this.uid,
    this.email,
    this.phoneNumber,
    this.profileUrl,
    this.firstName,
    this.lastName,
    this.college,
    this.city,
    this.imageFile,
    this.lookingFor,
    this.whoYouAre,
    List<String>? skills,
  }) : skills = skills ?? const [];

  UserEntity copyWith({
    String? uid,
    String? email,
    String? phoneNumber,
    String? profileUrl,
    String? firstName,
    String? lastName,
    String? college,
    String? city,
    String? lookingFor,
    String? whoYouAre,
    List<String>? skills,
    File? imageFile,
  }) {
    return UserEntity(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileUrl: profileUrl ?? this.profileUrl,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      college: college ?? this.college,
      city: city ?? this.city,
      lookingFor: lookingFor ?? this.lookingFor,
      whoYouAre: whoYouAre ?? this.whoYouAre,
      skills: skills ?? this.skills,
      imageFile: imageFile ?? this.imageFile,
    );
  }

  @override
  List<Object?> get props => [
        uid,
        email,
        phoneNumber,
        profileUrl,
        firstName,
        lastName,
        city,
        college,
        imageFile,
        lookingFor,
        whoYouAre,
        skills,
      ];
}
