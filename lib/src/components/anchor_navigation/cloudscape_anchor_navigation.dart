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

  /// Whether this item is expanded. If non-null, this item acts as an expandable group.
  final bool? expanded;

  const AnchorNavigationItem({
    required this.text,
    required this.targetId,
    this.level = 1,
    this.info,
    this.expanded,
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

  /// Whether to display the grey visual vertical track. Defaults to true.
  final bool showTrack;

  const CloudscapeAnchorNavigation({
    super.key,
    required this.anchors,
    this.activeTargetId,
    this.onFollow,
    this.ariaLabelledby,
    this.showTrack = true,
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
          if (showTrack)
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
            children: _buildVisibleAnchors(),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildVisibleAnchors() {
    final visibleWidgets = <Widget>[];
    bool hideCurrentLevel = false;
    int hiddenLevelThreshold = 0;

    for (int i = 0; i < anchors.length; i++) {
      final anchor = anchors[i];

      if (hideCurrentLevel) {
        if (anchor.level <= hiddenLevelThreshold) {
          hideCurrentLevel = false;
        } else {
          continue;
        }
      }

      if (anchor.expanded == false) {
        hideCurrentLevel = true;
        hiddenLevelThreshold = anchor.level;
      }

      final isActive = anchor.targetId == activeTargetId;
      visibleWidgets.add(
        _AnchorItemWidget(
          anchor: anchor,
          isActive: isActive,
          showTrack: showTrack,
          onFollow: onFollow,
        ),
      );
    }
    return visibleWidgets;
  }
}

class _AnchorItemWidget extends StatelessWidget {
  final AnchorNavigationItem anchor;
  final bool isActive;
  final bool showTrack;
  final ValueChanged<AnchorNavigationItem>? onFollow;

  const _AnchorItemWidget({
    required this.anchor,
    required this.isActive,
    required this.showTrack,
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
          if (isActive && showTrack)
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

              final double calculatedLeftPadding = (anchor.level * 16.0) + 2.0;

              return GestureDetector(
                onTap: () => onFollow?.call(anchor),
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: EdgeInsets.only(left: calculatedLeftPadding),
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.centerLeft,
                    children: [
                      if (anchor.expanded != null)
                        Positioned(
                          left: -24,
                          child: Icon(
                            anchor.expanded!
                                ? Icons.arrow_drop_down
                                : Icons.arrow_right,
                            size: 20,
                            color: isInteracting
                                ? colors.tokens.colorTextAccent
                                : colors.tokens.colorTextBodySecondary,
                          ),
                        ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
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
