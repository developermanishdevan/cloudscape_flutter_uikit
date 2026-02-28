import 'package:flutter/material.dart';

import 'generated/cloudscape_tokens.dart';

class CloudscapeRadius extends ThemeExtension<CloudscapeRadius> {
  const CloudscapeRadius();

  double get alert => CloudscapeTokens.borderRadiusAlert;
  double get badge => CloudscapeTokens.borderRadiusBadge;
  double get button => CloudscapeTokens.borderRadiusButton;
  double get calendarDayFocusRing =>
      CloudscapeTokens.borderRadiusCalendarDayFocusRing;
  double get container => CloudscapeTokens.borderRadiusContainer;
  double get controlCircularFocusRing =>
      CloudscapeTokens.borderRadiusControlCircularFocusRing;
  double get controlDefaultFocusRing =>
      CloudscapeTokens.borderRadiusControlDefaultFocusRing;
  double get dropdown => CloudscapeTokens.borderRadiusDropdown;
  double get dropzone => CloudscapeTokens.borderRadiusDropzone;
  double get flashbar => CloudscapeTokens.borderRadiusFlashbar;
  double get item => CloudscapeTokens.borderRadiusItem;
  double get input => CloudscapeTokens.borderRadiusInput;
  double get popover => CloudscapeTokens.borderRadiusPopover;
  double get tabsFocusRing => CloudscapeTokens.borderRadiusTabsFocusRing;
  double get tiles => CloudscapeTokens.borderRadiusTiles;
  double get token => CloudscapeTokens.borderRadiusToken;
  double get chatBubble => CloudscapeTokens.borderRadiusChatBubble;
  double get tutorialPanelItem =>
      CloudscapeTokens.borderRadiusTutorialPanelItem;

  @override
  ThemeExtension<CloudscapeRadius> copyWith() => const CloudscapeRadius();

  @override
  ThemeExtension<CloudscapeRadius> lerp(
    ThemeExtension<CloudscapeRadius>? other,
    double t,
  ) {
    return this;
  }
}
