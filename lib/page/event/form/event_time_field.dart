import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:happyo/common/custom_time_picker.dart';
import 'package:happyo/common/format.dart';
import 'package:happyo/page/event/form/event_form_label.dart';
import 'package:happyo/page/event/form/form_label_badge.dart';
import 'package:intl/intl.dart';

class EventTimeField extends FormField<DateTime> {
  EventTimeField({
    Key? key,
    EventFormLabel? label,
    required DateTime? initialDateTime,
    required ValueChanged<DateTime?>? onChanged,
    InputDecoration? decoration,
    FormFieldSetter<DateTime?>? onSaved,
    FormFieldValidator<DateTime?>? validator,
    bool required = false,
    AutovalidateMode? autovalidateMode,
  }) : super(
          key: key,
          initialValue: initialDateTime,
          builder: (FormFieldState<DateTime> field) {
            final InputDecoration effectiveDecoration = const InputDecoration()
              ..applyDefaults(Theme.of(field.context).inputDecorationTheme);

            return Builder(builder: (context) {
              return InputDecorator(
                decoration:
                    effectiveDecoration.copyWith(errorText: field.errorText),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        if (label != null) label,
                        required ? FormLabelBadge() : Container(),
                      ],
                    ),
                    TextButton(
                      onPressed: () async {},
                      child: TextButton(
                        onPressed: () async {
                          var currentTime = initialDateTime ?? DateTime.now();
                          if (kIsWeb) {
                            final time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.fromDateTime(currentTime),
                              initialEntryMode: TimePickerEntryMode.input,
                            );
                            currentTime = DateTime(
                              currentTime.year,
                              currentTime.month,
                              currentTime.day,
                              time!.hour,
                              time.minute,
                            );
                          } else {
                            var time = await DatePicker.showTimePicker(
                              context,
                              locale: LocaleType.jp,
                            );
                            if (time != null) {
                              currentTime = DateTime(
                                currentTime.year,
                                currentTime.month,
                                currentTime.day,
                                time.hour,
                                time.minute,
                              );
                            }
                          }
                          field.didChange(currentTime);
                          onChanged?.call(currentTime);
                          field.setState(() {
                            initialDateTime = currentTime;
                          });
                        },
                        child: SizedBox(
                          width: double.infinity,
                          child: initialDateTime == null
                              ? const Text('時刻未選択')
                              : Text(
                                  DateFormat(Format.DATETIME_HHMM_JP)
                                      .format(initialDateTime!),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            });
          },
          validator: validator,
        );
}
