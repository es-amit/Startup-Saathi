import 'dart:io';

import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? uid;
  final String? email;
  final String? phoneNumber;
  final String? password;
  final String? profileUrl;
  final String? firstName;
  final String? lastName;
  final String? college;
  final String? city;

  // will going to store in storage
  final File? imageFile;

  const UserEntity({
    this.uid,
    this.email,
    this.phoneNumber,
    this.password,
    this.profileUrl,
    this.firstName,
    this.lastName,
    this.college,
    this.city,
    this.imageFile,
  });

  @override
  List<Object?> get props => [
        uid,
        email,
        phoneNumber,
        password,
        profileUrl,
        firstName,
        lastName,
        city,
        college,
        imageFile,
      ];
}
