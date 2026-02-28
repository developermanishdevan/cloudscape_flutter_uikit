import 'package:flutter/material.dart';

import '../tokens/border_width.dart';
import '../tokens/colors.dart';
import '../tokens/motion.dart';
import '../tokens/radius.dart';
import '../tokens/spacing.dart';
import '../tokens/typography.dart';

class CloudscapeTheme {
  static ThemeData light() {
    final colors = CloudscapeColors.light();
    final typography = const CloudscapeTypography();
    final spacing = const CloudscapeSpacing();
    final radius = const CloudscapeRadius();
    final borderWidth = const CloudscapeBorderWidth();
    final motion = const CloudscapeMotion();

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: colors.tokens.colorBackgroundButtonPrimaryDefault,
        onPrimary: colors.tokens.colorTextButtonPrimaryDefault,
        surface: colors.tokens.colorBackgroundLayoutMain,
        onSurface: colors.tokens.colorTextBodyDefault,
        error: colors.tokens.colorBackgroundStatusError,
        onError: colors.tokens.colorTextStatusError,
      ),
      scaffoldBackgroundColor: colors.tokens.colorBackgroundLayoutMain,
      extensions: [colors, typography, spacing, radius, borderWidth, motion],
    );
  }

  static ThemeData dark() {
    final colors = CloudscapeColors.dark();
    final typography = const CloudscapeTypography();
    final spacing = const CloudscapeSpacing();
    final radius = const CloudscapeRadius();
    final borderWidth = const CloudscapeBorderWidth();
    final motion = const CloudscapeMotion();

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: colors.tokens.colorBackgroundButtonPrimaryDefault,
        onPrimary: colors.tokens.colorTextButtonPrimaryDefault,
        surface: colors.tokens.colorBackgroundLayoutMain,
        onSurface: colors.tokens.colorTextBodyDefault,
        error: colors.tokens.colorBackgroundStatusError,
        onError: colors.tokens.colorTextStatusError,
      ),
      scaffoldBackgroundColor: colors.tokens.colorBackgroundLayoutMain,
      extensions: [colors, typography, spacing, radius, borderWidth, motion],
    );
  }
}

extension CloudscapeThemeContext on BuildContext {
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
