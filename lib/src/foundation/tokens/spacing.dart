import 'package:flutter/material.dart';

import 'generated/cloudscape_tokens.dart';

class CloudscapeSpacing extends ThemeExtension<CloudscapeSpacing> {
  const CloudscapeSpacing();

  // Margins & Paddings
  double get containerHorizontal => CloudscapeTokens.spaceContainerHorizontal;
  double get fieldHorizontal => CloudscapeTokens.spaceFieldHorizontal;
  double get treeViewIndentation => CloudscapeTokens.spaceTreeViewIndentation;

  // Scaled SPACING
  double get scaledXxxs => CloudscapeTokens.spaceScaledXxxs;
  double get scaledXxs => CloudscapeTokens.spaceScaledXxs;
  double get scaledXs => CloudscapeTokens.spaceScaledXs;
  double get scaledS => CloudscapeTokens.spaceScaledS;
  double get scaledM => CloudscapeTokens.spaceScaledM;
  double get scaledL => CloudscapeTokens.spaceScaledL;
  double get scaledXl => CloudscapeTokens.spaceScaledXl;
  double get scaledXxl => CloudscapeTokens.spaceScaledXxl;
  double get scaledXxxl => CloudscapeTokens.spaceScaledXxxl;

  // Static SPACING
  double get staticXxxs => CloudscapeTokens.spaceStaticXxxs;
  double get staticXxs => CloudscapeTokens.spaceStaticXxs;
  double get staticXs => CloudscapeTokens.spaceStaticXs;
  double get staticS => CloudscapeTokens.spaceStaticS;
  double get staticM => CloudscapeTokens.spaceStaticM;
  double get staticL => CloudscapeTokens.spaceStaticL;
  double get staticXl => CloudscapeTokens.spaceStaticXl;
  double get staticXxl => CloudscapeTokens.spaceStaticXxl;
  double get staticXxxl => CloudscapeTokens.spaceStaticXxxl;

  @override
  ThemeExtension<CloudscapeSpacing> copyWith() => const CloudscapeSpacing();

  @override
  ThemeExtension<CloudscapeSpacing> lerp(
    ThemeExtension<CloudscapeSpacing>? other,
    double t,
  ) {
    return this;
  }
}
