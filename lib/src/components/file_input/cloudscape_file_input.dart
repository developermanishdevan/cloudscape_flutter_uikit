import 'package:flutter/material.dart';
import '../../foundation/theme/cloudscape_theme.dart';
import '../button/cloudscape_button.dart';
import '../base/component_base.dart';

/// A UI component for file input, based on Cloudscape Design System.
/// Note: This is an aesthetic UI component. Actual file picking logic
/// (e.g., using `file_picker` package) should be handled by the parent widget.
class CloudscapeFileInput extends StatelessWidget {
  /// The list of selected file names or paths to display.
  final List<String> values;

  /// Callback when the "Choose file" button is pressed.
  final VoidCallback? onChoosePressed;

  /// Callback when a file is removed/deleted from the selection.
  /// Provides the index of the file to remove.
  final ValueChanged<int>? onRemovePressed;

  /// The text to display on the choose button.
  final String buttonText;

  /// Optional text to display when no files are selected.
  final String noFilesText;

  /// Whether the file input is disabled.
  final bool disabled;

  /// Whether multiple files are allowed. This typically changes the wording or UI slightly.
  final bool multiple;

  const CloudscapeFileInput({
    super.key,
    this.values = const [],
    this.onChoosePressed,
    this.onRemovePressed,
    this.buttonText = 'Choose file',
    this.noFilesText = 'No file chosen',
    this.disabled = false,
    this.multiple = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.cloudscapeColors;
    final typography = context.cloudscapeTypography;
    final spacing = context.cloudscapeSpacing;
    final radius = context.cloudscapeRadius;
    final border = context.cloudscapeBorderWidth;

    return ComponentsBase(
      enabled: !disabled,
      builder: (context, isHovered) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CloudscapeButton(
                  text: buttonText,
                  disabled: disabled,
                  onPressed: onChoosePressed,
                  variant: ButtonVariant.normal,
                ),
                SizedBox(width: spacing.scaledXs),
                if (values.isEmpty)
                  Text(
                    noFilesText,
                    style: typography.bodyM.copyWith(
                      color: disabled
                          ? colors.text.interactiveDisabled
                          : colors.text.bodySecondary,
                    ),
                  ),
              ],
            ),
            if (values.isNotEmpty) ...[
              SizedBox(height: spacing.scaledXs),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: colors.borders.dividerDefault,
                    width: border.field,
                  ),
                  borderRadius: BorderRadius.circular(radius.input),
                ),
                child: Column(
                  children: List.generate(values.length, (index) {
                    final fileText = values[index];
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spacing.scaledXs,
                        vertical: spacing.scaledXs,
                      ),
                      decoration: BoxDecoration(
                        border: index < values.length - 1
                            ? Border(
                                bottom: BorderSide(
                                  color: colors.borders.dividerDefault,
                                  width: border.field,
                                ),
                              )
                            : null,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.insert_drive_file_outlined,
                            size: 16,
                            color: colors.text.bodySecondary,
                          ),
                          SizedBox(width: spacing.scaledXs),
                          Expanded(
                            child: Text(
                              fileText,
                              style: typography.bodyM.copyWith(
                                color: colors.text.bodyDefault,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (onRemovePressed != null && !disabled)
                            CloudscapeButton(
                              variant: ButtonVariant.inlineIcon,
                              iconName: Icons.close,
                              ariaLabel: 'Remove file',
                              onPressed: () => onRemovePressed!(index),
                            ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
