import 'package:flutter/material.dart';
import '../../foundation/theme/cloudscape_theme.dart';
import '../base/cloudscape_dropdown_base.dart';
import '../base/component_base.dart';
import '../select/cloudscape_select.dart'; // Reuse SelectOption

/// A multiselect component based on the Cloudscape Design System.
class CloudscapeMultiselect<T> extends StatelessWidget {
  /// The list of options.
  final List<SelectOption<T>> options;

  /// The currently selected options.
  final List<SelectOption<T>> selectedOptions;

  /// Called when the selection changes.
  final ValueChanged<List<SelectOption<T>>>? onChange;

  /// Placeholder text when nothing is selected.
  final String? placeholder;

  /// Text to display above the dropdown list as a clear button or similar. Optional.
  final String? deselectAllText;

  /// Whether the multiselect is disabled.
  final bool disabled;

  /// Whether the multiselect is in an invalid state.
  final bool invalid;

  /// The maximum height of the dropdown menu.
  final double dropdownMaxHeight;

  const CloudscapeMultiselect({
    super.key,
    required this.options,
    this.selectedOptions = const [],
    this.onChange,
    this.placeholder,
    this.deselectAllText,
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        CloudscapeDropdownBase(
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
                double borderWidth;

                if (invalid) {
                  borderColor = colors.status.error;
                  borderWidth = border.field * 2;
                } else if (isOpened) {
                  borderColor = colors.borders.inputFocused;
                  borderWidth = border.field * 2;
                } else if (isHovered && !disabled) {
                  borderColor = colors.borders.controlDefault;
                  borderWidth = border.field;
                } else {
                  borderColor = colors.borders.inputDefault;
                  borderWidth = border.field;
                }

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
                      border: Border.all(
                        color: borderColor,
                        width: borderWidth,
                      ),
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
                            placeholder ?? '',
                            style: typography.bodyM.copyWith(
                              color: disabled
                                  ? colors.text.interactiveDisabled
                                  : colors.text.bodySecondary,
                              fontStyle: FontStyle.italic,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Align(
                          alignment: Alignment.topRight,
                          child: Icon(
                            isOpened
                                ? Icons.arrow_drop_up
                                : Icons.arrow_drop_down,
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
                children: [
                  if (deselectAllText != null &&
                      selectedOptions.isNotEmpty) ...[
                    // Optional deselect all
                    GestureDetector(
                      onTap: () {
                        onChange?.call([]);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: spacing.scaledM,
                          vertical: spacing.scaledXs,
                        ),
                        child: Text(
                          deselectAllText!,
                          style: typography.bodyM.copyWith(
                            color: colors.text.linkDefault,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    const Divider(height: 1),
                  ],
                  ...options.map((option) {
                    final isSelected = selectedOptions.any(
                      (o) => o.value == option.value,
                    );
                    return _CheckboxOptionWidget<T>(
                      option: option,
                      selected: isSelected,
                      onTap: () {
                        if (!option.disabled) {
                          final newList = List<SelectOption<T>>.from(
                            selectedOptions,
                          );
                          if (isSelected) {
                            newList.removeWhere((o) => o.value == option.value);
                          } else {
                            newList.add(option);
                          }
                          onChange?.call(newList);
                        }
                      },
                    );
                  }),
                ],
              ),
            );
          },
        ),
        if (selectedOptions.isNotEmpty) ...[
          SizedBox(height: spacing.scaledXs),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: selectedOptions.map((opt) {
              return _MultiselectToken(
                label: opt.label,
                disabled: disabled || opt.disabled,
                onDismiss: () {
                  final newList = List<SelectOption<T>>.from(selectedOptions)
                    ..remove(opt);
                  onChange?.call(newList);
                },
              );
            }).toList(),
          ),
        ],
      ],
    );
  }
}

class _MultiselectToken extends StatelessWidget {
  final String label;
  final bool disabled;
  final VoidCallback onDismiss;

  const _MultiselectToken({
    required this.label,
    required this.disabled,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.cloudscapeColors;
    final typography = context.cloudscapeTypography;

    return ComponentsBase(
      enabled: !disabled,
      builder: (context, isHovered) {
        return Container(
          decoration: BoxDecoration(
            color: disabled
                ? colors.backgrounds.controlDisabled
                : colors.backgrounds.containerContent,
            border: Border.all(
              color: isHovered && !disabled
                  ? colors.borders.inputFocused
                  : (disabled
                        ? colors.borders.controlDefault.withValues(alpha: 0.5)
                        : colors.borders.inputFocused),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(context.cloudscapeRadius.item),
          ),
          padding: const EdgeInsets.only(left: 8, right: 2, top: 4, bottom: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: typography.bodyM.copyWith(
                  color: disabled
                      ? colors.text.interactiveDisabled
                      : colors.text.bodyDefault,
                ),
              ),
              const SizedBox(width: 4),
              GestureDetector(
                onTap: disabled ? null : onDismiss,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Icon(
                    Icons.close,
                    size: 16,
                    color: disabled
                        ? colors.text.interactiveDisabled
                        : colors
                              .borders
                              .inputFocused, // Matches Cloudscape blue cross icon
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CheckboxOptionWidget<T> extends StatelessWidget {
  final SelectOption<T> option;
  final bool selected;
  final VoidCallback onTap;

  const _CheckboxOptionWidget({
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
                  // Render a virtual checkbox
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: selected
                          ? (option.disabled
                                ? colors.backgrounds.controlDisabled
                                : colors.backgrounds.controlChecked)
                          : colors.backgrounds.controlDefault,
                      border: Border.all(
                        color: selected
                            ? (option.disabled
                                  ? colors.borders.controlDefault
                                  : colors.backgrounds.controlChecked)
                            : (isHovered
                                  ? colors.borders.inputFocused
                                  : colors.borders.controlDefault),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(
                        context.cloudscapeRadius.controlDefaultFocusRing,
                      ),
                    ),
                    child: selected
                        ? Icon(
                            Icons.check,
                            size: 14,
                            color: colors.text.onPrimary,
                          )
                        : null,
                  ),
                  SizedBox(width: spacing.scaledS),
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
