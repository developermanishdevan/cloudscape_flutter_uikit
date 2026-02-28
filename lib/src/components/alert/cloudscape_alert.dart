import 'package:flutter/material.dart';

import '../../foundation/theme/cloudscape_theme.dart';
import '../base/component_base.dart';

/// The type of alert message.
enum AlertType { success, error, warning, info }

/// Alert Component based on Cloudscape Visual Refresh specs.
class CloudscapeAlert extends StatelessWidget {
  /// Defines the semantic meaning of the alert.
  final AlertType type;

  /// Heading text.
  final Widget? header;

  /// Primary text displayed in the element.
  final Widget child;

  /// Adds a close button to the alert when set to `true`.
  final bool dismissible;

  /// Adds an aria-label to the dismiss button.
  final String? dismissAriaLabel;

  /// Specifies an action for the alert message.
  final Widget? action;

  /// Fired when the user clicks the close icon that is displayed
  /// when the `dismissible` property is set to `true`.
  final VoidCallback? onDismiss;

  /// Determines whether the alert is displayed.
  final bool visible;

  const CloudscapeAlert({
    super.key,
    this.type = AlertType.info,
    required this.child,
    this.header,
    this.dismissible = false,
    this.dismissAriaLabel,
    this.action,
    this.onDismiss,
    this.visible = true,
  });

  @override
  Widget build(BuildContext context) {
    if (!visible) return const SizedBox.shrink();

    final colors = context.cloudscapeColors;
    final typography = context.cloudscapeTypography;
    final spacing = context.cloudscapeSpacing;
    final radius = context.cloudscapeRadius;
    final borderWidth = context.cloudscapeBorderWidth;

    final Color backgroundColor;
    final Color borderColor;
    final Color iconColor;
    final IconData iconData;

    switch (type) {
      case AlertType.success:
        backgroundColor = colors.status.successBackground;
        borderColor = colors.status.successBorder;
        iconColor = colors.status.success;
        iconData = Icons.check_circle_outline_rounded;
        break;
      case AlertType.error:
        backgroundColor = colors.status.errorBackground;
        borderColor = colors.status.errorBorder;
        iconColor = colors.status.error;
        iconData = Icons.error_outline_rounded;
        break;
      case AlertType.warning:
        backgroundColor = colors.status.warningBackground;
        borderColor = colors.status.warningBorder;
        iconColor = colors.status.warning;
        iconData = Icons.warning_amber_rounded;
        break;
      case AlertType.info:
        backgroundColor = colors.status.infoBackground;
        borderColor = colors.status.infoBorder;
        iconColor = colors.status.info;
        iconData = Icons.info_outline_rounded;
        break;
    }

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: borderColor, width: borderWidth.alert),
        borderRadius: BorderRadius.circular(radius.alert),
      ),
      padding: EdgeInsets.symmetric(
        vertical: spacing.scaledS,
        horizontal: spacing.scaledM,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: spacing.scaledXxxs),
            child: Icon(
              iconData,
              color: iconColor,
              size: typography.headingS.fontSize,
            ),
          ),
          SizedBox(width: spacing.scaledS),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (header != null)
                  DefaultTextStyle(
                    style: typography.bodyM.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colors.text.bodyDefault,
                    ),
                    child: header!,
                  ),
                if (header != null) SizedBox(height: spacing.scaledXxs),
                DefaultTextStyle(
                  style: typography.bodyM.copyWith(
                    color: colors.text.bodyDefault,
                  ),
                  child: child,
                ),
              ],
            ),
          ),
          if (action != null) ...[SizedBox(width: spacing.scaledM), action!],
          if (dismissible) ...[
            SizedBox(width: spacing.scaledS),
            _AlertDismissButton(
              onDismiss: onDismiss,
              ariaLabel: dismissAriaLabel ?? 'Dismiss',
            ),
          ],
        ],
      ),
    );
  }
}

class _AlertDismissButton extends StatelessWidget {
  final VoidCallback? onDismiss;
  final String ariaLabel;

  const _AlertDismissButton({required this.onDismiss, required this.ariaLabel});

  @override
  Widget build(BuildContext context) {
    final colors = context.cloudscapeColors;
    final spacing = context.cloudscapeSpacing;
    final typography = context.cloudscapeTypography;
    final radius = context.cloudscapeRadius;

    return ComponentsBase(
      label: ariaLabel,
      isButton: true,
      builder: (context, isHovered) {
        return GestureDetector(
          onTap: onDismiss,
          child: Container(
            decoration: BoxDecoration(
              color: isHovered
                  ? colors.backgrounds.buttonNormalHover
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(radius.button),
            ),
            padding: EdgeInsets.all(spacing.scaledXxs),
            child: Icon(
              Icons.close_rounded,
              size: typography.headingS.fontSize,
              color: colors.text.bodyDefault,
            ),
          ),
        );
      },
    );
  }
}
