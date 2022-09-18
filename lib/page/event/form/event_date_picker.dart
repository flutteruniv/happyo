import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:happyo/common/format.dart';
import 'package:happyo/page/event/form/event_form_label.dart';
import 'package:happyo/page/event/form/form_label_badge.dart';
import 'package:intl/intl.dart';

class EventDatePicker extends StatefulWidget {
  EventFormLabel? label;
  DateTime? initialDate;
  DateTime firstDate;
  DateTime lastDate;
  Function(DateTime?)? onChanged;
  bool required;

  EventDatePicker({
    super.key,
    this.label,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    required this.onChanged,
    this.required = false,
  });

  @override
  State<StatefulWidget> createState() => _EventDatePickerState();
}

class _EventDatePickerState extends State<EventDatePicker> {
  DateTime? currentDate;
  @override
  Widget build(BuildContext context) {
    currentDate = widget.initialDate;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (widget.label != null) widget.label!,
            widget.required ? FormLabelBadge() : Container(),
          ],
        ),
        TextButton(
          onPressed: _onPressed,
          child: SizedBox(
            width: double.infinity,
            child: widget.initialDate == null
                ? const Text('日にち未選択')
                : Text(DateFormat(Format.DATETIME_YYYYMMDD_JP)
                    .format(currentDate!)),
          ),
        ),
      ],
    );
  }

  Future<void> _onPressed() async {
    if (kIsWeb) {
      currentDate = await showDatePicker(
          context: context,
          initialDate: widget.initialDate ?? widget.firstDate,
          firstDate: widget.firstDate,
          lastDate: widget.lastDate);
    } else {
      currentDate = await DatePicker.showDatePicker(
        context,
        locale: LocaleType.jp,
      );
    }
    if (widget.onChanged != null) {
      if (widget.initialDate != null) {
        currentDate = DateTime(
          currentDate!.year,
          currentDate!.month,
          currentDate!.day,
          widget.initialDate!.hour,
          widget.initialDate!.minute,
        );
      }
      widget.onChanged!(currentDate);
    }
  }
}
