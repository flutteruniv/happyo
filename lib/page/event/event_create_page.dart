import 'package:flutter/material.dart';
import 'package:happyo/common/format.dart';
import 'package:happyo/common/logger.dart';
import 'package:happyo/model/event/happyo_event.dart';
import 'package:happyo/page/event/form/event_date_picker.dart';
import 'package:happyo/page/event/form/event_form_group.dart';
import 'package:happyo/page/event/form/event_form_group_header.dart';
import 'package:happyo/page/event/form/event_form_label.dart';
import 'package:happyo/page/event/form/event_image_form.dart';
import 'package:happyo/page/event/form/event_number_field.dart';
import 'package:happyo/page/event/form/event_text_field.dart';
import 'package:happyo/page/event/form/event_time_picker.dart';
import 'package:intl/intl.dart';

class EventCreatePage extends StatefulWidget {
  const EventCreatePage({super.key});

  @override
  EventCreatePageState createState() => EventCreatePageState();
}

class EventCreatePageState extends State<EventCreatePage> {
  late HappyoEvent event;
  late DateTime nowDateTime;
  late TimeOfDay nowTimeOfDay;

  @override
  void initState() {
    event = HappyoEvent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    nowDateTime = DateTime.now();
    nowTimeOfDay = TimeOfDay.now();

    return Scaffold(
      appBar: AppBar(
        title: const Text('イベント作成'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 9),
            child: TextButton(
              onPressed: _uploadEvent,
              child: const Text('確定する'),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 32,
          ),
          child: Column(
            children: [
              // イベント基本情報
              EventFormGroup(
                header: EventFormGroupHeader('イベント基本情報'),
                children: [
                  EventTextField(
                    label: EventFormLabel('イベントタイトル'),
                    onChanged: _updateEventTitle,
                  ),
                  EventImageForm(
                    label: EventFormLabel('イベント画像'),
                  ),
                ],
              ),
              // イベント情報
              EventFormGroup(
                header: EventFormGroupHeader('イベント情報'),
                children: [
                  EventDatePicker(
                    label: EventFormLabel('イベント開始日'),
                    initialDate: event.eventStartDateTime ?? nowDateTime,
                    firstDate: nowDateTime,
                    lastDate: nowDateTime.add(const Duration(days: 3650)),
                    onChanged: _updateEventStartDate,
                  ),
                  EventTimePicker(
                    label: EventFormLabel('イベント開始時間'),
                    currentTime: event.eventStartDateTime != null
                        ? TimeOfDay.fromDateTime(event.eventStartDateTime!)
                        : nowTimeOfDay,
                    onChanged: _updateEventStartTime,
                  ),
                  EventDatePicker(
                    label: EventFormLabel('イベント終了日'),
                    initialDate: event.eventEndDateTime ?? nowDateTime,
                    firstDate: nowDateTime,
                    lastDate: nowDateTime.add(const Duration(days: 3650)),
                    onChanged: _updateEventEndDate,
                  ),
                  EventTimePicker(
                    label: EventFormLabel('イベント終了時間'),
                    currentTime: event.eventEndTime != null
                        ? TimeOfDay.fromDateTime(event.eventEndDateTime!)
                        : nowTimeOfDay,
                    onChanged: _updateEventEndTime,
                  ),
                  EventTextField(
                    label: EventFormLabel('イベント開催場所'),
                    onChanged: (text) {
                      event = event.copyWith(location: text);
                    },
                  ),
                  EventTextField(
                    label: EventFormLabel('イベントの説明'),
                    maxLines: 10,
                    onChanged: (text) {
                      event = event.copyWith(description: text);
                    },
                  ),
                ],
              ),
              // 募集情報
              EventFormGroup(
                header: EventFormGroupHeader('募集情報'),
                children: [
                  EventNumberField(
                    label: EventFormLabel('定員'),
                    onChanged: (text) {
                      event = event.copyWith(capacity: int.tryParse(text));
                    },
                  ),
                  EventDatePicker(
                    label: EventFormLabel('募集開始日'),
                    initialDate: nowDateTime,
                    firstDate: nowDateTime,
                    lastDate: nowDateTime.add(
                      const Duration(days: 3650),
                    ),
                    onChanged: null,
                  ),
                  EventTimePicker(
                    label: EventFormLabel('募集開始時間'),
                    currentTime: nowTimeOfDay,
                  ),
                  EventDatePicker(
                    label: EventFormLabel('募集締切日'),
                    initialDate: nowDateTime,
                    firstDate: nowDateTime,
                    lastDate: nowDateTime.add(
                      const Duration(days: 3650),
                    ),
                    onChanged: null,
                  ),
                  EventTimePicker(
                    label: EventFormLabel('募集締切時間'),
                    currentTime: nowTimeOfDay,
                  ),
                ],
              ),
              // 動画コンテンツ情報
              EventFormGroup(
                header: EventFormGroupHeader('動画コンテンツ情報'),
                children: [
                  EventDatePicker(
                    label: EventFormLabel('動画配信予定日'),
                    initialDate: nowDateTime,
                    firstDate: nowDateTime,
                    lastDate: nowDateTime.add(
                      const Duration(days: 3650),
                    ),
                    onChanged: null,
                  ),
                  EventTimePicker(
                    label: EventFormLabel('動画配信予定時間'),
                    currentTime: nowTimeOfDay,
                  ),
                  EventTextField(
                    label: EventFormLabel('動画配信タイプ'),
                    controller: null,
                  ),
                  EventTextField(
                    label: EventFormLabel('動画保存場所'),
                    controller: null,
                  ),
                  EventTextField(
                    label: EventFormLabel('動画URL'),
                    onChanged: (text) {
                      event = event.copyWith(videoUrl: text);
                    },
                  ),
                ],
              ),
              EventTextField(
                label: EventFormLabel('注意事項'),
                onChanged: (text) {
                  event = event.copyWith(notes: text);
                },
              ),
              EventTextField(
                label: EventFormLabel('問合せ先メールアドレス'),
                onChanged: (text) {
                  event = event.copyWith(inquiryEmailAddress: text);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _uploadEvent() {
    logger.debug("upload event:", event);
  }

  _updateEventTitle(title) {
    event = event.copyWith(title: title);
  }

  _updateEventStartDate(date) {
    if (date != null) {
      setState(() {
        event = event.copyWith(
            eventStartDate:
                DateFormat(DateFormat.YEAR_NUM_MONTH_DAY).format(date));
        event = event.copyWith(
          eventStartDateTime: DateTime(
            date.year,
            date.month,
            date.day,
            event.eventStartDateTime?.hour ?? nowTimeOfDay.hour,
            event.eventStartDateTime?.minute ?? nowTimeOfDay.minute,
          ),
          eventStartDate: DateFormat(Format.DATETIME_YYYYMMDD).format(date),
        );
      });
    }
  }

  _updateEventStartTime(time) {
    if (time != null) {
      setState(() {
        event = event.copyWith(
          eventStartDateTime: DateTime(
            event.eventStartDateTime?.year ?? nowDateTime.year,
            event.eventStartDateTime?.month ?? nowDateTime.month,
            event.eventStartDateTime?.day ?? nowDateTime.day,
            time.hour,
            time.minute,
          ),
          eventStartTime: time.format(context),
        );
      });
    }
  }

  _updateEventEndDate(date) {
    if (date != null) {
      setState(() {
        event = event.copyWith(
            eventEndDate:
                DateFormat(DateFormat.YEAR_NUM_MONTH_DAY).format(date));
        event = event.copyWith(
          eventEndDateTime: DateTime(
            date.year,
            date.month,
            date.day,
            event.eventEndDateTime?.hour ?? nowTimeOfDay.hour,
            event.eventEndDateTime?.minute ?? nowTimeOfDay.minute,
          ),
          eventEndDate: DateFormat(Format.DATETIME_YYYYMMDD).format(date),
        );
      });
    }
  }

  _updateEventEndTime(time) {
    if (time != null) {
      setState(() {
        event = event.copyWith(
          eventEndDateTime: DateTime(
            event.eventEndDateTime?.year ?? nowDateTime.year,
            event.eventEndDateTime?.month ?? nowDateTime.month,
            event.eventEndDateTime?.day ?? nowDateTime.day,
            time.hour,
            time.minute,
          ),
          eventEndTime: time.format(context),
        );
      });
    }
  }
}
