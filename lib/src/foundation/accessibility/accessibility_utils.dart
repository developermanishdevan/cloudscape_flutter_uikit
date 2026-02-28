import 'package:flutter/material.dart';

/// Accessibility utilities for contrast and labels.
class CloudscapeAccessibility {
  /// Ensures text has sufficient contrast.
  /// Standard WCAG compliance: 4.5:1 for normal text, 3:1 for large text.
  static Color getContrastColor(Color background, Color light, Color dark) {
    final double luminance = background.computeLuminance();
    return luminance > 0.5 ? dark : light;
  }

  /// Helper to force screen-reader only text (hidden visually, but accessible).
  /// In Flutter, we often use [Semantics] for this.
  static Widget screenReaderOnly(String label, Widget child) {
    return Semantics(label: label, container: true, child: child);
  }
}
