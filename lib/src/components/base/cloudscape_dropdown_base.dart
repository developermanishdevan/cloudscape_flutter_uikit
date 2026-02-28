import 'package:flutter/material.dart';
import '../../foundation/theme/cloudscape_theme.dart';

/// A reusable base for components that need to show a dropdown overlay (like ButtonDropdown, Select, etc.)
class CloudscapeDropdownBase extends StatefulWidget {
  /// The target widget that anchors the dropdown (usually a button or input field).
  final Widget Function(BuildContext context, LayerLink link, bool isOpened)
  targetBuilder;

  /// The content to show inside the dropdown overlay.
  /// Provides the target size and a callback to close the dropdown.
  final Widget Function(
    BuildContext context,
    Size targetSize,
    VoidCallback close,
  )
  dropdownBuilder;

  /// Whether the dropdown should match the target's width.
  final bool fullWidth;

  /// Minimum width of the dropdown if [fullWidth] is false.
  final double minWidth;

  /// Maximum height of the dropdown. If null, it grows based on content.
  final double maxHeight;

  /// Vertical offset from the target.
  final double verticalOffset;

  /// Callback when the dropdown is closed by clicking outside.
  final VoidCallback? onClosed;

  const CloudscapeDropdownBase({
    super.key,
    required this.targetBuilder,
    required this.dropdownBuilder,
    this.fullWidth = false,
    this.minWidth = 220,
    this.maxHeight = 400,
    this.verticalOffset = 4,
    this.onClosed,
  });

  @override
  State<CloudscapeDropdownBase> createState() => CloudscapeDropdownBaseState();
}

class CloudscapeDropdownBaseState extends State<CloudscapeDropdownBase> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpened = false;

  bool get isOpened => _isOpened;

  void toggle() {
    if (_isOpened) {
      close();
    } else {
      open();
    }
  }

  void open() {
    if (_isOpened) return;
    setState(() => _isOpened = true);
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void close() {
    if (!_isOpened) return;
    _overlayEntry?.remove();
    _overlayEntry = null;
    if (mounted) {
      setState(() => _isOpened = false);
    }
    widget.onClosed?.call();
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    Size size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Invisible layer to catch taps outside and close the dropdown
          GestureDetector(
            onTap: close,
            behavior: HitTestBehavior.translucent,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.transparent,
            ),
          ),
          Positioned(
            width: widget.fullWidth ? size.width : widget.minWidth,
            child: CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: Offset(0.0, size.height + widget.verticalOffset),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    context.cloudscapeRadius.dropdown,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Material(
                  borderRadius: BorderRadius.circular(
                    context.cloudscapeRadius.dropdown,
                  ),
                  color: context.cloudscapeColors.backgrounds.containerContent,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color:
                            context.cloudscapeColors.borders.dropdownContainer,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(
                        context.cloudscapeRadius.dropdown,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        context.cloudscapeRadius.dropdown,
                      ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: widget.maxHeight,
                        ),
                        child: SingleChildScrollView(
                          child: widget.dropdownBuilder(context, size, close),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    if (_isOpened) {
      _overlayEntry?.remove();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: widget.targetBuilder(context, _layerLink, _isOpened),
    );
  }
}
