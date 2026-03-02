import 'package:flutter/material.dart';
import '../../foundation/theme/cloudscape_theme.dart';
import '../base/component_base.dart';

/// A checkbox component based on the Cloudscape Design System.
class CloudscapeCheckbox extends StatelessWidget {
  /// The current state of the checkbox. True for checked, false for unchecked, null for indeterminate (if supported).
  final bool? checked;

  /// Called when the checkbox's state should change.
  final ValueChanged<bool?>? onChange;

  /// The label displayed next to the checkbox.
  final Widget? label;

  /// The text label displayed next to the checkbox. Used if [label] is not provided.
  final String? text;

  /// Additional description text displayed below the label.
  final String? description;

  /// Whether the checkbox is disabled.
  final bool disabled;

  /// Whether the checkbox is in an indeterminate state.
  final bool indeterminate;

  /// Accessibility hint.
  final String? ariaLabel;

  const CloudscapeCheckbox({
    super.key,
    this.checked = false,
    this.onChange,
    this.label,
    this.text,
    this.description,
    this.disabled = false,
    this.indeterminate = false,
    this.ariaLabel,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.cloudscapeColors;
    final typography = context.cloudscapeTypography;
    final spacing = context.cloudscapeSpacing;
    final radius = context.cloudscapeRadius;
    final border = context.cloudscapeBorderWidth;

    final isChecked = checked == true;
    final isIndeterminate = indeterminate || checked == null;

    return ComponentsBase(
      enabled: !disabled,
      isButton: true,
      label: ariaLabel ?? text,
      builder: (context, isHovered) {
        // Colors calculation
        Color boxColor;
        Color borderColor;
        Color iconColor = colors.text.onPrimary;

        if (disabled) {
          boxColor = (isChecked || isIndeterminate)
              ? colors.backgrounds.controlDisabled
              : colors.backgrounds.controlDefault;
          borderColor = colors.borders.controlDefault.withValues(alpha: 0.5);
          iconColor = colors.text.interactiveDisabled;
        } else if (isChecked || isIndeterminate) {
          boxColor = isHovered
              ? colors.backgrounds.buttonPrimaryHover
              : colors.backgrounds.controlChecked;
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
          onTap: disabled
              ? null
              : () {
                  if (onChange != null) {
                    if (isIndeterminate) {
                      onChange!(true);
                    } else {
                      onChange!(!isChecked);
                    }
                  }
                },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 16,
                height: 16,
                margin: EdgeInsets.only(
                  // Adjust margin to align nicely with text line height (20px usually)
                  top:
                      (typography.bodyM.height ?? 1.4) *
                          typography.bodyM.fontSize! /
                          2 -
                      8,
                ),
                decoration: BoxDecoration(
                  color: boxColor,
                  borderRadius: BorderRadius.circular(
                    radius.controlDefaultFocusRing,
                  ),
                  border: Border.all(
                    color: borderColor,
                    width: border.field, // Standard 1px border
                  ),
                ),
                child: Center(
                  child: isIndeterminate
                      ? Container(width: 8, height: 2, color: iconColor)
                      : isChecked
                      ? Icon(Icons.check, size: 14, color: iconColor)
                      : null,
                ),
              ),
              if (label != null || text != null) ...[
                SizedBox(width: spacing.scaledXs),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DefaultTextStyle(
                        style: typography.bodyM.copyWith(
                          color: disabled
                              ? colors.text.interactiveDisabled
                              : colors.text.bodyDefault,
                        ),
                        child: label ?? Text(text!),
                      ),
                      if (description != null) ...[
                        Text(
                          description!,
                          style: typography.bodyS.copyWith(
                            color: disabled
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
