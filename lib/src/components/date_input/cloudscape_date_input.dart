import 'package:flutter/material.dart';
import '../input/cloudscape_input.dart';

/// A date input field based on Cloudscape Design System.
class CloudscapeDateInput extends StatefulWidget {
  /// The current date string in 'YYYY-MM-DD' format.
  final String? value;

  /// Called when the date changes.
  final ValueChanged<String>? onChange;

  /// The placeholder text to display. Defaults to 'YYYY-MM-DD'.
  final String placeholder;

  /// Whether the input is disabled.
  final bool disabled;

  /// Whether the input is read-only.
  final bool readOnly;

  /// Whether the input is in an invalid state.
  final bool invalid;

  const CloudscapeDateInput({
    super.key,
    this.value,
    this.onChange,
    this.placeholder = 'YYYY-MM-DD',
    this.disabled = false,
    this.readOnly = false,
    this.invalid = false,
  });

  @override
  State<CloudscapeDateInput> createState() => _CloudscapeDateInputState();
}

class _CloudscapeDateInputState extends State<CloudscapeDateInput> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
  }

  @override
  void didUpdateWidget(CloudscapeDateInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value && _controller.text != widget.value) {
      _controller.text = widget.value ?? '';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    if (widget.disabled || widget.readOnly) return;

    DateTime initialDate = DateTime.now();
    if (widget.value != null && widget.value!.isNotEmpty) {
      try {
        final parsed = DateTime.parse(widget.value!);
        initialDate = parsed;
      } catch (e) {
        // Ignore parsing errors, stick to DateTime.now()
      }
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      final formattedDate =
          '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
      _controller.text = formattedDate;
      widget.onChange?.call(formattedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CloudscapeInput(
      controller: _controller,
      placeholder: widget.placeholder,
      disabled: widget.disabled,
      readOnly: widget.readOnly,
      invalid: widget.invalid,
      keyboardType: TextInputType.datetime,
      onChange: widget.onChange,
      suffix: MouseRegion(
        cursor: (widget.disabled || widget.readOnly)
            ? SystemMouseCursors.basic
            : SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => _selectDate(context),
          child: const Icon(Icons.calendar_today_outlined, size: 18),
        ),
      ),
    );
  }
}
