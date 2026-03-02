import 'package:flutter/material.dart';
import '../../foundation/theme/cloudscape_theme.dart';
import '../base/component_base.dart';

/// Represents an item in a [CloudscapeRadioGroup].
class CloudscapeRadioGroupItem<T> {
  /// The value represented by this radio item.
  final T value;

  /// The widget label displayed next to the radio button.
  final Widget? label;

  /// The text label displayed next to the radio button. Used if [label] is not provided.
  final String? text;

  /// Additional description text displayed below the label.
  final String? description;

  /// Whether this specific item is disabled.
  final bool disabled;

  /// Accessibility hint.
  final String? ariaLabel;

  const CloudscapeRadioGroupItem({
    required this.value,
    this.label,
    this.text,
    this.description,
    this.disabled = false,
    this.ariaLabel,
  }) : assert(
         label != null || text != null,
         'Either label or text must be provided.',
       );
}

/// A radio button group component based on the Cloudscape Design System.
class CloudscapeRadioGroup<T> extends StatelessWidget {
  /// The currently selected value.
  final T? value;

  /// Called when the selected value changes.
  final ValueChanged<T>? onChange;

  /// The list of items to display.
  final List<CloudscapeRadioGroupItem<T>> items;

  /// Whether the entire radio group is disabled.
  final bool disabled;

  const CloudscapeRadioGroup({
    super.key,
    required this.items,
    this.value,
    this.onChange,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    final spacing = context.cloudscapeSpacing;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(items.length, (index) {
        final item = items[index];
        final isSelected = item.value == value;

        return Padding(
          padding: EdgeInsets.only(
            bottom: index < items.length - 1 ? spacing.scaledS : 0,
          ),
          child: _CloudscapeRadioButton<T>(
            item: item,
            selected: isSelected,
            groupDisabled: disabled,
            onTap: () {
              if (onChange != null &&
                  !item.disabled &&
                  !disabled &&
                  !isSelected) {
                onChange!(item.value);
              }
            },
          ),
        );
      }),
    );
  }
}

class _CloudscapeRadioButton<T> extends StatelessWidget {
  final CloudscapeRadioGroupItem<T> item;
  final bool selected;
  final bool groupDisabled;
  final VoidCallback onTap;

  const _CloudscapeRadioButton({
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
    final border = context.cloudscapeBorderWidth;

    final isDisabled = groupDisabled || item.disabled;

    return ComponentsBase(
      enabled: !isDisabled,
      isButton: true,
      label: item.ariaLabel ?? item.text,
      builder: (context, isHovered) {
        // Calculate colors based on state
        Color boxColor;
        Color borderColor;

        if (isDisabled) {
          boxColor = colors.backgrounds.controlDefault;
          borderColor = selected
              ? colors.backgrounds.controlDisabled
              : colors.borders.controlDefault.withValues(alpha: 0.5);
        } else if (selected) {
          boxColor = colors
              .backgrounds
              .controlDefault; // Outer is white/bg, inner is filled
          borderColor = isHovered
              ? colors.backgrounds.buttonPrimaryHover
              : colors.backgrounds.controlChecked;
        } else {
          boxColor = colors.backgrounds.controlDefault;
          borderColor = isHovered
              ? colors.borders.inputFocused
              : colors.borders.controlDefault;
        }

        return GestureDetector(
          onTap: isDisabled ? null : onTap,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 16,
                height: 16,
                margin: EdgeInsets.only(
                  // Center with the first line of text
                  top:
                      (typography.bodyM.height ?? 1.4) *
                          typography.bodyM.fontSize! /
                          2 -
                      8,
                ),
                decoration: BoxDecoration(
                  color: boxColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: borderColor,
                    width: selected
                        ? 5
                        : border
                              .field, // Cloudscape uses thick border or inner dot. Let's use thick border for selected.
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
              if (item.label != null || item.text != null) ...[
                SizedBox(width: spacing.scaledXs),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DefaultTextStyle(
                        style: typography.bodyM.copyWith(
                          color: isDisabled
                              ? colors.text.interactiveDisabled
                              : colors.text.bodyDefault,
                        ),
                        child: item.label ?? Text(item.text!),
                      ),
                      if (item.description != null) ...[
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
            ],
          ),
        );
      },
    );
  }
}
