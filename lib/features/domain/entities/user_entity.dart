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
    this.skills,
  });

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
