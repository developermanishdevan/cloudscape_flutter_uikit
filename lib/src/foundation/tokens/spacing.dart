/// Spacing tokens for consistent rhythm and clarity.
class CloudscapeSpacing {
  /// 2 pixels
  static const double xxxSmall = 2;

  /// 4 pixels
  static const double xxSmall = 4;

  /// 8 pixels
  static const double xSmall = 8;

  /// 12 pixels
  static const double small = 12;

  /// 16 pixels
  static const double medium = 16;

  /// 20 pixels
  static const double large = 20;

  /// 24 pixels
  static const double xLarge = 24;

  /// 32 pixels
  static const double xxLarge = 32;

  /// 40 pixels
  static const double xxxLarge = 40;

  /// Standard spacing scale used by Cloudscape components.
  static const Map<String, double> scale = {
    'xs': xxxSmall,
    's': xxSmall,
    'm': xSmall,
    'l': small,
    'xl': medium,
    'xxl': large,
  };
}
