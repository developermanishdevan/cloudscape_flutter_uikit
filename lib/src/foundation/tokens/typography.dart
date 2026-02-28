import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'generated/cloudscape_tokens.dart';

class CloudscapeTypography extends ThemeExtension<CloudscapeTypography> {
  const CloudscapeTypography();

  TextStyle _createStyle(
    double fontSize,
    double lineHeight, [
    FontWeight? fontWeight,
  ]) {
    return GoogleFonts.openSans(
      fontSize: fontSize,
      fontWeight: fontWeight ?? FontWeight.normal,
      height: lineHeight / fontSize,
    );
  }

  // Body styles
  TextStyle get bodyM => _createStyle(
    CloudscapeTokens.fontSizeBodyM,
    CloudscapeTokens.lineHeightBodyM,
  );
  TextStyle get bodyS => _createStyle(
    CloudscapeTokens.fontSizeBodyS,
    CloudscapeTokens.lineHeightBodyS,
  );

  // Display styles
  TextStyle get displayL => _createStyle(
    CloudscapeTokens.fontSizeDisplayL,
    CloudscapeTokens.lineHeightDisplayL,
    FontWeight.w900,
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

  // Code styles
  TextStyle get code => GoogleFonts.sourceCodePro(
    fontSize: CloudscapeTokens.fontSizeBodyM,
    fontWeight: FontWeight.normal,
    height: CloudscapeTokens.lineHeightBodyM / CloudscapeTokens.fontSizeBodyM,
  );

  TextStyle get codeS => GoogleFonts.sourceCodePro(
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
  ThemeExtension<CloudscapeTypography> copyWith() =>
      const CloudscapeTypography();

  @override
  ThemeExtension<CloudscapeTypography> lerp(
    ThemeExtension<CloudscapeTypography>? other,
    double t,
  ) {
    return this;
  }
}
