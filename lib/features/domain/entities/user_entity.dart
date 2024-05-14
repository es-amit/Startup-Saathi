import 'dart:io';

import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? uid;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneNumber;
  final String? profilePicture;
  final File? imageFile;

  final String? password;

  const UserEntity({
    this.password,
    this.uid,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.profilePicture,
    this.imageFile,
  });

  @override
  List<Object?> get props => [
        uid,
        firstName,
        lastName,
        email,
        phoneNumber,
        profilePicture,
        imageFile,
        password,
      ];
}
