import 'package:flutter/material.dart';
import '../../foundation/theme/cloudscape_theme.dart';
import '../../foundation/tokens/radius.dart';
import '../../foundation/tokens/spacing.dart';
import '../base/component_base.dart';

/// A base card component for Cloudscape Design System.
///
/// Follows the design pattern of having a specialized header/visual area
/// and a content area below it, separated by a thin divider.
class CloudscapeCard extends StatelessWidget {
  /// The widget to display in the top section of the card.
  /// Usually contains a visual representation or preview of a component.
  final Widget? header;

  /// The main content of the card, displayed in the bottom section.
  final Widget body;

  /// Padding applied to the header section.
  /// Defaults to [CloudscapeSpacing.medium].
  final EdgeInsets? headerPadding;

  /// Padding applied to the body section.
  /// Defaults to [CloudscapeSpacing.medium].
  final EdgeInsets? bodyPadding;

  /// Optional callback when the card is tapped.
  final VoidCallback? onTap;

  /// Border radius for the card.
  /// Defaults to [CloudscapeRadius.brMedium].
  final BorderRadius? borderRadius;

  const CloudscapeCard({
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
    final theme = CloudscapeThemeExtension.of(context);
    final effectiveBorderRadius = borderRadius ?? CloudscapeRadius.brMedium;

    return ComponentsBase(
      onPointerEnter:
          (_) {}, // Enable hover tracking if needed by ComponentsBase
      builder: (context, isHovered) {
        return GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: theme.colors.backgroundContainerContent,
              borderRadius: effectiveBorderRadius,
              border: Border.all(color: theme.colors.borderDefault, width: 1),
              boxShadow: isHovered && onTap != null
                  ? [
                      BoxShadow(
                        color: theme.colors.borderDefault.withValues(
                          alpha: 0.3,
                        ),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: ClipRRect(
              borderRadius:
                  effectiveBorderRadius -
                  BorderRadius.all(
                    Radius.circular(1),
                  ), // Slightly less to account for border
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (header != null) ...[
                    Container(
                      color: theme.colors.backgroundContainerMain,
                      padding:
                          headerPadding ??
                          const EdgeInsets.all(CloudscapeSpacing.medium),
                      child: header,
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: theme.colors.borderDividerDefault,
                    ),
                  ],
                  Padding(
                    padding:
                        bodyPadding ??
                        const EdgeInsets.all(CloudscapeSpacing.medium),
                    child: body,
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
