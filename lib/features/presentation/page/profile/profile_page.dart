import 'package:flutter/material.dart';
import 'package:startup_saathi/features/domain/entities/user_entity.dart';

class ProfilePage extends StatelessWidget {
  final UserEntity userEntity;
  const ProfilePage({
    super.key,
    required this.userEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            // Text(userEntity.email!),
            // Text(userEntity.phoneNumber!),
            // Text(userEntity.firstName!),
            // Text(userEntity.lastName!),
            Text(userEntity.uid!),
            // Text(userEntity.profilePicture!),
          ],
        ),
      ),
    );
  }
}
