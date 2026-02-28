import 'package:flutter/material.dart';

import '../../foundation/theme/cloudscape_theme.dart';
import '../../foundation/tokens/generated/cloudscape_tokens.dart';
import '../base/component_base.dart';

/// Represents a single item in the side navigation.
class SideNavigationItem {
  /// The textual label of the item.
  final String text;

  /// The destination reference (e.g. an ID or route).
  final String targetId;

  /// Whether this item is expanded. If non-null, this item acts as an expandable group.
  final bool? expanded;

  /// Nested child items.
  final List<SideNavigationItem>? items;

  const SideNavigationItem({
    required this.text,
    required this.targetId,
    this.expanded,
    this.items,
  });
}

/// Side Navigation Component.
class CloudscapeSideNavigation extends StatelessWidget {
  /// List of side navigation items.
  final List<SideNavigationItem> items;

  /// The actively focused item target ID.
  final String? activeTargetId;

  /// Callback to execute when a standard link is clicked.
  final ValueChanged<SideNavigationItem>? onFollow;

  /// Callback to execute when an expandable group is toggled.
  final ValueChanged<SideNavigationItem>? onExpandToggle;

  const CloudscapeSideNavigation({
    super.key,
    required this.items,
    this.activeTargetId,
    this.onFollow,
    this.onExpandToggle,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: items.map((item) => _buildItem(context, item, 0)).toList(),
    );
  }

  Widget _buildItem(BuildContext context, SideNavigationItem item, int level) {
    final colors = context.cloudscapeColors;
    final typography = context.cloudscapeTypography;
    final spacing = context.cloudscapeSpacing;

    final isActive = item.targetId == activeTargetId;
    final hasSubmenus = item.items != null && item.items!.isNotEmpty;
    final bool isExpanded = item.expanded ?? false;

    // Alignment Strategy:
    // 1. All text at the same level starts at the same vertical line.
    // 2. The expand icon (if present) is placed in a fixed-width gutter to the left.
    // 3. We use a consistent indentation per level.

    const double iconWidth = 20.0;
    const double iconGap = 8.0;
    final double levelIndent = level * 16.0; // Indent for nested items
    final double leftPadding = 8.0 + levelIndent; // Base padding from edge

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 2.0),
          child: ComponentsBase(
            builder: (context, isHovered) {
              final isInteracting = isHovered || isActive;

              final textStyle = typography.bodyM.copyWith(
                fontWeight: isActive
                    ? CloudscapeTokens.fontWeightButton
                    : typography.bodyM.fontWeight,
                color: isInteracting
                    ? Theme.of(context).colorScheme.primary
                    : colors.tokens.colorTextBodySecondary,
              );

              return GestureDetector(
                onTap: () {
                  if (hasSubmenus) {
                    onExpandToggle?.call(item);
                  } else {
                    onFollow?.call(item);
                  }
                },
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: leftPadding,
                    right: spacing.scaledM,
                    top: 6.0,
                    bottom: 6.0,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Submenu Gutter (Fixed Width ensures text alignment)
                      SizedBox(
                        width: iconWidth,
                        child: hasSubmenus
                            ? Icon(
                                isExpanded
                                    ? Icons.arrow_drop_down
                                    : Icons.arrow_right,
                                size: 24,
                                color: isInteracting
                                    ? Theme.of(context).colorScheme.primary
                                    : colors.tokens.colorTextBodySecondary,
                              )
                            : null,
                      ),
                      const SizedBox(width: iconGap),
                      Expanded(
                        child: Text(
                          item.text,
                          style: textStyle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            isButton: true,
          ),
        ),
        if (isExpanded && hasSubmenus)
          ...item.items!.map((child) => _buildItem(context, child, level + 1)),
      ],
    );
  }
}
