// lib/core/widgets/animated_gradient_background.dart

import 'package:currensee/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class AnimatedGradientBackground extends StatelessWidget {
  final Widget child;

  const AnimatedGradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // Define the animation tween for the gradient's alignment
    final tween = MovieTween()
      ..scene(duration: const Duration(seconds: 4)).tween(
          'alignment',
          AlignmentTween(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ))
      ..scene(duration: const Duration(seconds: 4)).tween(
          'alignment',
          AlignmentTween(
            begin: Alignment.bottomRight,
            end: Alignment.topRight,
          ))
      ..scene(duration: const Duration(seconds: 4)).tween(
          'alignment',
          AlignmentTween(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ))
      ..scene(duration: const Duration(seconds: 4)).tween(
          'alignment',
          AlignmentTween(
            begin: Alignment.bottomLeft,
            end: Alignment.topLeft,
          ));

    return LoopAnimationBuilder<Movie>(
      tween: tween,
      duration: tween.duration,
      builder: (context, value, _) {
        final alignment = value.get<Alignment>('alignment'); // safely unwrap
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: alignment,
              end: -alignment,
              colors: const [
                AppColors.gradientStart,
                AppColors.gradientMid,
                AppColors.gradientEnd,
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
          child: child,
        );
      },
    );
  }
}
