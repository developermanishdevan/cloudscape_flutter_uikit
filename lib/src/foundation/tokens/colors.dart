import 'package:flutter/material.dart';

import '../theme/cloudscape_color_scheme.dart';

/// Theme extension for Cloudscape colors.
///
/// This class provides a unified way to access Cloudscape colors within the
/// Flutter theme.
class CloudscapeColors extends ThemeExtension<CloudscapeColors> {
  final Brightness brightness;
  final CloudscapeBackgroundColors backgrounds;
  final CloudscapeTextColors text;
  final CloudscapeBorderColors borders;
  final CloudscapeStatusColors status;
  final CloudscapeChartColors charts;

  const CloudscapeColors({
    required this.brightness,
    required this.backgrounds,
    required this.text,
    required this.borders,
    required this.status,
    required this.charts,
  });

  factory CloudscapeColors.light({Color? brandColor}) {
    final dynamicColors = CloudscapeDynamicColors.light(brandColor: brandColor);
    return CloudscapeColors(
      brightness: dynamicColors.brightness,
      backgrounds: dynamicColors.backgrounds,
      text: dynamicColors.text,
      borders: dynamicColors.borders,
      status: dynamicColors.status,
      charts: dynamicColors.charts,
    );
  }

  factory CloudscapeColors.dark({Color? brandColor}) {
    final dynamicColors = CloudscapeDynamicColors.dark(brandColor: brandColor);
    return CloudscapeColors(
      brightness: dynamicColors.brightness,
      backgrounds: dynamicColors.backgrounds,
      text: dynamicColors.text,
      borders: dynamicColors.borders,
      status: dynamicColors.status,
      charts: dynamicColors.charts,
    );
  }

  @override
  CloudscapeColors copyWith({
    Brightness? brightness,
    CloudscapeBackgroundColors? backgrounds,
    CloudscapeTextColors? text,
    CloudscapeBorderColors? borders,
    CloudscapeStatusColors? status,
    CloudscapeChartColors? charts,
  }) {
    return CloudscapeColors(
      brightness: brightness ?? this.brightness,
      backgrounds: backgrounds ?? this.backgrounds,
      text: text ?? this.text,
      borders: borders ?? this.borders,
      status: status ?? this.status,
      charts: charts ?? this.charts,
    );
  }

  @override
  CloudscapeColors lerp(ThemeExtension<CloudscapeColors>? other, double t) {
    if (other is! CloudscapeColors) return this;
    return t < 0.5 ? this : other;
  }
}
