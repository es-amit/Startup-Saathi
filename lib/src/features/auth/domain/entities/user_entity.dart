// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:startup_saathi/src/components/enums/post.dart';
import 'package:startup_saathi/src/components/enums/skills.dart';
import 'package:startup_saathi/src/features/auth/domain/entities/business_stage.dart';

class UserEntity extends Equatable {
  String? firstName;
  String? lastName;
  final String email;
  final String phoneNumber;
  String? city;
  String? college;
  List<Skills>? skills;
  Post? lookingFor;
  Post? whoYouAre;
  BusinessStage? businessStage;

  UserEntity({
    this.firstName,
    this.lastName,
    required this.email,
    required this.phoneNumber,
    this.city,
    this.college,
    this.skills,
    this.lookingFor,
    this.whoYouAre,
    this.businessStage,
  });

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        email,
        phoneNumber,
        city,
        college,
        skills,
        lookingFor,
        whoYouAre,
        businessStage,
      ];
}
