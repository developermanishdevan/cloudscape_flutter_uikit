import 'package:flutter/material.dart';
import '../../foundation/theme/cloudscape_theme.dart';
import '../../foundation/tokens/generated/cloudscape_tokens.dart';
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
        final Color backgroundColor;
        final Color textColor;
        final Color borderColor;
        final double borderWidth;
        final double borderRadius;
        final EdgeInsets padding;

        // Default to normal
        if (disabled) {
          backgroundColor = colors.tokens.colorBackgroundButtonNormalDisabled;
          textColor = colors.tokens.colorTextButtonNormalDisabled;
          borderColor = colors.tokens.colorBorderButtonNormalDisabled;
        } else if (isActive) {
          backgroundColor = colors.tokens.colorBackgroundButtonNormalActive;
          textColor = colors.tokens.colorTextButtonNormalActive;
          borderColor = colors.tokens.colorBorderButtonNormalActive;
        } else if (isHovered) {
          backgroundColor = colors.tokens.colorBackgroundButtonNormalHover;
          textColor = colors.tokens.colorTextButtonNormalHover;
          borderColor = colors.tokens.colorBorderButtonNormalHover;
        } else {
          backgroundColor = colors.tokens.colorBackgroundButtonNormalDefault;
          textColor = colors.tokens.colorTextButtonNormalDefault;
          borderColor = colors.tokens.colorBorderButtonNormalDefault;
        }

        borderWidth = border.button;
        borderRadius = radius.button;
        padding = EdgeInsets.symmetric(
          horizontal: spacing.scaledM,
          vertical: spacing.scaledXs,
        );

        // Variant overrides
        Color finalBackground = backgroundColor;
        Color finalText = textColor;
        Color finalBorder = borderColor;
        double finalBorderWidth = borderWidth;
        double finalRadius = borderRadius;
        EdgeInsets finalPadding = padding;

        switch (variant) {
          case ButtonVariant.primary:
            if (disabled) {
              finalBackground =
                  colors.tokens.colorBackgroundButtonPrimaryDisabled;
              finalText = colors.tokens.colorTextButtonPrimaryDisabled;
            } else if (isActive) {
              finalBackground =
                  colors.tokens.colorBackgroundButtonPrimaryActive;
              finalText = colors.tokens.colorTextButtonPrimaryActive;
            } else if (isHovered) {
              finalBackground = colors.tokens.colorBackgroundButtonPrimaryHover;
              finalText = colors.tokens.colorTextButtonPrimaryHover;
            } else {
              finalBackground =
                  colors.tokens.colorBackgroundButtonPrimaryDefault;
              finalText = colors.tokens.colorTextButtonPrimaryDefault;
            }
            finalBorder = Colors.transparent;
            finalBorderWidth = 0;
            break;
          case ButtonVariant.link:
          case ButtonVariant.inlineLink:
            finalBackground = isInteracting
                ? colors.tokens.colorBackgroundButtonLinkHover
                : Colors.transparent;
            finalText = isInteracting
                ? colors.tokens.colorTextLinkHover
                : colors.tokens.colorTextLinkDefault;
            finalBorder = Colors.transparent;
            finalBorderWidth = 0;
            finalPadding = variant == ButtonVariant.inlineLink
                ? EdgeInsets.zero
                : EdgeInsets.symmetric(
                    horizontal: spacing.scaledXs,
                    vertical: spacing.scaledXxs,
                  );
            break;
          case ButtonVariant.icon:
          case ButtonVariant.inlineIcon:
            finalBackground = isInteracting
                ? colors.tokens.colorBackgroundButtonNormalHover
                : Colors.transparent;
            finalText = disabled
                ? colors.tokens.colorTextButtonIconDisabled
                : (isInteracting
                      ? colors.tokens.colorTextInteractiveActive
                      : colors.tokens.colorTextInteractiveDefault);
            finalBorder = Colors.transparent;
            finalBorderWidth = 0;
            finalPadding = EdgeInsets.all(spacing.scaledXxs);
            finalRadius =
                radius.tabsFocusRing; // Use a more circular radius for icons
            break;
          default:
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
                  valueColor: AlwaysStoppedAnimation<Color>(finalText),
                ),
              ),
              SizedBox(width: spacing.scaledXs),
            ],
            if (iconName != null && iconAlign == 'left' && !loading) ...[
              Icon(iconName, size: 18, color: finalText),
              SizedBox(width: spacing.scaledXs),
            ],
            Flexible(
              child:
                  child ??
                  (text != null
                      ? Text(
                          text!,
                          style: typography.bodyM.copyWith(
                            color: finalText,
                            fontWeight: CloudscapeTokens.fontWeightButton,
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
              Icon(iconName, size: 18, color: finalText),
            ],
            if (external) ...[
              SizedBox(width: spacing.scaledXs),
              Icon(Icons.open_in_new, size: 14, color: finalText),
            ],
          ],
        );

        return GestureDetector(
          onTap: (disabled || loading) ? null : onPressed,
          child: Container(
            width: fullWidth ? double.infinity : null,
            padding: finalPadding,
            decoration: BoxDecoration(
              color: finalBackground,
              borderRadius: BorderRadius.circular(finalRadius),
              border: finalBorderWidth > 0
                  ? Border.all(color: finalBorder, width: finalBorderWidth)
                  : null,
            ),
            child: content,
          ),
        );
      },
    );
  }
}
