import 'package:flutter/material.dart';

import 'generated/cloudscape_tokens.dart';

/// A ThemeExtension that exposes all Cloudscape border-width tokens.
class CloudscapeBorderWidth extends ThemeExtension<CloudscapeBorderWidth> {
  const CloudscapeBorderWidth();

  double get alert => CloudscapeTokens.borderWidthAlert;
  double get button => CloudscapeTokens.borderWidthButton;
  double get dropdown => CloudscapeTokens.borderWidthDropdown;
  double get field => CloudscapeTokens.borderWidthField;
  double get container => CloudscapeTokens.borderWidthContainer;

  @override
  ThemeExtension<CloudscapeBorderWidth> copyWith() =>
      const CloudscapeBorderWidth();

  @override
  ThemeExtension<CloudscapeBorderWidth> lerp(
    ThemeExtension<CloudscapeBorderWidth>? other,
    double t,
  ) {
    return this;
  }
}
