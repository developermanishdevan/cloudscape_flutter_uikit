import 'package:flutter/material.dart';
import '../../foundation/theme/cloudscape_theme.dart';
import '../base/component_base.dart';

/// Represents an item in a [CloudscapeTiles] component.
class CloudscapeTileItem<T> {
  /// The value represented by this tile.
  final T value;

  /// The text label displayed as the title of the tile.
  final String label;

  /// Additional description text displayed below the label.
  final String? description;

  /// An optional image widget, typically displayed on the left or top.
  final Widget? image;

  /// Accessibility hint.
  final String? ariaLabel;

  /// Whether this specific tile is disabled.
  final bool disabled;

  const CloudscapeTileItem({
    required this.value,
    required this.label,
    this.description,
    this.image,
    this.ariaLabel,
    this.disabled = false,
  });
}

/// A tiles component based on the Cloudscape Design System.
/// Tiles enable users to choose one of a predefined set of options,
/// often including additional metadata or visuals.
class CloudscapeTiles<T> extends StatelessWidget {
  /// The currently selected value.
  final T? value;

  /// Called when the selected value changes.
  final ValueChanged<T>? onChange;

  /// The list of items to display as tiles.
  final List<CloudscapeTileItem<T>> items;

  /// The number of columns to use if laying out in a grid.
  /// If null, tiles follow standard Wrap layout or expand.
  final int columns;

  /// Whether the entire tiles group is disabled.
  final bool disabled;

  const CloudscapeTiles({
    super.key,
    required this.items,
    this.value,
    this.onChange,
    this.columns = 1, // Default to a stacked layout like radio group
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    final spacing = context.cloudscapeSpacing;

    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;
        // Calculate item width based on columns, minus spacing
        final spacingTotal = (columns - 1) * spacing.scaledM;
        final itemWidth = (availableWidth - spacingTotal) / columns;

        return Wrap(
          spacing: spacing.scaledM,
          runSpacing: spacing.scaledM,
          children: items.map((item) {
            return SizedBox(
              width: columns > 1 ? itemWidth : double.infinity,
              child: _CloudscapeTile<T>(
                item: item,
                selected: item.value == value,
                groupDisabled: disabled,
                onTap: () {
                  if (onChange != null &&
                      !item.disabled &&
                      !disabled &&
                      item.value != value) {
                    onChange!(item.value);
                  }
                },
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class _CloudscapeTile<T> extends StatelessWidget {
  final CloudscapeTileItem<T> item;
  final bool selected;
  final bool groupDisabled;
  final VoidCallback onTap;

  const _CloudscapeTile({
    required this.item,
    required this.selected,
    required this.groupDisabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.cloudscapeColors;
    final typography = context.cloudscapeTypography;
    final spacing = context.cloudscapeSpacing;
    final radius = context.cloudscapeRadius;
    final border = context.cloudscapeBorderWidth;

    final isDisabled = groupDisabled || item.disabled;

    return ComponentsBase(
      enabled: !isDisabled,
      isButton: true,
      label: item.ariaLabel ?? item.label,
      builder: (context, isHovered) {
        // Tile colors
        Color backgroundColor;
        Color borderColor;

        if (isDisabled) {
          backgroundColor = selected
              ? colors.backgrounds.controlDisabled
              : colors.backgrounds.containerContent;
          borderColor = colors.borders.controlDefault.withValues(alpha: 0.5);
        } else if (selected) {
          backgroundColor = colors.backgrounds.controlChecked.withValues(
            alpha: 0.05,
          );
          borderColor = colors.backgrounds.controlChecked;
        } else {
          backgroundColor = isHovered
              ? colors.backgrounds.buttonNormalHover
              : colors.backgrounds.containerContent;
          borderColor = isHovered
              ? colors.borders.inputFocused
              : colors.borders.controlDefault;
        }

        // Radio control colors
        Color radioBoxColor;
        Color radioBorderColor;

        if (isDisabled) {
          radioBoxColor = colors.backgrounds.controlDefault;
          radioBorderColor = selected
              ? colors.backgrounds.controlDisabled
              : colors.borders.controlDefault.withValues(alpha: 0.5);
        } else if (selected) {
          radioBoxColor = colors.backgrounds.controlDefault;
          radioBorderColor = colors.backgrounds.controlChecked;
        } else {
          radioBoxColor = colors.backgrounds.controlDefault;
          radioBorderColor = isHovered
              ? colors.borders.inputFocused
              : colors.borders.controlDefault;
        }

        return GestureDetector(
          onTap: isDisabled ? null : onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: EdgeInsets.all(spacing.scaledM),
            decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(
                color: borderColor,
                width: selected ? 2 : border.field,
              ),
              borderRadius: BorderRadius.circular(radius.container),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 16,
                  height: 16,
                  margin: EdgeInsets.only(
                    top:
                        (typography.bodyM.height ?? 1.4) *
                            typography.bodyM.fontSize! /
                            2 -
                        8,
                  ),
                  decoration: BoxDecoration(
                    color: radioBoxColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: radioBorderColor,
                      width: selected ? 5 : border.field,
                    ),
                  ),
                  child: isDisabled && selected
                      ? Center(
                          child: Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: colors.text.interactiveDisabled,
                              shape: BoxShape.circle,
                            ),
                          ),
                        )
                      : null,
                ),
                SizedBox(width: spacing.scaledM),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (item.image != null) ...[
                        item.image!,
                        SizedBox(height: spacing.scaledS),
                      ],
                      DefaultTextStyle(
                        style: typography.bodyM.copyWith(
                          color: isDisabled
                              ? colors.text.interactiveDisabled
                              : colors.text.bodyDefault,
                          fontWeight: FontWeight.w600,
                        ),
                        child: Text(item.label),
                      ),
                      if (item.description != null) ...[
                        SizedBox(height: spacing.scaledXxs),
                        Text(
                          item.description!,
                          style: typography.bodyS.copyWith(
                            color: isDisabled
                                ? colors.text.interactiveDisabled
                                : colors.text.bodySecondary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
