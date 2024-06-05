import 'package:startup_saathi/core/animation/lottie_animation_view.dart';
import 'package:startup_saathi/core/animation/model/lottie_animation.dart';

class LoadingAnimationView extends LottieAnimationView {
  const LoadingAnimationView({super.key})
      : super(animation: LottieAnimation.loading);
}
