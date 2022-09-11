import 'package:flutter/material.dart';
import 'package:happyo/page/event/form/event_form_label.dart';
import 'package:happyo/page/event/form/form_label_badge.dart';

class EventTextField extends StatelessWidget {
  EventFormLabel? label;
  bool required;
  TextEditingController? controller;
  Function(String)? onChanged;
  int? maxLines;

  EventTextField({
    super.key,
    this.label,
    this.required = true,
    this.controller,
    this.onChanged,
    this.maxLines,
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
        ),
      ],
    );
  }
}
