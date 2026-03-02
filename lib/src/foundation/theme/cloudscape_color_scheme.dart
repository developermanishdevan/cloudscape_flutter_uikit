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

  factory CloudscapeDynamicColors.light({Color? brandColor}) {
    final Color primary = brandColor ?? CloudscapePalette.blue500;
    final hsl = HSLColor.fromColor(primary);

    // shades/tints for brand states
    final primaryHover = hsl
        .withLightness((hsl.lightness - 0.08).clamp(0.0, 1.0))
        .toColor();
    final primaryActive = hsl
        .withLightness((hsl.lightness - 0.12).clamp(0.0, 1.0))
        .toColor();
    final linkHover = hsl
        .withLightness((hsl.lightness - 0.15).clamp(0.0, 1.0))
        .toColor();

    // Normal button subtle tints (using opacity for 'reduced' color complexity)
    final normalHover = primary.withValues(alpha: 0.08);
    final normalActive = primary.withValues(alpha: 0.15);

    return CloudscapeDynamicColors(
      brightness: Brightness.light,
      backgrounds: CloudscapeBackgroundColors.light(
        primary: primary,
        primaryHover: primaryHover,
        primaryActive: primaryActive,
        normalHover: normalHover,
        normalActive: normalActive,
      ),
      text: CloudscapeTextColors.light(primary: primary, linkHover: linkHover),
      borders: CloudscapeBorderColors.light(primary: primary),
      status: CloudscapeStatusColors.light(primary: primary),
      charts: const CloudscapeChartColors.light(),
    );
  }

  factory CloudscapeDynamicColors.dark({Color? brandColor}) {
    final Color primary = brandColor ?? CloudscapePalette.blue400;
    final hsl = HSLColor.fromColor(primary);

    // Dark mode hover should feel more vibrant
    final primaryHover = hsl
        .withLightness((hsl.lightness + 0.12).clamp(0.0, 1.0))
        .withSaturation((hsl.saturation + 0.05).clamp(0.0, 1.0))
        .toColor();
    final primaryActive = hsl
        .withLightness((hsl.lightness + 0.05).clamp(0.0, 1.0))
        .toColor();

    // Branded hover for normal buttons (subtle tint for dark mode)
    final normalHover = primary.withValues(alpha: 0.12);
    final normalActive = primary.withValues(alpha: 0.18);

    // Link hover for dark mode (vibrant version of brand primary)
    final textLinkHover = hsl
        .withLightness((hsl.lightness + 0.15).clamp(0.0, 1.0))
        .withSaturation((hsl.saturation + 0.1).clamp(0.0, 1.0))
        .toColor();

    return CloudscapeDynamicColors(
      brightness: Brightness.dark,
      backgrounds: CloudscapeBackgroundColors.dark(
        primary: primary,
        primaryHover: primaryHover,
        primaryActive: primaryActive,
        normalHover: normalHover,
        normalActive: normalActive,
      ),
      text: CloudscapeTextColors.dark(
        primary: primary,
        linkHover: textLinkHover,
      ),
      borders: CloudscapeBorderColors.dark(primary: primary),
      status: CloudscapeStatusColors.dark(primary: primary),
      charts: const CloudscapeChartColors.dark(),
    );
  }

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

  const CloudscapeBackgroundColors.light({
    Color? primary,
    Color? primaryHover,
    Color? primaryActive,
    Color? normalHover,
    Color? normalActive,
  }) : layoutMain = CloudscapePalette.white,
       containerContent = CloudscapePalette.white,
       containerHeader = CloudscapePalette.white,
       controlDefault = CloudscapePalette.white,
       controlChecked = primary ?? CloudscapePalette.blue500,
       controlDisabled = CloudscapePalette.grey300,
       inputDefault = CloudscapePalette.white,
       inputDisabled = CloudscapePalette.grey200,
       buttonNormalDefault = CloudscapePalette.white,
       buttonNormalHover = normalHover ?? CloudscapePalette.blue200,
       buttonNormalActive = normalActive ?? CloudscapePalette.blue300,
       buttonNormalDisabled = CloudscapePalette.white,
       buttonPrimaryDefault = primary ?? CloudscapePalette.blue500,
       buttonPrimaryHover = primaryHover ?? CloudscapePalette.blue700,
       buttonPrimaryActive = primaryActive ?? CloudscapePalette.blue800,
       buttonPrimaryDisabled = CloudscapePalette.grey250,
       dropdownItemHover = CloudscapePalette.grey150;

  const CloudscapeBackgroundColors.dark({
    Color? primary,
    Color? primaryHover,
    Color? primaryActive,
    Color? normalHover,
    Color? normalActive,
  }) : layoutMain = CloudscapePalette.grey1000,
       containerContent = CloudscapePalette.grey1000,
       containerHeader = CloudscapePalette.grey1000,
       controlDefault = CloudscapePalette.grey1000,
       controlChecked = primary ?? CloudscapePalette.blue400,
       controlDisabled = CloudscapePalette.grey700,
       inputDefault = CloudscapePalette.grey1000,
       inputDisabled = CloudscapePalette.grey800,
       buttonNormalDefault = CloudscapePalette.grey1000,
       buttonNormalHover = normalHover ?? CloudscapePalette.grey800,
       buttonNormalActive = normalActive ?? CloudscapePalette.grey700,
       buttonNormalDisabled = CloudscapePalette.grey1000,
       buttonPrimaryDefault = primary ?? CloudscapePalette.blue400,
       buttonPrimaryHover = primaryHover ?? CloudscapePalette.blue300,
       buttonPrimaryActive = primaryActive ?? CloudscapePalette.blue400,
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
    required this.onStatusError,
    required this.onStatusSuccess,
    required this.onStatusInfo,
    required this.onStatusWarning,
    required this.interactiveDefault,
    required this.interactiveDisabled,
    required this.interactiveActive,
    required this.interactiveHover,
  });

  final Color bodyDefault;
  final Color bodySecondary;
  final Color headingDefault;
  final Color headingSecondary;
  final Color label;
  final Color linkDefault;
  final Color linkHover;
  final Color onPrimary;
  final Color onStatusError;
  final Color onStatusSuccess;
  final Color onStatusInfo;
  final Color onStatusWarning;
  final Color interactiveDefault;
  final Color interactiveDisabled;
  final Color interactiveActive;
  final Color interactiveHover;

  const CloudscapeTextColors.light({Color? primary, Color? linkHover})
    : bodyDefault = CloudscapePalette.grey800,
      bodySecondary = CloudscapePalette.grey500,
      headingDefault = CloudscapePalette.black,
      headingSecondary = CloudscapePalette.grey500,
      label = CloudscapePalette.grey1000,
      linkDefault = primary ?? CloudscapePalette.blue500,
      linkHover = linkHover ?? primary ?? CloudscapePalette.blue850,
      onPrimary = CloudscapePalette.white,
      onStatusError = CloudscapePalette.white,
      onStatusSuccess = CloudscapePalette.white,
      onStatusInfo = CloudscapePalette.white,
      onStatusWarning = CloudscapePalette.black,
      interactiveDefault = primary ?? CloudscapePalette.blue500,
      interactiveDisabled = CloudscapePalette.grey450,
      interactiveActive = CloudscapePalette.black,
      interactiveHover = CloudscapePalette.black;

  const CloudscapeTextColors.dark({Color? primary, Color? linkHover})
    : bodyDefault = CloudscapePalette.grey250,
      bodySecondary = CloudscapePalette.grey450,
      headingDefault = CloudscapePalette.white,
      headingSecondary = CloudscapePalette.grey450,
      label = CloudscapePalette.grey350,
      linkDefault = primary ?? CloudscapePalette.blue400,
      linkHover = linkHover ?? primary ?? CloudscapePalette.blue300,
      onPrimary = CloudscapePalette.black,
      onStatusError = CloudscapePalette.white,
      onStatusSuccess = CloudscapePalette.white,
      onStatusInfo = CloudscapePalette.white,
      onStatusWarning = CloudscapePalette.black,
      interactiveDefault = primary ?? CloudscapePalette.blue400,
      interactiveDisabled = CloudscapePalette.grey550,
      interactiveActive = CloudscapePalette.white,
      interactiveHover = CloudscapePalette.white;
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
      info = CloudscapePalette.blue500,
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
      info = CloudscapePalette.blue400,
      infoBackground = CloudscapePalette.blue900,
      infoBorder = CloudscapePalette.blue400,
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
