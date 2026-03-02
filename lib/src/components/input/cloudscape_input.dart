import 'package:flutter/material.dart';
import '../../foundation/theme/cloudscape_theme.dart';
import '../base/component_base.dart';
import '../button/cloudscape_button.dart';

/// A single-line text input field based on Cloudscape Design System.
class CloudscapeInput extends StatefulWidget {
  /// The current value of the input.
  final String? value;

  /// Called when the value changes.
  final ValueChanged<String>? onChange;

  /// The placeholder text to display when the input is empty.
  final String? placeholder;

  /// Whether the input is disabled.
  final bool disabled;

  /// Whether the input is read-only.
  final bool readOnly;

  /// Whether the input is in an invalid state.
  final bool invalid;

  /// Whether to show a clear button when the input is not empty.
  final bool clearable;

  /// The type of keyboard to use for input.
  final TextInputType keyboardType;

  /// An optional widget to display at the beginning of the input (e.g., an icon).
  final Widget? prefix;

  /// Whether the input should automatically request focus.
  final bool autoFocus;

  /// A controller for the text field. If not provided, one is created internally.
  final TextEditingController? controller;

  /// A focus node for the text field.
  final FocusNode? focusNode;

  /// Whether to obscure the text (e.g., for passwords).
  final bool obscureText;

  /// Custom padding inside the input field.
  final EdgeInsetsGeometry? contentPadding;

  /// An optional widget to display at the end of the input (e.g., an icon).
  final Widget? suffix;

  const CloudscapeInput({
    super.key,
    this.value,
    this.onChange,
    this.placeholder,
    this.disabled = false,
    this.readOnly = false,
    this.invalid = false,
    this.clearable = false,
    this.keyboardType = TextInputType.text,
    this.prefix,
    this.autoFocus = false,
    this.controller,
    this.focusNode,
    this.obscureText = false,
    this.contentPadding,
    this.suffix,
  });

  @override
  State<CloudscapeInput> createState() => _CloudscapeInputState();
}

class _CloudscapeInputState extends State<CloudscapeInput> {
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
  void didUpdateWidget(CloudscapeInput oldWidget) {
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
          borderColor = colors
              .borders
              .inputFocused; // Fallback normally would be an error color, but let's use the standard focus if missing on borders
          borderColor = colors.status.error; // Prefer status error color
          borderWidth = border.field * 2;
        } else if (_isFocused) {
          borderColor = colors.borders.inputFocused;
          borderWidth = border.field * 2;
        } else if (isHovered && !widget.disabled && !widget.readOnly) {
          borderColor = colors.borders.controlDefault; // Hover border
        } else {
          borderColor = colors.borders.inputDefault;
        }

        final textColor = widget.disabled
            ? colors.text.interactiveDisabled
            : colors.text.bodyDefault;

        final hasClearButton =
            widget.clearable &&
            !widget.disabled &&
            !widget.readOnly &&
            _controller.text.isNotEmpty;

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
            child: Row(
              children: [
                if (widget.prefix != null) ...[
                  Padding(
                    padding: EdgeInsets.only(left: spacing.scaledXs),
                    child: widget.prefix,
                  ),
                ],
                Expanded(
                  child: TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    enabled: !widget.disabled,
                    readOnly: widget.readOnly,
                    autofocus: widget.autoFocus,
                    keyboardType: widget.keyboardType,
                    obscureText: widget.obscureText,
                    style: typography.bodyM.copyWith(color: textColor),
                    cursorColor: colors.borders.inputFocused,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding:
                          widget.contentPadding ??
                          EdgeInsets.symmetric(
                            horizontal: spacing.scaledXs,
                            vertical: spacing.scaledXs,
                          ),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: widget.placeholder,
                      hintStyle: typography.bodyM.copyWith(
                        color: colors.text.bodySecondary,
                      ),
                    ),
                    onChanged: (val) {
                      widget.onChange?.call(val);
                      if (widget.clearable) {
                        setState(() {}); // Update clear button visibility
                      }
                    },
                  ),
                ),
                if (hasClearButton)
                  CloudscapeButton(
                    variant: ButtonVariant.inlineIcon,
                    iconName: Icons.close,
                    ariaLabel: 'Clear input',
                    onPressed: () {
                      _controller.clear();
                      widget.onChange?.call('');
                      _focusNode.requestFocus();
                      setState(() {});
                    },
                  ),
                if (widget.suffix != null) ...[
                  Padding(
                    padding: EdgeInsets.only(right: spacing.scaledXs),
                    child: widget.suffix,
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
