import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:happyo/common/format.dart';
import 'package:happyo/page/event/form/event_form_label.dart';
import 'package:happyo/page/event/form/form_label_badge.dart';
import 'package:intl/intl.dart';

class EventDateField extends FormField<DateTime> {
  EventDateField({
    Key? key,
    EventFormLabel? label,
    required DateTime? initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
    required ValueChanged<DateTime?>? onChanged,
    InputDecoration? decoration,
    FormFieldSetter<DateTime?>? onSaved,
    FormFieldValidator<DateTime?>? validator,
    bool required = false,
    AutovalidateMode? autovalidateMode,
  }) : super(
          key: key,
          initialValue: initialDate,
          builder: (FormFieldState<DateTime> field) {
            var currentDate = initialDate;
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
                      onPressed: () async {
                        if (kIsWeb) {
                          currentDate = await showDatePicker(
                              context: context,
                              initialDate: initialDate ?? firstDate,
                              firstDate: firstDate,
                              lastDate: lastDate);
                        } else {
                          currentDate = await DatePicker.showDatePicker(
                            context,
                            locale: LocaleType.jp,
                          );
                        }
                        if (initialDate != null && currentDate != null) {
                          currentDate = DateTime(
                            currentDate!.year,
                            currentDate!.month,
                            currentDate!.day,
                            initialDate!.hour,
                            initialDate!.minute,
                          );
                        }
                        field.didChange(currentDate);
                        onChanged?.call(currentDate);
                        field.setState(() {
                          initialDate = currentDate;
                        });
                      },
                      child: SizedBox(
                        width: double.infinity,
                        child: initialDate == null
                            ? const Text('日にち未選択')
                            : Text(DateFormat(Format.DATETIME_YYYYMMDD_JP)
                                .format(currentDate!)),
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
