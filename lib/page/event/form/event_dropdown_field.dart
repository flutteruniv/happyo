import 'package:flutter/material.dart';
import 'package:happyo/page/event/form/event_form_label.dart';
import 'package:happyo/page/event/form/form_label_badge.dart';

class EventDropdownField extends StatelessWidget {
  EventFormLabel? label;
  bool required;
  List<DropdownMenuItem<int>> items;
  void Function(int?)? onChanged;
  String? Function(int?)? validator;

  EventDropdownField({
    super.key,
    this.label,
    this.required = false,
    required this.items,
    this.onChanged,
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
        DropdownButtonFormField(
          isExpanded: true,
          items: items,
          onChanged: onChanged,
          validator: validator,
        ),
      ],
    );
  }
}
