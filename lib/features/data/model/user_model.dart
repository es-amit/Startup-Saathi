import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:startup_saathi/features/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel(
      {super.uid,
      super.email,
      super.phoneNumber,
      super.profileUrl,
      super.firstName,
      super.lastName,
      super.college,
      super.city,
      super.skills,
      super.lookingFor,
      super.whoYouAre,
      super.imageFile,
      super.bio,
      super.businessStage,
      super.companySector});

  static UserModel fromSnapshot(DocumentSnapshot snap) {
    UserModel user = UserModel(
      uid: snap.id,
      email: snap['email'],
      phoneNumber: snap['phoneNumber'],
      profileUrl: snap['profileUrl'],
      firstName: snap['firstName'],
      lastName: snap['lastName'],
      college: snap['college'],
      city: snap['city'],
      lookingFor: snap['lookingFor'],
      whoYouAre: snap['whoYouAre'],
      skills: List<String>.from(snap['skills'] ?? []),
      bio: snap['bio'],
      companySector: snap['companySector'],
      businessStage: snap['businessStage'],
    );
    return user;
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'phoneNumber': phoneNumber,
      'profileUrl': profileUrl,
      'firstName': firstName,
      'lastName': lastName,
      'college': college,
      'city': city,
      'lookingFor': lookingFor,
      'whoYouAre': whoYouAre,
      'skills': skills,
      'bio': bio,
      'businessStage': businessStage,
      'companySector': companySector,
    };
  }

  @override
  UserModel copyWith({
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
    String? bio,
    String? companySector,
    String? businessStage,
  }) {
    return UserModel(
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
      bio: bio ?? this.bio,
      companySector: companySector ?? this.companySector,
      businessStage: businessStage ?? this.businessStage,
    );
  }

  UserModel toModel(UserEntity userEntity) {
    UserModel userModel = UserModel(
      uid: userEntity.uid,
      email: userEntity.email,
      phoneNumber: userEntity.phoneNumber,
      profileUrl: userEntity.profileUrl,
      firstName: userEntity.firstName,
      lastName: userEntity.lastName,
      college: userEntity.college,
      city: userEntity.city,
      lookingFor: userEntity.lookingFor,
      whoYouAre: userEntity.whoYouAre,
      skills: userEntity.skills,
      imageFile: userEntity.imageFile,
      businessStage: userEntity.businessStage,
      bio: userEntity.bio,
      companySector: userEntity.companySector,
    );

    return userModel;
  }
}
