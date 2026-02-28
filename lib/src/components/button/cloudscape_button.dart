import 'package:flutter/material.dart';

import '../../foundation/theme/cloudscape_theme.dart';
import '../base/component_base.dart';

/// The visual variant of the button.
enum ButtonVariant { primary, normal, link, inlineLink, icon, inlineIcon }

/// A button is a graphical element that a user can click or touch to trigger an action.
class CloudscapeButton extends StatelessWidget {
  /// The content of the button, typically a [Text] widget.
  /// If [text] is provided, this is ignored.
  final Widget? child;

  /// The text content of the button.
  final String? text;

  /// The visual variant of the button. Defaults to [ButtonVariant.normal].
  final ButtonVariant variant;

  /// Whether the button is disabled.
  final bool disabled;

  /// Whether the button is in a loading state.
  final bool loading;

  /// Whether the button should take up the full width of its container.
  final bool fullWidth;

  /// Whether the text should wrap if it's too long.
  final bool wrapText;

  /// Whether to show an external link icon.
  final bool external;

  /// An icon to show in the button.
  final IconData? iconName;

  /// Accessibility label for the icon.
  final String? iconAlt;

  /// The side on which to show the icon. Either 'left' or 'right'.
  final String iconAlign;

  /// Whether the button is in an active/selected state.
  final bool isActive;

  /// Callback when the button is pressed.
  final VoidCallback? onPressed;

  /// Accessibility label for the button.
  final String? ariaLabel;

  const CloudscapeButton({
    super.key,
    this.child,
    this.text,
    this.variant = ButtonVariant.normal,
    this.disabled = false,
    this.loading = false,
    this.fullWidth = false,
    this.isActive = false,
    this.wrapText = true,
    this.external = false,
    this.iconName,
    this.iconAlt,
    this.iconAlign = 'left',
    this.onPressed,
    this.ariaLabel,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.cloudscapeColors;
    final typography = context.cloudscapeTypography;
    final spacing = context.cloudscapeSpacing;
    final radius = context.cloudscapeRadius;
    final border = context.cloudscapeBorderWidth;

    return ComponentsBase(
      enabled: !disabled && !loading,
      isButton: true,
      label: ariaLabel ?? text,
      builder: (context, isHovered) {
        final isInteracting = isHovered || isActive;

        // --- STYLING CALCULATION ---
        Color backgroundColor;
        Color textColor;
        Color borderColor;
        double borderWidth;
        double borderRadius;
        EdgeInsets padding;

        // Defaults
        borderWidth = border.button;
        borderRadius = radius.button;
        padding = EdgeInsets.symmetric(
          horizontal: spacing.scaledM,
          vertical: spacing.scaledXs,
        );

        // Logic based on variant and state
        switch (variant) {
          case ButtonVariant.primary:
            if (disabled) {
              backgroundColor = colors.backgrounds.buttonPrimaryDisabled;
              textColor = colors.text.interactiveDisabled;
              borderColor = Colors.transparent;
              borderWidth = 0;
            } else if (isInteracting) {
              backgroundColor = colors.backgrounds.buttonPrimaryHover;
              textColor = colors.text.onPrimary;
              borderColor = Colors.transparent;
              borderWidth = 0;
            } else {
              backgroundColor = colors.backgrounds.buttonPrimaryDefault;
              textColor = colors.text.onPrimary;
              borderColor = Colors.transparent;
              borderWidth = 0;
            }
            break;

          case ButtonVariant.normal:
            if (disabled) {
              backgroundColor = colors.backgrounds.buttonNormalDisabled;
              textColor = colors.text.interactiveDisabled;
              borderColor = colors.borders.dividerSecondary;
            } else if (isInteracting) {
              // Cloudscape normal buttons often use a subtle background on hover
              backgroundColor = colors.backgrounds.buttonNormalHover;
              textColor = colors.backgrounds.controlChecked;
              borderColor = colors.backgrounds.controlChecked;
            } else {
              backgroundColor = colors.backgrounds.buttonNormalDefault;
              textColor = colors.backgrounds.controlChecked;
              borderColor = colors.backgrounds.controlChecked;
            }
            break;

          case ButtonVariant.link:
          case ButtonVariant.inlineLink:
            backgroundColor = Colors.transparent;
            if (disabled) {
              textColor = colors.text.interactiveDisabled;
            } else if (isInteracting) {
              textColor = colors.text.linkHover;
            } else {
              textColor = colors.text.linkDefault;
            }
            borderColor = Colors.transparent;
            borderWidth = 0;
            if (variant == ButtonVariant.inlineLink) {
              padding = EdgeInsets.zero;
            } else {
              padding = EdgeInsets.symmetric(
                horizontal: spacing.scaledXs,
                vertical: spacing.scaledXxs,
              );
            }
            break;

          case ButtonVariant.icon:
          case ButtonVariant.inlineIcon:
            backgroundColor = isInteracting
                ? colors.backgrounds.buttonNormalHover
                : Colors.transparent;
            if (disabled) {
              textColor = colors.text.interactiveDisabled;
            } else if (isInteracting) {
              textColor = colors.backgrounds.controlChecked;
            } else {
              textColor = colors.text.bodyDefault;
            }
            borderColor = Colors.transparent;
            borderWidth = 0;
            padding = EdgeInsets.all(spacing.scaledXxs);
            borderRadius = radius.tabsFocusRing;
            break;
        }

        Widget content = Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (loading) ...[
              SizedBox(
                width: 14,
                height: 14,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(textColor),
                ),
              ),
              SizedBox(width: spacing.scaledXs),
            ],
            if (iconName != null && iconAlign == 'left' && !loading) ...[
              Icon(iconName, size: 18, color: textColor),
              SizedBox(width: spacing.scaledXs),
            ],
            Flexible(
              child:
                  child ??
                  (text != null
                      ? Text(
                          text!,
                          style: typography.bodyM.copyWith(
                            color: textColor,
                            fontWeight: FontWeight.w700,
                            overflow: wrapText
                                ? TextOverflow.visible
                                : TextOverflow.ellipsis,
                          ),
                          textAlign: TextAlign.center,
                        )
                      : const SizedBox.shrink()),
            ),
            if (iconName != null && iconAlign == 'right') ...[
              SizedBox(width: spacing.scaledXs),
              Icon(iconName, size: 18, color: textColor),
            ],
            if (external) ...[
              SizedBox(width: spacing.scaledXs),
              Icon(Icons.open_in_new, size: 14, color: textColor),
            ],
          ],
        );

        return GestureDetector(
          onTap: (disabled || loading) ? null : onPressed,
          child: Container(
            width: fullWidth ? double.infinity : null,
            padding: padding,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(borderRadius),
              border: borderWidth > 0
                  ? Border.all(color: borderColor, width: borderWidth)
                  : null,
            ),
            child: content,
          ),
        );
      },
    );
  }
}
