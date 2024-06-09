import 'dart:io';

import 'package:flutter/material.dart';

class ProfileImageWidget extends StatelessWidget {
  final File? image;
  final VoidCallback getImage;

  const ProfileImageWidget({
    super.key,
    required this.image,
    required this.getImage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: getImage,
      child: CircleAvatar(
        radius: 70,
        backgroundImage: image != null ? FileImage(image!) : null,
        child: image == null ? Image.asset('assets/profile_default.png') : null,
      ),
    );
  }
}
