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

        final theme = Theme.of(context);
        final colorScheme = theme.colorScheme;
        final bool isDark = theme.brightness == Brightness.dark;

        // Default to normal
        if (disabled) {
          backgroundColor = colors.tokens.colorBackgroundButtonNormalDisabled;
          textColor = colors.tokens.colorTextButtonNormalDisabled;
          borderColor = colors.tokens.colorBorderButtonNormalDisabled;
        } else if (isActive) {
          backgroundColor = colorScheme.primary.withAlpha(30);
          textColor = _applyActive(colorScheme.primary, isDark);
          borderColor = _applyActive(colorScheme.primary, isDark);
        } else if (isHovered) {
          backgroundColor = colorScheme.primary.withAlpha(30);
          textColor = _applyHover(colorScheme.primary, isDark);
          borderColor = _applyHover(colorScheme.primary, isDark);
        } else {
          backgroundColor = colors.tokens.colorBackgroundButtonNormalDefault;
          // Use the dynamic primary color to ensure consistency across themes.
          textColor = colorScheme.primary;
          borderColor = colorScheme.primary;
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
              finalBackground = _applyActive(colorScheme.primary, isDark);
              finalText = colorScheme.onPrimary;
            } else if (isHovered) {
              finalBackground = _applyHover(colorScheme.primary, isDark);
              finalText = colorScheme.onPrimary;
            } else {
              finalBackground = colorScheme.primary;
              finalText = colorScheme.onPrimary;
            }
            finalBorder = Colors.transparent;
            finalBorderWidth = 0;
            break;
          case ButtonVariant.link:
          case ButtonVariant.inlineLink:
            finalBackground = isInteracting
                ? colorScheme.primary.withAlpha(30)
                : Colors.transparent;
            finalText = isInteracting
                ? _applyHover(colorScheme.primary, isDark)
                : colorScheme.primary;
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
                ? colorScheme.primary.withAlpha(30)
                : Colors.transparent;
            finalText = disabled
                ? colors.tokens.colorTextButtonIconDisabled
                : (isInteracting
                      ? _applyHover(colorScheme.primary, isDark)
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

  Color _applyHover(Color color, bool isDark) {
    // Cloudscape: hover is darker in light mode, lighter in dark mode
    if (isDark) {
      return HSVColor.fromColor(color)
          .withSaturation(
            (HSVColor.fromColor(color).saturation - 0.1).clamp(0.0, 1.0),
          )
          .withValue((HSVColor.fromColor(color).value + 0.1).clamp(0.0, 1.0))
          .toColor();
    } else {
      return HSVColor.fromColor(color)
          .withValue((HSVColor.fromColor(color).value - 0.1).clamp(0.0, 1.0))
          .toColor();
    }
  }

  Color _applyActive(Color color, bool isDark) {
    if (isDark) {
      return HSVColor.fromColor(color)
          .withSaturation(
            (HSVColor.fromColor(color).saturation - 0.2).clamp(0.0, 1.0),
          )
          .withValue((HSVColor.fromColor(color).value + 0.2).clamp(0.0, 1.0))
          .toColor();
    } else {
      return HSVColor.fromColor(color)
          .withValue((HSVColor.fromColor(color).value - 0.2).clamp(0.0, 1.0))
          .toColor();
    }
  }
}
