import 'package:flutter/material.dart';
import '../input/cloudscape_input.dart';

/// A time input field based on Cloudscape Design System.
class CloudscapeTimeInput extends StatefulWidget {
  /// The current time string in 'HH:mm' or 'HH:mm:ss' format.
  final String? value;

  /// Called when the time changes.
  final ValueChanged<String>? onChange;

  /// The placeholder text to display. Defaults to 'hh:mm'.
  final String placeholder;

  /// Whether the input is disabled.
  final bool disabled;

  /// Whether the input is read-only.
  final bool readOnly;

  /// Whether the input is in an invalid state.
  final bool invalid;

  const CloudscapeTimeInput({
    super.key,
    this.value,
    this.onChange,
    this.placeholder = 'hh:mm',
    this.disabled = false,
    this.readOnly = false,
    this.invalid = false,
  });

  @override
  State<CloudscapeTimeInput> createState() => _CloudscapeTimeInputState();
}

class _CloudscapeTimeInputState extends State<CloudscapeTimeInput> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
  }

  @override
  void didUpdateWidget(CloudscapeTimeInput oldWidget) {
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

  Future<void> _selectTime(BuildContext context) async {
    if (widget.disabled || widget.readOnly) return;

    TimeOfDay initialTime = TimeOfDay.now();
    if (widget.value != null && widget.value!.isNotEmpty) {
      try {
        final parts = widget.value!.split(':');
        if (parts.length >= 2) {
          initialTime = TimeOfDay(
            hour: int.parse(parts[0]),
            minute: int.parse(parts[1]),
          );
        }
      } catch (e) {
        // Ignore parsing errors, stick to TimeOfDay.now()
      }
    }

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (picked != null) {
      final formattedTime =
          '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
      _controller.text = formattedTime;
      widget.onChange?.call(formattedTime);
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
          onTap: () => _selectTime(context),
          child: const Icon(Icons.access_time_outlined, size: 18),
        ),
      ),
    );
  }
}
