import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:happyo/common/format.dart';
import 'package:happyo/page/event/form/event_form_label.dart';
import 'package:intl/intl.dart';

class EventDatePicker extends StatefulWidget {
  EventFormLabel? label;
  DateTime initialDate;
  DateTime firstDate;
  DateTime lastDate;
  Function(DateTime?)? onChanged;

  EventDatePicker({
    super.key,
    this.label,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    required this.onChanged,
  });

  @override
  State<StatefulWidget> createState() => _EventDatePickerState();
}

class _EventDatePickerState extends State<EventDatePicker> {
  late DateTime _datetime;
  @override
  Widget build(BuildContext context) {
    _datetime = widget.initialDate;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) widget.label!,
        TextButton(
          onPressed: () async {
            DateTime? datetime;
            if (kIsWeb) {
              datetime = await showDatePicker(
                  context: context,
                  initialDate: widget.initialDate,
                  firstDate: widget.firstDate,
                  lastDate: widget.lastDate);
            } else {
              datetime = await DatePicker.showDatePicker(context);
            }
            if (widget.onChanged != null) {
              widget.onChanged!(datetime);
            }
          },
          child: SizedBox(
            width: double.infinity,
            child: () {
              if (_datetime != null) {
                return Text(
                    DateFormat(Format.DATETIME_YYYYMMDD_JP).format(_datetime));
              } else {
                return const Text('日にち未選択');
              }
            }(),
          ),
        ),
      ],
    );
  }
}
