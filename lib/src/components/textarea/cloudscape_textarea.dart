import 'package:flutter/material.dart';
import '../../foundation/theme/cloudscape_theme.dart';
import '../base/component_base.dart';

/// A multi-line text input field based on Cloudscape Design System.
class CloudscapeTextarea extends StatefulWidget {
  /// The current value of the textarea.
  final String? value;

  /// Called when the value changes.
  final ValueChanged<String>? onChange;

  /// The placeholder text to display when the textarea is empty.
  final String? placeholder;

  /// Whether the textarea is disabled.
  final bool disabled;

  /// Whether the textarea is read-only.
  final bool readOnly;

  /// Whether the textarea is in an invalid state.
  final bool invalid;

  /// The number of rows to display. Defaults to 3.
  final int rows;

  /// Whether the textarea should automatically request focus.
  final bool autoFocus;

  /// A controller for the text field. If not provided, one is created internally.
  final TextEditingController? controller;

  /// A focus node for the text field.
  final FocusNode? focusNode;

  /// The type of keyboard to use.
  final TextInputType keyboardType;

  const CloudscapeTextarea({
    super.key,
    this.value,
    this.onChange,
    this.placeholder,
    this.disabled = false,
    this.readOnly = false,
    this.invalid = false,
    this.rows = 3,
    this.autoFocus = false,
    this.controller,
    this.focusNode,
    this.keyboardType = TextInputType.multiline,
  });

  @override
  State<CloudscapeTextarea> createState() => _CloudscapeTextareaState();
}

class _CloudscapeTextareaState extends State<CloudscapeTextarea> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _controller =
        widget.controller ?? TextEditingController(text: widget.value);
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void didUpdateWidget(CloudscapeTextarea oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller == null && widget.value != oldWidget.value) {
      if (_controller.text != widget.value) {
        _controller.text = widget.value ?? '';
      }
    }
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    if (widget.controller == null) {
      _controller.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.cloudscapeColors;
    final typography = context.cloudscapeTypography;
    final spacing = context.cloudscapeSpacing;
    final radius = context.cloudscapeRadius;
    final border = context.cloudscapeBorderWidth;

    return ComponentsBase(
      enabled: !widget.disabled,
      cursor: widget.disabled
          ? SystemMouseCursors.forbidden
          : SystemMouseCursors.text,
      builder: (context, isHovered) {
        // Determine border and background colors based on state
        Color backgroundColor = widget.disabled
            ? colors.backgrounds.inputDisabled
            : colors.backgrounds.inputDefault;

        Color borderColor;
        double borderWidth = border.field;

        if (widget.invalid) {
          borderColor = colors.status.error;
          borderWidth = border.field * 2;
        } else if (_isFocused) {
          borderColor = colors.borders.inputFocused;
          borderWidth = border.field * 2;
        } else if (isHovered && !widget.disabled && !widget.readOnly) {
          borderColor = colors.borders.controlDefault;
        } else {
          borderColor = colors.borders.inputDefault;
        }

        final textColor = widget.disabled
            ? colors.text.interactiveDisabled
            : colors.text.bodyDefault;

        return GestureDetector(
          onTap: () {
            if (!widget.disabled && !widget.readOnly) {
              _focusNode.requestFocus();
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(color: borderColor, width: borderWidth),
              borderRadius: BorderRadius.circular(radius.input),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: spacing.scaledXs,
              vertical: spacing.scaledXs + 2,
            ),
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              enabled: !widget.disabled,
              readOnly: widget.readOnly,
              autofocus: widget.autoFocus,
              keyboardType: widget.keyboardType,
              maxLines: widget.rows,
              minLines: widget.rows,
              style: typography.bodyM.copyWith(color: textColor),
              cursorColor: colors.borders.inputFocused,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: widget.placeholder,
                hintStyle: typography.bodyM.copyWith(
                  color: colors.text.bodySecondary,
                ),
              ),
              onChanged: widget.onChange,
            ),
          ),
        );
      },
    );
  }
}
