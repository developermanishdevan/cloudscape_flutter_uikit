import 'package:flutter/material.dart';
import '../../foundation/theme/cloudscape_theme.dart';
import '../base/cloudscape_dropdown_base.dart';
import '../base/component_base.dart';
import '../button/cloudscape_button.dart';

/// Base class for items or groups in a button dropdown.
abstract class ButtonDropdownItemOrGroup {
  final String id;
  final String text;
  final bool disabled;
  final String? disabledReason;

  const ButtonDropdownItemOrGroup({
    required this.id,
    required this.text,
    this.disabled = false,
    this.disabledReason,
  });
}

/// A single selectable item in a button dropdown.
class ButtonDropdownItem extends ButtonDropdownItemOrGroup {
  final IconData? iconName;
  final String? iconAlt;
  final bool external;
  final String? href;

  const ButtonDropdownItem({
    required super.id,
    required super.text,
    super.disabled,
    super.disabledReason,
    this.iconName,
    this.iconAlt,
    this.external = false,
    this.href,
  });
}

/// A group of items in a button dropdown.
class ButtonDropdownGroup extends ButtonDropdownItemOrGroup {
  final List<ButtonDropdownItemOrGroup> items;

  const ButtonDropdownGroup({
    required super.id,
    required super.text,
    required this.items,
    super.disabled,
    super.disabledReason,
  });
}

/// A button dropdown allows users to choose from a list of actions or options.
class CloudscapeButtonDropdown extends StatelessWidget {
  final List<ButtonDropdownItemOrGroup> items;
  final Widget? content;
  final String? text;
  final ButtonVariant variant;
  final bool disabled;
  final String? disabledReason;
  final bool loading;
  final bool fullWidth;
  final bool expandableGroups;
  final IconData? iconName;
  final String? iconAlt;
  final double maxHeight;
  final ValueChanged<ButtonDropdownItem>? onItemClick;

  const CloudscapeButtonDropdown({
    super.key,
    required this.items,
    this.content,
    this.text,
    this.variant = ButtonVariant.normal,
    this.disabled = false,
    this.disabledReason,
    this.loading = false,
    this.fullWidth = false,
    this.expandableGroups = false,
    this.iconName,
    this.iconAlt,
    this.maxHeight = 200,
    this.onItemClick,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.cloudscapeColors;
    final typography = context.cloudscapeTypography;
    final spacing = context.cloudscapeSpacing;

    return CloudscapeDropdownBase(
      fullWidth: fullWidth,
      maxHeight: maxHeight,
      targetBuilder: (context, link, isOpened) {
        return ComponentsBase(
          enabled: !disabled && !loading,
          isButton: true,
          builder: (context, isHovered) {
            final Color finalText;

            if (disabled) {
              finalText = colors.text.interactiveDisabled;
            } else if (isOpened || isHovered) {
              finalText = variant == ButtonVariant.primary
                  ? colors.text.onPrimary
                  : colors.text.linkHover;
            } else {
              finalText = variant == ButtonVariant.primary
                  ? colors.text.onPrimary
                  : colors.backgrounds.controlChecked;
            }

            return CloudscapeButton(
              variant: variant,
              disabled: disabled,
              loading: loading,
              fullWidth: fullWidth,
              isActive: isOpened,
              onPressed: () {
                final state = context
                    .findAncestorStateOfType<CloudscapeDropdownBaseState>();
                state?.toggle();
              },
              ariaLabel: text,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (iconName != null && !loading) ...[
                    Icon(iconName, size: 20, color: finalText),
                    SizedBox(width: spacing.scaledXs),
                  ],
                  Flexible(
                    child: text != null
                        ? Text(
                            text!,
                            style: typography.bodyM.copyWith(
                              color: finalText,
                              fontWeight: FontWeight.w600,
                              overflow: TextOverflow.ellipsis,
                            ),
                            textAlign: TextAlign.center,
                          )
                        : const SizedBox.shrink(),
                  ),
                  SizedBox(width: spacing.scaledXxs),
                  Icon(
                    isOpened
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    size: 16,
                    color: finalText,
                  ),
                ],
              ),
            );
          },
        );
      },
      dropdownBuilder: (context, targetSize, close) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: items
                .map((item) => _buildItem(context, item, close))
                .toList(),
          ),
        );
      },
    );
  }

  Widget _buildItem(
    BuildContext context,
    ButtonDropdownItemOrGroup item,
    VoidCallback close, {
    int level = 0,
  }) {
    if (item is ButtonDropdownGroup) {
      return _DropdownGroupWidget(
        group: item,
        level: level,
        expandable: expandableGroups,
        onItemClick: (clickedItem) {
          onItemClick?.call(clickedItem);
          close();
        },
      );
    } else if (item is ButtonDropdownItem) {
      return _DropdownItemWidget(
        item: item,
        level: level,
        onTap: () {
          onItemClick?.call(item);
          close();
        },
      );
    }
    return const SizedBox.shrink();
  }
}

class _DropdownItemWidget extends StatelessWidget {
  final ButtonDropdownItem item;
  final int level;
  final VoidCallback onTap;

  const _DropdownItemWidget({
    required this.item,
    required this.level,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.cloudscapeColors;
    final typography = context.cloudscapeTypography;
    final spacing = context.cloudscapeSpacing;

    return ComponentsBase(
      enabled: !item.disabled,
      builder: (context, isHovered) {
        final Color textColor = item.disabled
            ? colors.text.interactiveDisabled
            : colors.text.bodyDefault;

        return GestureDetector(
          onTap: item.disabled ? null : onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: spacing.scaledS + (level * 12) - 1,
                vertical: spacing.scaledXs - 1,
              ),
              decoration: BoxDecoration(
                color: isHovered
                    ? colors.backgrounds.dropdownItemHover
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(
                  context.cloudscapeRadius.item,
                ),
                border: Border.all(
                  color: isHovered
                      ? colors.borders.dropdownItemHover
                      : Colors.transparent,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  if (item.iconName != null) ...[
                    Icon(item.iconName, size: 20, color: textColor),
                    const SizedBox(width: 8),
                  ],
                  Expanded(
                    child: Text(
                      item.text,
                      style: typography.bodyM.copyWith(
                        color: textColor,
                        fontWeight:
                            FontWeight.w400, // Standard weight from image
                      ),
                    ),
                  ),
                  if (item.external) ...[
                    const SizedBox(width: 8),
                    Icon(
                      Icons.open_in_new,
                      size: 16,
                      color: colors.text.interactiveDisabled,
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _DropdownGroupWidget extends StatefulWidget {
  final ButtonDropdownGroup group;
  final int level;
  final bool expandable;
  final ValueChanged<ButtonDropdownItem> onItemClick;

  const _DropdownGroupWidget({
    required this.group,
    required this.level,
    required this.expandable,
    required this.onItemClick,
  });

  @override
  State<_DropdownGroupWidget> createState() => _DropdownGroupWidgetState();
}

class _DropdownGroupWidgetState extends State<_DropdownGroupWidget> {
  late bool _expanded;

  @override
  void initState() {
    super.initState();
    _expanded = !widget.expandable;
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.cloudscapeColors;
    final typography = context.cloudscapeTypography;
    final spacing = context.cloudscapeSpacing;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.expandable)
          GestureDetector(
            onTap: () => setState(() => _expanded = !_expanded),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: spacing.scaledM + (widget.level * 16),
                vertical: spacing.scaledS,
              ),
              color: Colors.transparent,
              child: Row(
                children: [
                  Icon(
                    _expanded ? Icons.arrow_drop_down : Icons.arrow_right,
                    size: 20,
                    color: colors.text.interactiveDisabled,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    widget.group.text,
                    style: typography.headingXs.copyWith(
                      color: colors.text.interactiveDisabled,
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          Padding(
            padding: EdgeInsets.only(
              left: spacing.scaledM + (widget.level * 16),
              top: spacing.scaledS,
              bottom: spacing.scaledXs,
            ),
            child: Text(
              widget.group.text.toUpperCase(),
              style: typography.label.copyWith(
                color: colors.text.interactiveDisabled,
                letterSpacing: 1.2,
                fontSize: 11,
              ),
            ),
          ),
        if (_expanded)
          ...widget.group.items.map((item) {
            if (item is ButtonDropdownGroup) {
              return _DropdownGroupWidget(
                group: item,
                level: widget.level + 1,
                expandable: widget.expandable,
                onItemClick: widget.onItemClick,
              );
            } else if (item is ButtonDropdownItem) {
              return _DropdownItemWidget(
                item: item,
                level: widget.level + 1,
                onTap: () => widget.onItemClick(item),
              );
            }
            return const SizedBox.shrink();
          }),
      ],
    );
  }
}
