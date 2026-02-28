import 'package:flutter/animation.dart';

/// Motion tokens for consistent animations.
class CloudscapeMotion {
  // Durations
  static const Duration durationNone = Duration.zero;
  static const Duration durationFast = Duration(milliseconds: 100);
  static const Duration durationModerate = Duration(milliseconds: 200);
  static const Duration durationSlow = Duration(milliseconds: 300);

  // Easings
  static const Curve easeIn = Curves.easeIn;
  static const Curve easeOut = Curves.easeOut;
  static const Curve easeInOut = Curves.easeInOut;

  /// Cloudscape standard easing for state transitions.
  static const Curve easingRefresh = Cubic(0.165, 0.84, 0.44, 1.0);
}
