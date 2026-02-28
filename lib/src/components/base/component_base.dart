import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A function type that returns a widget given a hover state.
typedef ComponentsBaseBuilder =
    Widget Function(BuildContext context, bool isHovered);

/// A base wrapper widget for Cloudscape components.
/// Provides cross-platform capabilities including:
/// - Accessibility via [Semantics]
/// - Mouse interactions via [MouseRegion]
/// - Platform-aware cursors
/// - Hover state feedback
class ComponentsBase extends StatefulWidget {
  /// The child widget. If using [builder], this is ignored.
  final Widget? child;

  /// A builder function that provides the hover state.
  final ComponentsBaseBuilder? builder;

  /// Accessibility label for the component.
  final String? label;

  /// Accessibility hint for the component.
  final String? hint;

  /// Whether the component is currently enabled.
  final bool enabled;

  /// Callback when the mouse enters the region.
  final ValueChanged<PointerEnterEvent>? onPointerEnter;

  /// Callback when the mouse exits the region.
  final ValueChanged<PointerExitEvent>? onPointerExit;

  /// Callback when the mouse hovers over the region.
  final ValueChanged<PointerHoverEvent>? onPointerHover;

  /// The cursor to display when hovering.
  final MouseCursor? cursor;

  /// Whether this widget should be treated as a button by screen readers.
  final bool isButton;

  /// Whether this widget is currently selected/active.
  final bool? selected;

  const ComponentsBase({
    super.key,
    this.child,
    this.builder,
    this.label,
    this.hint,
    this.enabled = true,
    this.onPointerEnter,
    this.onPointerExit,
    this.onPointerHover,
    this.cursor,
    this.isButton = false,
    this.selected,
  }) : assert(
         child != null || builder != null,
         'Either child or builder must be provided.',
       );

  @override
  State<ComponentsBase> createState() => _ComponentsBaseState();
}

class _ComponentsBaseState extends State<ComponentsBase> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor:
          widget.cursor ??
          (widget.enabled
              ? SystemMouseCursors.click
              : SystemMouseCursors.basic),
      onEnter: (event) {
        if (!widget.enabled) return;
        setState(() => _isHovered = true);
        widget.onPointerEnter?.call(event);
      },
      onExit: (event) {
        if (!widget.enabled) return;
        setState(() => _isHovered = false);
        widget.onPointerExit?.call(event);
      },
      onHover: widget.enabled ? widget.onPointerHover : null,
      child: Semantics(
        label: widget.label,
        hint: widget.hint,
        enabled: widget.enabled,
        button: widget.isButton,
        selected: widget.selected,
        container: true,
        child: widget.builder?.call(context, _isHovered) ?? widget.child!,
      ),
    );
  }
}
