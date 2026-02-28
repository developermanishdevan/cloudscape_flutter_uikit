import 'package:flutter/material.dart';

import 'generated/cloudscape_tokens.dart';

class CloudscapeColors extends ThemeExtension<CloudscapeColors> {
  final CloudscapeColorTokens tokens;

  const CloudscapeColors({required this.tokens});

  factory CloudscapeColors.light() =>
      CloudscapeColors(tokens: CloudscapeColorTokens.light());
  factory CloudscapeColors.dark() =>
      CloudscapeColors(tokens: CloudscapeColorTokens.dark());

  @override
  ThemeExtension<CloudscapeColors> copyWith({CloudscapeColorTokens? tokens}) {
    return CloudscapeColors(tokens: tokens ?? this.tokens);
  }

  @override
  ThemeExtension<CloudscapeColors> lerp(
    ThemeExtension<CloudscapeColors>? other,
    double t,
  ) {
    if (other is! CloudscapeColors) return this;
    // Fast step lerp for colors given the high volume of tokens
    return t < 0.5 ? this : other;
  }
}
