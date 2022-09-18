import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:happyo/common/custom_time_picker.dart';
import 'package:happyo/common/format.dart';
import 'package:happyo/page/event/form/event_form_label.dart';
import 'package:happyo/page/event/form/form_label_badge.dart';
import 'package:intl/intl.dart';

class EventTimePicker extends StatefulWidget {
  EventFormLabel? label;
  DateTime? currentTime;
  Function(DateTime?)? onChanged;
  bool required;

  EventTimePicker({
    super.key,
    this.label,
    this.currentTime,
    this.onChanged,
    this.required = false,
  });

  @override
  State<StatefulWidget> createState() => _EventTimePickerState();
}

class _EventTimePickerState extends State<EventTimePicker> {
  @override
  Widget build(BuildContext context) {
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
          onPressed: () async {},
          child: TextButton(
            onPressed: _onPressed,
            child: SizedBox(
              width: double.infinity,
              child: widget.currentTime == null
                  ? const Text('時刻未選択')
                  : Text(
                      DateFormat(Format.DATETIME_HHMM_JP)
                          .format(widget.currentTime!),
                    ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _onPressed() async {
    widget.currentTime ??= DateTime.now();
    if (kIsWeb) {
      final time = await showTimePicker(
        context: context,
        initialTime: widget.currentTime != null
            ? TimeOfDay.fromDateTime(widget.currentTime!)
            : TimeOfDay.now(),
        initialEntryMode: TimePickerEntryMode.input,
      );
      widget.currentTime = DateTime(
        widget.currentTime!.year,
        widget.currentTime!.month,
        widget.currentTime!.day,
        time!.hour,
        time.minute,
      );
    } else {
      var time = await DatePicker.showTimePicker(
        context,
        locale: LocaleType.jp,
      );
      if (time != null) {
        widget.currentTime = DateTime(
          widget.currentTime!.year,
          widget.currentTime!.month,
          widget.currentTime!.day,
          time.hour,
          time.minute,
        );
      }
    }
    if (widget.onChanged != null) {
      widget.onChanged!(widget.currentTime);
    }
  }
}
