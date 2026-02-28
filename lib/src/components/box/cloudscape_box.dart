import 'package:flutter/material.dart';
import '../../foundation/theme/cloudscape_theme.dart';
import '../base/component_base.dart';

/// A base card component for Cloudscape Design System.
///
/// Follows the design pattern of having a specialized header/visual area
/// and a content area below it, separated by a thin divider.
class CloudscapeBox extends StatelessWidget {
  /// The widget to display in the top section of the card.
  /// Usually contains a visual representation or preview of a component.
  final Widget? header;

  /// The main content of the card, displayed in the bottom section.
  final Widget body;

  /// Padding applied to the header section.
  final EdgeInsets? headerPadding;

  /// Padding applied to the body section.
  final EdgeInsets? bodyPadding;

  /// Optional callback when the card is tapped.
  final VoidCallback? onTap;

  /// Border radius for the card.
  final BorderRadius? borderRadius;

  const CloudscapeBox({
    super.key,
    this.header,
    required this.body,
    this.headerPadding,
    this.bodyPadding,
    this.onTap,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.cloudscapeColors;
    final spacing = context.cloudscapeSpacing;
    final rds = context.cloudscapeRadius;
    final borderWidth = context.cloudscapeBorderWidth;

    final effectiveBorderRadius =
        borderRadius ?? BorderRadius.all(Radius.circular(rds.container));
    final defaultPadding = EdgeInsets.all(spacing.scaledM);

    return ComponentsBase(
      cursor: onTap != null ? SystemMouseCursors.click : MouseCursor.defer,
      onPointerEnter: (_) {}, // Enable hover tracking needed by ComponentsBase
      builder: (context, isHovered) {
        return GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: colors.tokens.colorBackgroundContainerContent,
              borderRadius: effectiveBorderRadius,
              border: Border.all(
                color: colors.tokens.colorBorderDividerDefault,
                width: borderWidth.container,
              ),
              boxShadow: isHovered && onTap != null
                  ? [
                      BoxShadow(
                        color: colors.tokens.colorBorderDividerDefault
                            .withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: ClipRRect(
              borderRadius:
                  effectiveBorderRadius -
                  const BorderRadius.all(
                    Radius.circular(1),
                  ), // Slightly less to account for border
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (header != null) ...[
                    Container(
                      color: colors.tokens.colorBackgroundContainerHeader,
                      padding: headerPadding ?? defaultPadding,
                      child: header,
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: colors.tokens.colorBorderDividerSecondary,
                    ),
                  ],
                  Padding(padding: bodyPadding ?? defaultPadding, child: body),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
