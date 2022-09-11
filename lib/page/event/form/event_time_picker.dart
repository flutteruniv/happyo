import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:happyo/page/event/form/event_form_label.dart';

class EventTimePicker extends StatefulWidget {
  EventFormLabel? label;
  TimeOfDay currentTime;
  Function(TimeOfDay?)? onChanged;

  EventTimePicker({
    super.key,
    this.label,
    required this.currentTime,
    this.onChanged,
  });

  @override
  State<StatefulWidget> createState() => _EventTimePickerState();
}

class _EventTimePickerState extends State<EventTimePicker> {
  TimeOfDay? _time;
  @override
  Widget build(BuildContext context) {
    _time = widget.currentTime;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) widget.label!,
        TextButton(
          onPressed: () async {
            if (kIsWeb) {
              _time = await showTimePicker(
                context: context,
                initialTime: _time!,
                initialEntryMode: TimePickerEntryMode.input,
              );
            } else {
              var time = await DatePicker.showTimePicker(context);
              if (time != null) {
                _time = TimeOfDay.fromDateTime(time);
              }
            }
            if (widget.onChanged != null) {
              widget.onChanged!(_time);
            }
          },
          child: SizedBox(
            width: double.infinity,
            child: () {
              if (_time != null) {
                return Text("${_time!.hour}時${_time!.minute}分");
              } else {
                return const Text("時刻未選択");
              }
            }(),
          ),
        ),
      ],
    );
  }
}
