import 'package:equatable/equatable.dart';
import 'package:startup_saathi/src/components/enums/post.dart';
import 'package:startup_saathi/src/components/enums/skills.dart';
import 'package:startup_saathi/src/features/auth/domain/entities/business_stage.dart';

class UserEntity extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String city;
  final String college;
  final List<Skills> skills;
  final Post lookingFor;
  final Post whoYouAre;
  final BusinessStage? businessStage;

  const UserEntity({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.city,
    required this.college,
    required this.skills,
    required this.lookingFor,
    required this.whoYouAre,
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
