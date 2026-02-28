import 'package:flutter/material.dart';

import '../../foundation/theme/cloudscape_theme.dart';
import '../base/component_base.dart';

/// Represents a single item in a breadcrumb group.
class BreadcrumbItem {
  /// The textual label of the breadcrumb.
  final String text;

  /// The destination reference or ID.
  final String href;

  const BreadcrumbItem({required this.text, required this.href});
}

/// A breadcrumb group provides a list of links that help users keep track of
/// their location within an application.
class CloudscapeBreadcrumbGroup extends StatelessWidget {
  /// The list of items to display in the breadcrumb group.
  final List<BreadcrumbItem> items;

  /// Callback when a breadcrumb item is clicked.
  final ValueChanged<BreadcrumbItem>? onFollow;

  /// Accessibility label for the breadcrumb group.
  final String? ariaLabel;

  const CloudscapeBreadcrumbGroup({
    super.key,
    this.items = const [],
    this.onFollow,
    this.ariaLabel,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    return Semantics(
      label: ariaLabel,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: _buildItems(context),
      ),
    );
  }

  List<Widget> _buildItems(BuildContext context) {
    final widgets = <Widget>[];
    final colors = context.cloudscapeColors;
    final spacing = context.cloudscapeSpacing;

    for (int i = 0; i < items.length; i++) {
      final item = items[i];
      final isLast = i == items.length - 1;

      widgets.add(
        _BreadcrumbItemWidget(item: item, isLast: isLast, onFollow: onFollow),
      );

      if (!isLast) {
        widgets.add(
          Padding(
            padding: EdgeInsets.symmetric(horizontal: spacing.scaledXxs),
            child: Icon(
              Icons.chevron_right,
              size: 20,
              color: colors.text.bodySecondary,
            ),
          ),
        );
      }
    }

    return widgets;
  }
}

class _BreadcrumbItemWidget extends StatelessWidget {
  final BreadcrumbItem item;
  final bool isLast;
  final ValueChanged<BreadcrumbItem>? onFollow;

  const _BreadcrumbItemWidget({
    required this.item,
    required this.isLast,
    this.onFollow,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.cloudscapeColors;
    final typography = context.cloudscapeTypography;

    if (isLast) {
      return Text(
        item.text,
        style: typography.bodyM.copyWith(color: colors.text.bodyDefault),
      );
    }

    return ComponentsBase(
      isButton: true,
      builder: (context, isHovered) {
        return GestureDetector(
          onTap: () => onFollow?.call(item),
          child: Text(
            item.text,
            style: typography.bodyM.copyWith(
              color: isHovered
                  ? colors.text.linkHover
                  : colors.text.linkDefault,
              decoration: isHovered
                  ? TextDecoration.underline
                  : TextDecoration.none,
              decorationColor: isHovered
                  ? colors.text.linkHover
                  : colors.text.linkDefault,
            ),
          ),
        );
      },
    );
  }
}
