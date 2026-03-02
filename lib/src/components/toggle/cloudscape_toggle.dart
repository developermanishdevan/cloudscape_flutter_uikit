import 'package:flutter/material.dart';
import '../../foundation/theme/cloudscape_theme.dart';
import '../base/component_base.dart';

/// A toggle component based on the Cloudscape Design System.
class CloudscapeToggle extends StatelessWidget {
  /// The current state of the toggle.
  final bool checked;

  /// Called when the toggle's state should change.
  final ValueChanged<bool>? onChange;

  /// The widget label displayed next to the toggle.
  final Widget? label;

  /// The text label displayed next to the toggle.
  final String? text;

  /// Additional description text displayed below the label.
  final String? description;

  /// Whether the toggle is disabled.
  final bool disabled;

  /// Accessibility hint.
  final String? ariaLabel;

  const CloudscapeToggle({
    super.key,
    required this.checked,
    this.onChange,
    this.label,
    this.text,
    this.description,
    this.disabled = false,
    this.ariaLabel,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.cloudscapeColors;
    final typography = context.cloudscapeTypography;
    final spacing = context.cloudscapeSpacing;

    return ComponentsBase(
      enabled: !disabled,
      isButton: true,
      label: ariaLabel ?? text,
      builder: (context, isHovered) {
        Color trackColor;
        Color trackBorderColor;
        Color thumbColor = colors.backgrounds.controlDefault;

        if (disabled) {
          trackColor = checked
              ? colors.backgrounds.controlDisabled
              : colors.backgrounds.controlDefault;
          trackBorderColor = colors.borders.controlDefault.withValues(
            alpha: 0.5,
          );
          thumbColor = checked
              ? colors.backgrounds.controlDefault
              : colors.backgrounds.controlDisabled;
        } else if (checked) {
          trackColor = isHovered
              ? colors.backgrounds.buttonPrimaryHover
              : colors.backgrounds.controlChecked;
          trackBorderColor = trackColor;
        } else {
          trackColor = colors.backgrounds.controlDefault;
          trackBorderColor = isHovered
              ? colors.borders.inputFocused
              : colors.borders.controlDefault;
          thumbColor = colors
              .text
              .interactiveDefault; // Cloudscape generally has colored thumbs when off? Or grey.
          // Cloudscape off-state toggle thumb is actually usually white/grey-ish and border is strong or thumb is dark.
          // Let's use bodySecondary or similar.
          thumbColor = colors.borders.controlDefault;
        }

        return GestureDetector(
          onTap: disabled
              ? null
              : () {
                  if (onChange != null) {
                    onChange!(!checked);
                  }
                },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Toggle Track
              Container(
                width: 34,
                height: 20,
                margin: EdgeInsets.only(
                  top:
                      (typography.bodyM.height ?? 1.4) *
                          typography.bodyM.fontSize! /
                          2 -
                      10,
                ),
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: trackColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: trackBorderColor, width: 1.5),
                ),
                child: AnimatedAlign(
                  duration: const Duration(milliseconds: 150),
                  curve: Curves.easeInOut,
                  alignment: checked
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    width: 13,
                    height: 13,
                    decoration: BoxDecoration(
                      color: checked ? colors.text.onPrimary : thumbColor,
                      shape: BoxShape.circle,
                    ),
                  ),
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
