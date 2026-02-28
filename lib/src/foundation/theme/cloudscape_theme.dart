import 'package:flutter/material.dart';

import '../tokens/border_width.dart';
import '../tokens/colors.dart';
import '../tokens/motion.dart';
import '../tokens/radius.dart';
import '../tokens/spacing.dart';
import '../tokens/typography.dart';

class CloudscapeTheme {
  static ThemeData light({
    Color? brandColor,
    Color? onBrandColor,
    Color? brandBackground,
    Color? brandText,
    String? fontFamily,
    String? codeFontFamily,
  }) {
    final extension = CloudscapeColors.light(brandColor: brandColor);

    final typography = CloudscapeTypography(
      fontFamily: fontFamily ?? 'Open Sans',
      codeFontFamily: codeFontFamily ?? 'Source Code Pro',
    );
    final spacing = const CloudscapeSpacing();
    final radius = const CloudscapeRadius();
    final borderWidth = const CloudscapeBorderWidth();
    final motion = const CloudscapeMotion();

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: brandColor ?? extension.backgrounds.controlChecked,
        onPrimary: onBrandColor ?? extension.text.onPrimary,
        surface: brandBackground ?? extension.backgrounds.layoutMain,
        onSurface: brandText ?? extension.text.bodyDefault,
      ),
      scaffoldBackgroundColor:
          brandBackground ?? extension.backgrounds.layoutMain,
      extensions: [extension, typography, spacing, radius, borderWidth, motion],
    );
  }

  static ThemeData dark({
    Color? brandColor,
    Color? onBrandColor,
    Color? brandBackground,
    Color? brandText,
    String? fontFamily,
    String? codeFontFamily,
  }) {
    final extension = CloudscapeColors.dark(brandColor: brandColor);

    final typography = CloudscapeTypography(
      fontFamily: fontFamily ?? 'Open Sans',
      codeFontFamily: codeFontFamily ?? 'Source Code Pro',
    );
    final spacing = const CloudscapeSpacing();
    final radius = const CloudscapeRadius();
    final borderWidth = const CloudscapeBorderWidth();
    final motion = const CloudscapeMotion();

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: brandColor ?? extension.backgrounds.controlChecked,
        onPrimary: onBrandColor ?? extension.text.onPrimary,
        surface: brandBackground ?? extension.backgrounds.layoutMain,
        onSurface: brandText ?? extension.text.bodyDefault,
      ),
      scaffoldBackgroundColor:
          brandBackground ?? extension.backgrounds.layoutMain,
      extensions: [extension, typography, spacing, radius, borderWidth, motion],
    );
  }
}

extension CloudscapeThemeContext on BuildContext {
  /// Access to the Cloudscape Theme Extension colors.
  CloudscapeColors get cloudscapeColors =>
      Theme.of(this).extension<CloudscapeColors>()!;

  CloudscapeTypography get cloudscapeTypography =>
      Theme.of(this).extension<CloudscapeTypography>()!;
  CloudscapeSpacing get cloudscapeSpacing =>
      Theme.of(this).extension<CloudscapeSpacing>()!;
  CloudscapeRadius get cloudscapeRadius =>
      Theme.of(this).extension<CloudscapeRadius>()!;
  CloudscapeBorderWidth get cloudscapeBorderWidth =>
      Theme.of(this).extension<CloudscapeBorderWidth>()!;
  CloudscapeMotion get cloudscapeMotion =>
      Theme.of(this).extension<CloudscapeMotion>()!;
}
