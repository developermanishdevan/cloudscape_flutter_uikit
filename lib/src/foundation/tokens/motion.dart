import 'package:flutter/material.dart';

/// Motion tokens for consistent animations.
class CloudscapeMotion extends ThemeExtension<CloudscapeMotion> {
  const CloudscapeMotion();

  // Durations
  Duration get durationNone => Duration.zero;
  Duration get durationFast => const Duration(milliseconds: 100);
  Duration get durationModerate => const Duration(milliseconds: 200);
  Duration get durationSlow => const Duration(milliseconds: 300);

  // Easings
  Curve get easeIn => Curves.easeIn;
  Curve get easeOut => Curves.easeOut;
  Curve get easeInOut => Curves.easeInOut;

  /// Cloudscape standard easing for state transitions.
  Curve get easingRefresh => const Cubic(0.165, 0.84, 0.44, 1.0);

  @override
  ThemeExtension<CloudscapeMotion> copyWith() => const CloudscapeMotion();

  @override
  ThemeExtension<CloudscapeMotion> lerp(
    ThemeExtension<CloudscapeMotion>? other,
    double t,
  ) {
    return this;
  }
}
