import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../tokens/cloudscape_palette.dart';

/// Categorized colors that change automatically based on the theme (Light/Dark).
///
/// Use [CloudscapeDynamicColors] for all UI components that need to be theme-aware.
class CloudscapeDynamicColors with Diagnosticable {
  const CloudscapeDynamicColors({
    required this.brightness,
    required this.backgrounds,
    required this.text,
    required this.borders,
    required this.status,
    required this.charts,
  });

  final Brightness brightness;

  final CloudscapeBackgroundColors backgrounds;
  final CloudscapeTextColors text;
  final CloudscapeBorderColors borders;
  final CloudscapeStatusColors status;
  final CloudscapeChartColors charts;

  factory CloudscapeDynamicColors.light({Color? brandColor}) =>
      CloudscapeDynamicColors(
        brightness: Brightness.light,
        backgrounds: CloudscapeBackgroundColors.light(primary: brandColor),
        text: CloudscapeTextColors.light(primary: brandColor),
        borders: CloudscapeBorderColors.light(primary: brandColor),
        status: CloudscapeStatusColors.light(primary: brandColor),
        charts: const CloudscapeChartColors.light(),
      );

  factory CloudscapeDynamicColors.dark({Color? brandColor}) =>
      CloudscapeDynamicColors(
        brightness: Brightness.dark,
        backgrounds: CloudscapeBackgroundColors.dark(primary: brandColor),
        text: CloudscapeTextColors.dark(primary: brandColor),
        borders: CloudscapeBorderColors.dark(primary: brandColor),
        status: CloudscapeStatusColors.dark(primary: brandColor),
        charts: const CloudscapeChartColors.dark(),
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(EnumProperty<Brightness>('brightness', brightness));
    properties.add(DiagnosticsProperty('backgrounds', backgrounds));
    properties.add(DiagnosticsProperty('text', text));
    properties.add(DiagnosticsProperty('borders', borders));
    properties.add(DiagnosticsProperty('status', status));
  }
}

class CloudscapeBackgroundColors with Diagnosticable {
  const CloudscapeBackgroundColors({
    required this.layoutMain,
    required this.containerContent,
    required this.containerHeader,
    required this.controlDefault,
    required this.controlChecked,
    required this.controlDisabled,
    required this.inputDefault,
    required this.inputDisabled,
    required this.buttonNormalDefault,
    required this.buttonNormalHover,
    required this.buttonNormalActive,
    required this.buttonNormalDisabled,
    required this.buttonPrimaryDefault,
    required this.buttonPrimaryHover,
    required this.buttonPrimaryActive,
    required this.buttonPrimaryDisabled,
    required this.dropdownItemHover,
  });

  final Color layoutMain;
  final Color containerContent;
  final Color containerHeader;
  final Color controlDefault;
  final Color controlChecked;
  final Color controlDisabled;
  final Color inputDefault;
  final Color inputDisabled;
  final Color buttonNormalDefault;
  final Color buttonNormalHover;
  final Color buttonNormalActive;
  final Color buttonNormalDisabled;
  final Color buttonPrimaryDefault;
  final Color buttonPrimaryHover;
  final Color buttonPrimaryActive;
  final Color buttonPrimaryDisabled;
  final Color dropdownItemHover;

  const CloudscapeBackgroundColors.light({Color? primary})
    : layoutMain = CloudscapePalette.white,
      containerContent = CloudscapePalette.white,
      containerHeader = CloudscapePalette.white,
      controlDefault = CloudscapePalette.white,
      controlChecked = primary ?? CloudscapePalette.blue500,
      controlDisabled = CloudscapePalette.grey300,
      inputDefault = CloudscapePalette.white,
      inputDisabled = CloudscapePalette.grey200,
      buttonNormalDefault = CloudscapePalette.white,
      buttonNormalHover = CloudscapePalette.blue200,
      buttonNormalActive = CloudscapePalette.blue300,
      buttonNormalDisabled = CloudscapePalette.white,
      buttonPrimaryDefault = primary ?? CloudscapePalette.blue500,
      buttonPrimaryHover = primary ?? CloudscapePalette.blue850,
      buttonPrimaryActive = primary ?? CloudscapePalette.blue850,
      buttonPrimaryDisabled = CloudscapePalette.grey250,
      dropdownItemHover = CloudscapePalette.grey150;

  const CloudscapeBackgroundColors.dark({Color? primary})
    : layoutMain = CloudscapePalette.grey1000,
      containerContent = CloudscapePalette.grey1000,
      containerHeader = CloudscapePalette.grey1000,
      controlDefault = CloudscapePalette.grey1000,
      controlChecked = primary ?? CloudscapePalette.blue400,
      controlDisabled = CloudscapePalette.grey700,
      inputDefault = CloudscapePalette.grey1000,
      inputDisabled = CloudscapePalette.grey800,
      buttonNormalDefault = CloudscapePalette.grey1000,
      buttonNormalHover = CloudscapePalette.grey800,
      buttonNormalActive = CloudscapePalette.grey700,
      buttonNormalDisabled = CloudscapePalette.grey1000,
      buttonPrimaryDefault = primary ?? CloudscapePalette.blue400,
      buttonPrimaryHover = primary ?? CloudscapePalette.blue300,
      buttonPrimaryActive = primary ?? CloudscapePalette.blue400,
      buttonPrimaryDisabled = CloudscapePalette.grey950,
      dropdownItemHover = CloudscapePalette.grey950;
}

class CloudscapeTextColors with Diagnosticable {
  const CloudscapeTextColors({
    required this.bodyDefault,
    required this.bodySecondary,
    required this.headingDefault,
    required this.headingSecondary,
    required this.label,
    required this.linkDefault,
    required this.linkHover,
    required this.onPrimary,
    required this.interactiveDefault,
    required this.interactiveDisabled,
  });

  final Color bodyDefault;
  final Color bodySecondary;
  final Color headingDefault;
  final Color headingSecondary;
  final Color label;
  final Color linkDefault;
  final Color linkHover;
  final Color onPrimary;
  final Color interactiveDefault;
  final Color interactiveDisabled;

  const CloudscapeTextColors.light({Color? primary})
    : bodyDefault = CloudscapePalette.grey1000,
      bodySecondary = CloudscapePalette.grey500,
      headingDefault = CloudscapePalette.grey1000,
      headingSecondary = CloudscapePalette.grey500,
      label = CloudscapePalette.grey1000,
      linkDefault = primary ?? CloudscapePalette.blue500,
      linkHover = primary ?? CloudscapePalette.blue850,
      onPrimary = CloudscapePalette.white,
      interactiveDefault = primary ?? CloudscapePalette.blue500,
      interactiveDisabled = CloudscapePalette.grey450;

  const CloudscapeTextColors.dark({Color? primary})
    : bodyDefault = CloudscapePalette.grey450,
      bodySecondary = CloudscapePalette.grey450,
      headingDefault = CloudscapePalette.grey250,
      headingSecondary = CloudscapePalette.grey650,
      label = CloudscapePalette.grey350,
      linkDefault = primary ?? CloudscapePalette.blue400,
      linkHover = primary ?? CloudscapePalette.blue300,
      onPrimary = CloudscapePalette.grey1000,
      interactiveDefault = primary ?? CloudscapePalette.blue400,
      interactiveDisabled = CloudscapePalette.grey850;
}

class CloudscapeBorderColors with Diagnosticable {
  const CloudscapeBorderColors({
    required this.dividerDefault,
    required this.dividerSecondary,
    required this.controlDefault,
    required this.inputDefault,
    required this.inputFocused,
    required this.dropdownContainer,
    required this.dropdownItemHover,
  });

  final Color dividerDefault;
  final Color dividerSecondary;
  final Color controlDefault;
  final Color inputDefault;
  final Color inputFocused;
  final Color dropdownContainer;
  final Color dropdownItemHover;

  const CloudscapeBorderColors.light({Color? primary})
    : dividerDefault = CloudscapePalette.grey200,
      dividerSecondary = CloudscapePalette.grey300,
      controlDefault = CloudscapePalette.grey400,
      inputDefault = CloudscapePalette.grey400,
      inputFocused = primary ?? CloudscapePalette.blue500,
      dropdownContainer = CloudscapePalette.grey550,
      dropdownItemHover = CloudscapePalette.grey600;

  const CloudscapeBorderColors.dark({Color? primary})
    : dividerDefault = CloudscapePalette.grey600,
      dividerSecondary = CloudscapePalette.grey950,
      controlDefault = CloudscapePalette.grey750,
      inputDefault = CloudscapePalette.grey600,
      inputFocused = primary ?? CloudscapePalette.blue400,
      dropdownContainer = CloudscapePalette.grey600,
      dropdownItemHover = CloudscapePalette.grey250;
}

class CloudscapeStatusColors with Diagnosticable {
  const CloudscapeStatusColors({
    required this.error,
    required this.errorBackground,
    required this.errorBorder,
    required this.success,
    required this.successBackground,
    required this.successBorder,
    required this.info,
    required this.infoBackground,
    required this.infoBorder,
    required this.warning,
    required this.warningBackground,
    required this.warningBorder,
  });

  final Color error;
  final Color errorBackground;
  final Color errorBorder;

  final Color success;
  final Color successBackground;
  final Color successBorder;

  final Color info;
  final Color infoBackground;
  final Color infoBorder;

  final Color warning;
  final Color warningBackground;
  final Color warningBorder;

  const CloudscapeStatusColors.light({Color? primary})
    : error = CloudscapePalette.red600,
      errorBackground = CloudscapePalette.red100,
      errorBorder = CloudscapePalette.red600,
      success = CloudscapePalette.green600,
      successBackground = CloudscapePalette.green100,
      successBorder = CloudscapePalette.green600,
      info = primary ?? CloudscapePalette.blue500,
      infoBackground = CloudscapePalette.blue100,
      infoBorder = CloudscapePalette.blue500,
      warning = CloudscapePalette.orange600,
      warningBackground = CloudscapePalette.yellow100,
      warningBorder = CloudscapePalette.yellow600;

  const CloudscapeStatusColors.dark({Color? primary})
    : error = CloudscapePalette.red400,
      errorBackground = CloudscapePalette.grey1000,
      errorBorder = CloudscapePalette.red400,
      success = CloudscapePalette.green400,
      successBackground = CloudscapePalette.grey1000,
      successBorder = CloudscapePalette.green400,
      info = primary ?? CloudscapePalette.blue400,
      infoBackground = CloudscapePalette.blue900,
      infoBorder = primary ?? CloudscapePalette.blue400,
      warning = CloudscapePalette.yellow400,
      warningBackground = CloudscapePalette.grey1000,
      warningBorder = CloudscapePalette.yellow400;
}

class CloudscapeChartColors with Diagnosticable {
  const CloudscapeChartColors({
    required this.red,
    required this.green,
    required this.blue,
  });

  final Color red;
  final Color green;
  final Color blue;

  const CloudscapeChartColors.light()
    : red = const Color(0xFFD13212),
      green = const Color(0xFF1D8102),
      blue = const Color(0xFF0073BB);

  const CloudscapeChartColors.dark()
    : red = const Color(0xFFFE6E73),
      green = const Color(0xFF69AE34),
      blue = const Color(0xFF42B4FF);
}
