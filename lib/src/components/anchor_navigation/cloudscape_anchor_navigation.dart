import 'package:flutter/material.dart';

import '../../foundation/theme/cloudscape_theme.dart';
import '../../foundation/tokens/generated/cloudscape_tokens.dart';
import '../base/component_base.dart';

/// Represents a single navigation anchor.
class AnchorNavigationItem {
  /// The textual label of the anchor item.
  final String text;

  /// The destination reference (e.g. an ID selector).
  final String targetId;

  /// The level of nesting, starting from 1 for top-level anchors.
  final int level;

  /// Additional semantic info pill to append alongside the text (e.g. `New`).
  final String? info;

  const AnchorNavigationItem({
    required this.text,
    required this.targetId,
    this.level = 1,
    this.info,
  });
}

/// Anchor Navigation Component based on Cloudscape Visual Refresh specs.
class CloudscapeAnchorNavigation extends StatelessWidget {
  /// List of sorted anchor objects representing the page layout.
  final List<AnchorNavigationItem> anchors;

  /// The actively focused anchor target ID.
  final String? activeTargetId;

  /// Callback to execute when an anchor is clicked.
  final ValueChanged<AnchorNavigationItem>? onFollow;

  /// Screen-reader label for the root navigation structure.
  final String? ariaLabelledby;

  const CloudscapeAnchorNavigation({
    super.key,
    required this.anchors,
    this.activeTargetId,
    this.onFollow,
    this.ariaLabelledby,
  });

  @override
  Widget build(BuildContext context) {
    if (anchors.isEmpty) return const SizedBox.shrink();

    final colors = context.cloudscapeColors;
    final radius = context.cloudscapeRadius;

    return Semantics(
      label: ariaLabelledby,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // The grey track extending the entire height
          Positioned(
            left: 0,
            top: -2,
            bottom: -2,
            child: Container(
              width: 2,
              decoration: BoxDecoration(
                color: colors.tokens.colorBorderDividerDefault,
                borderRadius: BorderRadius.circular(radius.tabsFocusRing),
              ),
            ),
          ),

          // The anchors
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: anchors.map((anchor) {
              final isActive = anchor.targetId == activeTargetId;

              return _AnchorItemWidget(
                anchor: anchor,
                isActive: isActive,
                onFollow: onFollow,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _AnchorItemWidget extends StatelessWidget {
  final AnchorNavigationItem anchor;
  final bool isActive;
  final ValueChanged<AnchorNavigationItem>? onFollow;

  const _AnchorItemWidget({
    required this.anchor,
    required this.isActive,
    required this.onFollow,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.cloudscapeColors;
    final spacing = context.cloudscapeSpacing;
    final typography = context.cloudscapeTypography;
    final radius = context.cloudscapeRadius;

    return Container(
      // Margin block simulates margin-block: awsui.$space-scaled-xxs (4px)
      // Since HTML margin collapses, we divide by 2 to align items exactly 4px apart
      margin: EdgeInsets.symmetric(vertical: spacing.scaledXxs / 2),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          if (isActive)
            Positioned(
              left: 0,
              top: -2, // Expand out beyond the container bounding box
              bottom: -2,
              child: Container(
                width: 2,
                decoration: BoxDecoration(
                  color: colors.tokens.colorTextAccent,
                  borderRadius: BorderRadius.circular(radius.tabsFocusRing),
                ),
              ),
            ),
          ComponentsBase(
            builder: (context, isHovered) {
              final isInteracting = isHovered || isActive;

              final textStyle = typography.bodyM.copyWith(
                fontWeight: isActive
                    ? CloudscapeTokens
                          .fontWeightButton // approximate 700 bold weight
                    : typography.bodyM.fontWeight,
                color: isInteracting
                    ? colors.tokens.colorTextAccent
                    : colors.tokens.colorTextBodySecondary,
              );

              return GestureDetector(
                onTap: () => onFollow?.call(anchor),
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: EdgeInsets.only(left: (anchor.level * 16.0) + 2.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(anchor.text, style: textStyle),
                      if (anchor.info != null) ...[
                        SizedBox(width: spacing.scaledXs),
                        Text(
                          anchor.info!,
                          style: typography.bodyS.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colors.tokens.colorTextLinkDefault,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
            isButton: true,
          ),
        ],
      ),
    );
  }
}
