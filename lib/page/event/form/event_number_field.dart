import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:happyo/page/event/form/event_form_label.dart';
import 'package:happyo/page/event/form/form_label_badge.dart';

class EventNumberField extends StatelessWidget {
  EventFormLabel? label;
  bool required;
  TextEditingController? controller;
  Function(String)? onChanged;
  int? maxLines;
  TextInputType? keyboardType;
  String? Function(String?)? validator;

  EventNumberField({
    super.key,
    this.label,
    this.required = false,
    this.controller,
    this.onChanged,
    this.maxLines,
    this.keyboardType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label != null
            ? Row(children: [
                label!,
                required ? FormLabelBadge() : Container(),
              ])
            : Container(),
        TextFormField(
          controller: controller,
          onChanged: onChanged,
          maxLines: maxLines,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: validator,
        ),
      ],
    );
  }
}
