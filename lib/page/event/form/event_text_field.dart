import 'package:flutter/material.dart';
import 'package:happyo/page/event/form/event_form_label.dart';
import 'package:happyo/page/event/form/form_label_badge.dart';

class EventTextField extends StatelessWidget {
  EventFormLabel? label;
  bool required;
  TextEditingController? controller;
  void Function(String)? onChanged;
  int? maxLines;
  int? maxLength;
  String? Function(String?)? validator;

  EventTextField({
    super.key,
    this.label,
    this.required = false,
    this.controller,
    this.onChanged,
    this.maxLines,
    this.maxLength,
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
          autofocus: false,
          controller: controller,
          onChanged: onChanged,
          maxLines: maxLines,
          maxLength: maxLength,
          validator: validator,
        ),
      ],
    );
  }
}
