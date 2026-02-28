import 'package:flutter/material.dart';

/// Core color palette for Cloudscape Design System.
/// These should be used as primitives to build semantic tokens.
class CloudscapePalette {
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  // Grey / Neutral
  static const Color grey100 = Color(0xFFF2F3F3);
  static const Color grey200 = Color(0xFFEAEDED);
  static const Color grey300 = Color(0xFFD5DBDB);
  static const Color grey400 = Color(0xFFAAB7B7);
  static const Color grey500 = Color(0xFF879596);
  static const Color grey600 = Color(0xFF687777);
  static const Color grey700 = Color(0xFF545B64);
  static const Color grey800 = Color(0xFF232F3E);
  static const Color grey900 = Color(0xFF16191F);

  // Theme Backgrounds
  static const Color darkBg = Color(0xFF0F141A);
  static const Color darkContainer = Color(0xFF1B2129);

  // Blue / Primary
  static const Color blue100 = Color(0xFFF1FBFF);
  static const Color blue200 = Color(0xFFD6F0FF);
  static const Color blue300 = Color(0xFFA8DCFF);
  static const Color blue400 = Color(0xFF80CBFF);
  static const Color blue500 = Color(0xFF4DAFFF);
  static const Color blue600 = Color(0xFF0073BB);
  static const Color blue700 = Color(0xFF00619A);
  static const Color blue800 = Color(0xFF004D78);
  static const Color blue900 = Color(0xFF003D5B);

  // Red / Error
  static const Color red100 = Color(0xFFFFF5F5);
  static const Color red600 = Color(0xFFD13212);
  static const Color red700 = Color(0xFFAA260E);

  // Green / Success
  static const Color green100 = Color(0xFFF2F8F0);
  static const Color green600 = Color(0xFF1D8102);
  static const Color green700 = Color(0xFF166202);

  // Orange / Warning
  static const Color orange100 = Color(0xFFFFF9E6);
  static const Color orange600 = Color(0xFFFF9900);

  // Data Visualization Palette (Categorical)
  static const Color dataVizPriority1 = Color(0xFF0073BB);
  static const Color dataVizPriority2 = Color(0xFF1D8102);
  static const Color dataVizPriority3 = Color(0xFFD13212);
  static const Color dataVizPriority4 = Color(0xFF8C6A00);
  static const Color dataVizPriority5 = Color(0xFF047D64);
  static const Color dataVizPriority6 = Color(0xFFE07941);
  static const Color dataVizPriority7 = Color(0xFF526BA3);
  static const Color dataVizPriority8 = Color(0xFF8B5CF6);
  static const Color dataVizPriority9 = Color(0xFFED64A6);
  static const Color dataVizPriority10 = Color(0xFFF6AD55);

  static const List<Color> dataVizPalette = [
    dataVizPriority1,
    dataVizPriority2,
    dataVizPriority3,
    dataVizPriority4,
    dataVizPriority5,
    dataVizPriority6,
    dataVizPriority7,
    dataVizPriority8,
    dataVizPriority9,
    dataVizPriority10,
  ];
}

/// Semantic tokens for colors.
/// These will change based on the theme (Light/Dark).
class CloudscapeColors {
  final Color backgroundMain;
  final Color backgroundContainerMain;
  final Color backgroundContainerContent;
  final Color backgroundDropdownItemDefault;
  final Color backgroundDropdownItemHover;

  final Color textHeadingDefault;
  final Color textBodyDefault;
  final Color textBodySecondary;
  final Color textDescriptionDefault;
  final Color textLinkDefault;

  final Color borderDefault;
  final Color borderDividerDefault;

  final Color primaryMain;
  final Color statusErrorMain;
  final Color statusSuccessMain;
  final Color statusWarningMain;
  final Color statusInfoMain;

  final List<Color> dataVizPalette;

  const CloudscapeColors({
    required this.backgroundMain,
    required this.backgroundContainerMain,
    required this.backgroundContainerContent,
    required this.backgroundDropdownItemDefault,
    required this.backgroundDropdownItemHover,
    required this.textHeadingDefault,
    required this.textBodyDefault,
    required this.textBodySecondary,
    required this.textDescriptionDefault,
    required this.textLinkDefault,
    required this.borderDefault,
    required this.borderDividerDefault,
    required this.primaryMain,
    required this.statusErrorMain,
    required this.statusSuccessMain,
    required this.statusWarningMain,
    required this.statusInfoMain,
    required this.dataVizPalette,
  });

  factory CloudscapeColors.light() => const CloudscapeColors(
    backgroundMain: CloudscapePalette.white,
    backgroundContainerMain: CloudscapePalette.grey100,
    backgroundContainerContent: CloudscapePalette.white,
    backgroundDropdownItemDefault: CloudscapePalette.white,
    backgroundDropdownItemHover: CloudscapePalette.grey200,
    textHeadingDefault: CloudscapePalette.grey900,
    textBodyDefault: CloudscapePalette.grey700,
    textBodySecondary: CloudscapePalette.grey600,
    textDescriptionDefault: CloudscapePalette.grey600,
    textLinkDefault: CloudscapePalette.blue600,
    borderDefault: CloudscapePalette.grey300,
    borderDividerDefault: CloudscapePalette.grey200,
    primaryMain: CloudscapePalette.blue600,
    statusErrorMain: CloudscapePalette.red600,
    statusSuccessMain: CloudscapePalette.green600,
    statusWarningMain: CloudscapePalette.orange600,
    statusInfoMain: CloudscapePalette.blue600,
    dataVizPalette: CloudscapePalette.dataVizPalette,
  );

  factory CloudscapeColors.dark() => const CloudscapeColors(
    backgroundMain: CloudscapePalette.darkBg,
    backgroundContainerMain: CloudscapePalette.darkContainer,
    backgroundContainerContent: CloudscapePalette.darkContainer,
    backgroundDropdownItemDefault: CloudscapePalette.darkContainer,
    backgroundDropdownItemHover: Color(0xFF232F3E),
    textHeadingDefault: Color(0xFFF2F3F3),
    textBodyDefault: Color(0xFFD5DBDB),
    textBodySecondary: Color(0xFFAAB7B7),
    textDescriptionDefault: Color(0xFFAAB7B7),
    textLinkDefault: Color(0xFF80CBFF),
    borderDefault: Color(0xFF545B64),
    borderDividerDefault: Color(0xFF303F4F),
    primaryMain: Color(0xFF0073BB),
    statusErrorMain: Color(0xFFD13212),
    statusSuccessMain: Color(0xFF1D8102),
    statusWarningMain: Color(0xFFEB9400),
    statusInfoMain: Color(0xFF0073BB),
    dataVizPalette: CloudscapePalette.dataVizPalette,
  );
}
