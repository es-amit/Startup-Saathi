import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:startup_saathi/core/animation/model/lottie_animation.dart';

class LottieAnimationView extends StatelessWidget {
  final LottieAnimation animation;
  final bool repeat;
  final bool reverse;

  const LottieAnimationView(
      {super.key,
      required this.animation,
      this.repeat = true,
      this.reverse = false});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(animation.fullPath, reverse: reverse, repeat: repeat);
  }
}

extension GetFullPath on LottieAnimation {
  String get fullPath => 'assets/lottie/$name.json';
}
