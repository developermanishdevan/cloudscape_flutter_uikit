import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../tokens/colors.dart';
import '../tokens/radius.dart';

/// Extension to hold Cloudscape-specific design tokens.
/// Allows for custom tokens to be accessible via [Theme.of(context)].
class CloudscapeThemeExtension
    extends ThemeExtension<CloudscapeThemeExtension> {
  final CloudscapeColors colors;

  const CloudscapeThemeExtension({required this.colors});

  @override
  ThemeExtension<CloudscapeThemeExtension> copyWith({
    CloudscapeColors? colors,
  }) {
    return CloudscapeThemeExtension(colors: colors ?? this.colors);
  }

  @override
  ThemeExtension<CloudscapeThemeExtension> lerp(
    ThemeExtension<CloudscapeThemeExtension>? other,
    double t,
  ) {
    if (other is! CloudscapeThemeExtension) return this;

    // Minimal lerp for now, focus is on exact values.
    return CloudscapeThemeExtension(colors: other.colors);
  }

  /// Helper to get tokens from context.
  static CloudscapeThemeExtension of(BuildContext context) {
    final extension = Theme.of(context).extension<CloudscapeThemeExtension>();
    if (extension == null) {
      throw Exception(
        'CloudscapeThemeExtension not found in Theme. Ensure it is added to extensions.',
      );
    }
    return extension;
  }
}

/// Entry point for Cloudscape Theme system.
class CloudscapeTheme {
  /// Builds a [ThemeData] for Light mode.
  static ThemeData light() {
    final colors = CloudscapeColors.light();
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: colors.primaryMain,
      scaffoldBackgroundColor: colors.backgroundMain,
      dividerColor: colors.borderDividerDefault,
      textTheme: GoogleFonts.openSansTextTheme(),
      extensions: [CloudscapeThemeExtension(colors: colors)],
      // Override Material defaults where possible
      cardTheme: CardThemeData(
        color: colors.backgroundContainerContent,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: CloudscapeRadius.brXSmall),
      ),
    );
  }

  /// Builds a [ThemeData] for Dark mode.
  static ThemeData dark() {
    final colors = CloudscapeColors.dark();
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: colors.primaryMain,
      scaffoldBackgroundColor: colors.backgroundMain,
      dividerColor: colors.borderDividerDefault,
      textTheme: GoogleFonts.openSansTextTheme(ThemeData.dark().textTheme),
      extensions: [CloudscapeThemeExtension(colors: colors)],
      cardTheme: CardThemeData(
        color: colors.backgroundContainerContent,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: CloudscapeRadius.brXSmall),
      ),
    );
  }
}
