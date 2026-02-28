import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Typography definitions for Cloudscape Design System.
class CloudscapeTypography {
  static final TextStyle _base = GoogleFonts.openSans();
  static final TextStyle _mono = GoogleFonts.sourceCodePro();

  // Font Weights
  static const FontWeight weightLight = FontWeight.w300;
  static const FontWeight weightNormal = FontWeight.w400;
  static const FontWeight weightMedium = FontWeight.w600;
  static const FontWeight weightBold = FontWeight.w700;
  static const FontWeight weightHeavy = FontWeight.w800;

  // Type Styles
  static final TextStyle headingXL = _base.copyWith(
    fontSize: 24,
    height: 30 / 24,
    fontWeight: weightBold,
  );

  static final TextStyle headingL = _base.copyWith(
    fontSize: 20,
    height: 24 / 20,
    fontWeight: weightBold,
  );

  static final TextStyle headingM = _base.copyWith(
    fontSize: 18,
    height: 22 / 18,
    fontWeight: weightBold,
  );

  static final TextStyle headingS = _base.copyWith(
    fontSize: 16,
    height: 20 / 16,
    fontWeight: weightBold,
  );

  static final TextStyle headingXS = _base.copyWith(
    fontSize: 14,
    height: 18 / 14,
    fontWeight: weightBold,
  );

  static final TextStyle bodyM = _base.copyWith(
    fontSize: 14,
    height: 20 / 14,
    fontWeight: weightNormal,
  );

  static final TextStyle bodyS = _base.copyWith(
    fontSize: 12,
    height: 16 / 12,
    fontWeight: weightNormal,
  );

  static final TextStyle code = _mono.copyWith(fontSize: 13, height: 16 / 13);
}
