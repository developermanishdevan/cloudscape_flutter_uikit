import 'package:flutter/material.dart';
import '../../foundation/theme/cloudscape_theme.dart';
import '../base/cloudscape_dropdown_base.dart';
import '../base/component_base.dart';

/// An option in a [CloudscapeSelect] or [CloudscapeMultiselect].
class SelectOption<T> {
  /// The underlying value.
  final T value;

  /// The label to display.
  final String label;

  /// Whether this option is disabled.
  final bool disabled;

  /// Optional secondary text to display.
  final String? description;

  const SelectOption({
    required this.value,
    required this.label,
    this.disabled = false,
    this.description,
  });
}

/// A dropdown select component based on the Cloudscape Design System.
class CloudscapeSelect<T> extends StatelessWidget {
  /// The list of options.
  final List<SelectOption<T>> options;

  /// The currently selected option.
  final SelectOption<T>? selectedOption;

  /// Called when an option is selected.
  final ValueChanged<SelectOption<T>>? onChange;

  /// Placeholder text when nothing is selected.
  final String? placeholder;

  /// Whether the select is disabled.
  final bool disabled;

  /// Whether the select is in an invalid state.
  final bool invalid;

  /// The maximum height of the dropdown menu.
  final double dropdownMaxHeight;

  const CloudscapeSelect({
    super.key,
    required this.options,
    this.selectedOption,
    this.onChange,
    this.placeholder,
    this.disabled = false,
    this.invalid = false,
    this.dropdownMaxHeight = 300,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.cloudscapeColors;
    final typography = context.cloudscapeTypography;
    final spacing = context.cloudscapeSpacing;
    final radius = context.cloudscapeRadius;
    final border = context.cloudscapeBorderWidth;

    return CloudscapeDropdownBase(
      fullWidth: true,
      maxHeight: dropdownMaxHeight,
      targetBuilder: (context, link, isOpened) {
        return ComponentsBase(
          enabled: !disabled,
          isButton: true,
          builder: (context, isHovered) {
            Color backgroundColor = disabled
                ? colors.backgrounds.inputDisabled
                : colors.backgrounds.inputDefault;

            Color borderColor;
            double borderWidth = border.field;

            if (invalid) {
              borderColor = colors.status.error;
              borderWidth = border.field * 2;
            } else if (isOpened) {
              borderColor = colors.borders.inputFocused;
              borderWidth = border.field * 2;
            } else if (isHovered && !disabled) {
              borderColor = colors.borders.controlDefault;
            } else {
              borderColor = colors.borders.inputDefault;
            }

            final textColor = disabled
                ? colors.text.interactiveDisabled
                : (selectedOption != null
                      ? colors.text.bodyDefault
                      : colors.text.bodySecondary);

            return GestureDetector(
              onTap: disabled
                  ? null
                  : () {
                      final state = context
                          .findAncestorStateOfType<
                            CloudscapeDropdownBaseState
                          >();
                      state?.toggle();
                    },
              child: Container(
                decoration: BoxDecoration(
                  color: backgroundColor,
                  border: Border.all(color: borderColor, width: borderWidth),
                  borderRadius: BorderRadius.circular(radius.input),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: spacing.scaledXs,
                  vertical: spacing.scaledXs,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        selectedOption?.label ?? placeholder ?? '',
                        style: typography.bodyM.copyWith(color: textColor),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Icon(
                        isOpened ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                        size: 20,
                        color: disabled
                            ? colors.text.interactiveDisabled
                            : colors.text.bodySecondary,
                      ),
                    ),
                  ],
                ),
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: options.map((option) {
              final isSelected = selectedOption?.value == option.value;
              return _SelectOptionWidget<T>(
                option: option,
                selected: isSelected,
                onTap: () {
                  if (!option.disabled) {
                    onChange?.call(option);
                    close();
                  }
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

class _SelectOptionWidget<T> extends StatelessWidget {
  final SelectOption<T> option;
  final bool selected;
  final VoidCallback onTap;

  const _SelectOptionWidget({
    required this.option,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.cloudscapeColors;
    final typography = context.cloudscapeTypography;
    final spacing = context.cloudscapeSpacing;

    return ComponentsBase(
      enabled: !option.disabled,
      builder: (context, isHovered) {
        final textColor = option.disabled
            ? colors.text.interactiveDisabled
            : colors.text.bodyDefault;

        return GestureDetector(
          onTap: option.disabled ? null : onTap,
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: spacing.scaledS - 1,
                vertical: spacing.scaledXs - 1,
              ),
              decoration: BoxDecoration(
                color: selected
                    ? colors.backgrounds.dropdownItemHover.withValues(
                        alpha: 0.5,
                      ) // Selected indication
                    : (isHovered
                          ? colors.backgrounds.dropdownItemHover
                          : Colors.transparent),
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          option.label,
                          style: typography.bodyM.copyWith(
                            color: textColor,
                            fontWeight: selected
                                ? FontWeight.w700
                                : FontWeight.w400,
                          ),
                        ),
                        if (option.description != null) ...[
                          Text(
                            option.description!,
                            style: typography.bodyS.copyWith(
                              color: option.disabled
                                  ? colors.text.interactiveDisabled
                                  : colors.text.bodySecondary,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (selected)
                    Icon(
                      Icons.check,
                      size: 16,
                      color: colors.text.interactiveDefault,
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
