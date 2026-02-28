import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'generated/cloudscape_tokens.dart';

class CloudscapeTypography extends ThemeExtension<CloudscapeTypography> {
  final String fontFamily;
  final String codeFontFamily;

  const CloudscapeTypography({
    this.fontFamily = 'Open Sans',
    this.codeFontFamily = 'Source Code Pro',
  });

  TextStyle _createStyle(
    double fontSize,
    double lineHeight, [
    FontWeight? fontWeight,
  ]) {
    return GoogleFonts.getFont(
      fontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight ?? FontWeight.normal,
      height: lineHeight / fontSize,
    );
  }

  // Display styles
  TextStyle get displayBold => _createStyle(
    CloudscapeTokens.fontSizeDisplayL,
    CloudscapeTokens.lineHeightDisplayL,
    FontWeight.w700,
  );

  TextStyle get displayNormal => _createStyle(
    CloudscapeTokens.fontSizeDisplayL,
    CloudscapeTokens.lineHeightDisplayL,
    FontWeight.normal,
  );

  // Heading styles
  TextStyle get headingXl => _createStyle(
    CloudscapeTokens.fontSizeHeadingXl,
    CloudscapeTokens.lineHeightHeadingXl,
    CloudscapeTokens.fontWeightHeadingXl,
  );
  TextStyle get headingL => _createStyle(
    CloudscapeTokens.fontSizeHeadingL,
    CloudscapeTokens.lineHeightHeadingL,
    CloudscapeTokens.fontWeightHeadingL,
  );
  TextStyle get headingM => _createStyle(
    CloudscapeTokens.fontSizeHeadingM,
    CloudscapeTokens.lineHeightHeadingM,
    CloudscapeTokens.fontWeightHeadingM,
  );
  TextStyle get headingS => _createStyle(
    CloudscapeTokens.fontSizeHeadingS,
    CloudscapeTokens.lineHeightHeadingS,
    CloudscapeTokens.fontWeightHeadingS,
  );
  TextStyle get headingXs => _createStyle(
    CloudscapeTokens.fontSizeHeadingXs,
    CloudscapeTokens.lineHeightHeadingXs,
    CloudscapeTokens.fontWeightHeadingXs,
  );

  // Body styles
  TextStyle get bodyM => _createStyle(
    CloudscapeTokens.fontSizeBodyM,
    CloudscapeTokens.lineHeightBodyM,
  );
  TextStyle get bodyS => _createStyle(
    CloudscapeTokens.fontSizeBodyS,
    CloudscapeTokens.lineHeightBodyS,
  );

  // Code styles
  TextStyle get code => GoogleFonts.getFont(
    codeFontFamily,
    fontSize: CloudscapeTokens.fontSizeBodyM,
    fontWeight: FontWeight.normal,
    height: CloudscapeTokens.lineHeightBodyM / CloudscapeTokens.fontSizeBodyM,
  );

  TextStyle get codeS => GoogleFonts.getFont(
    codeFontFamily,
    fontSize: CloudscapeTokens.fontSizeBodyS,
    fontWeight: FontWeight.normal,
    height: CloudscapeTokens.lineHeightBodyS / CloudscapeTokens.fontSizeBodyS,
  );

  // Label styles
  TextStyle get label => _createStyle(
    CloudscapeTokens.fontSizeBodyM,
    CloudscapeTokens.lineHeightBodyM,
    FontWeight.w700,
  );

  @override
  ThemeExtension<CloudscapeTypography> copyWith({
    String? fontFamily,
    String? codeFontFamily,
  }) {
    return CloudscapeTypography(
      fontFamily: fontFamily ?? this.fontFamily,
      codeFontFamily: codeFontFamily ?? this.codeFontFamily,
    );
  }

  @override
  ThemeExtension<CloudscapeTypography> lerp(
    ThemeExtension<CloudscapeTypography>? other,
    double t,
  ) {
    if (other is! CloudscapeTypography) return this;
    return t < 0.5 ? this : other;
  }
}
