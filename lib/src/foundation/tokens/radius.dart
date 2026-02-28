import 'package:flutter/material.dart';

/// Border radius tokens for Cloudscape Design System.
class CloudscapeRadius {
  /// 2 pixels
  static const double xxSmall = 2;

  /// 4 pixels
  static const double xSmall = 4;

  /// 8 pixels
  static const double small = 8;

  /// 12 pixels
  static const double medium = 12;

  /// 16 pixels
  static const double large = 16;

  /// 20 pixels
  static const double xLarge = 20;

  /// Full pill shape (high value)
  static const double pill = 999;

  static const BorderRadius brXXSmall = BorderRadius.all(
    Radius.circular(xxSmall),
  );
  static const BorderRadius brXSmall = BorderRadius.all(
    Radius.circular(xSmall),
  );
  static const BorderRadius brSmall = BorderRadius.all(Radius.circular(small));
  static const BorderRadius brMedium = BorderRadius.all(
    Radius.circular(medium),
  );
  static const BorderRadius brLarge = BorderRadius.all(Radius.circular(large));
}
