import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
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
  late File? currentEventImage;

  _getCurrentEventImage() {
    return null;
  }

  @override
  void initState() {
    event = HappyoEvent();
    currentEventImage = _getCurrentEventImage();
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
              onPressed: () {
                if (_validate()) {
                  _uploadEvent();
                }
              },
              child: const Text('確定する'),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 8, left: 32, right: 32, bottom: 60),
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
                    onChanged: _updateCurrentEventImage,
                  ),
                ],
              ),
              // イベント情報
              EventFormGroup(
                header: EventFormGroupHeader('イベント情報'),
                children: [
                  EventDatePicker(
                    label: EventFormLabel('イベント開始日'),
                    initialDate: event.eventStartDateTime,
                    firstDate: nowDateTime,
                    lastDate: nowDateTime.add(const Duration(days: 3650)),
                    onChanged: _updateEventStartDate,
                  ),
                  EventTimePicker(
                    label: EventFormLabel('イベント開始時間'),
                    currentTime: event.eventStartDateTime,
                    onChanged: _updateEventStartTime,
                  ),
                  EventDatePicker(
                    label: EventFormLabel('イベント終了日'),
                    initialDate: event.eventEndDateTime,
                    firstDate: nowDateTime,
                    lastDate: nowDateTime.add(const Duration(days: 3650)),
                    onChanged: _updateEventEndDate,
                  ),
                  EventTimePicker(
                    label: EventFormLabel('イベント終了時間'),
                    currentTime: event.eventEndDateTime,
                    onChanged: _updateEventEndTime,
                  ),
                  EventTextField(
                    label: EventFormLabel('イベント開催場所'),
                    onChanged: _updateEventLocation,
                  ),
                  EventTextField(
                    label: EventFormLabel('イベントの説明'),
                    maxLines: 5,
                    onChanged: _updateEventDescription,
                  ),
                ],
              ),
              // 募集情報
              EventFormGroup(
                header: EventFormGroupHeader('募集情報'),
                children: [
                  EventNumberField(
                    label: EventFormLabel('定員'),
                    onChanged: _updateEventCapacity,
                  ),
                  EventDatePicker(
                    label: EventFormLabel('募集開始日'),
                    initialDate: event.applicationStartDateTime,
                    firstDate: nowDateTime,
                    lastDate: nowDateTime.add(const Duration(days: 3650)),
                    onChanged: _updateApplicationStartDate,
                  ),
                  EventTimePicker(
                    label: EventFormLabel('募集開始時間'),
                    currentTime: event.applicationStartDateTime,
                    onChanged: _updateApplicationStartTime,
                  ),
                  EventDatePicker(
                    label: EventFormLabel('募集締切日'),
                    initialDate: event.applicationDeadDateTime,
                    firstDate: nowDateTime,
                    lastDate: nowDateTime.add(const Duration(days: 3650)),
                    onChanged: _updateApplicationDeadDate,
                  ),
                  EventTimePicker(
                    label: EventFormLabel('募集締切時間'),
                    currentTime: event.applicationDeadDateTime,
                    onChanged: _updateApplicationDeadTime,
                  ),
                ],
              ),
              // 動画コンテンツ情報
              EventFormGroup(
                header: EventFormGroupHeader('動画コンテンツ情報'),
                children: [
                  EventDatePicker(
                    label: EventFormLabel('動画配信予定日'),
                    initialDate: event.videoDeliveryDateTime,
                    firstDate: nowDateTime,
                    lastDate: nowDateTime.add(const Duration(days: 3650)),
                    onChanged: _updateVideoDeliveryDate,
                  ),
                  EventTimePicker(
                    label: EventFormLabel('動画配信予定時間'),
                    currentTime: event.videoDeliveryDateTime,
                    onChanged: _updateVideoDeliveryTime,
                  ),
                  EventTextField(
                    label: EventFormLabel('動画配信タイプ'),
                    onChanged: _updateVideoDeliveryType,
                  ),
                  EventTextField(
                    label: EventFormLabel('動画保存場所'),
                    onChanged: _updateVideoHolder,
                  ),
                  EventTextField(
                    label: EventFormLabel('動画URL'),
                    onChanged: _updateVideoUrl,
                  ),
                ],
              ),
              EventTextField(
                label: EventFormLabel('注意事項'),
                onChanged: _updateEventNotes,
              ),
              EventTextField(
                label: EventFormLabel('問合せ先メールアドレス'),
                onChanged: _updateInquiryEmail,
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _validate() {
    return true;
  }

  _uploadEvent() async {
    if (currentEventImage != null) {
      FirebaseStorage storage = FirebaseStorage.instance;
      try {
        final filePath = "event_image/sample.png";
        final task = await storage.ref(filePath).putFile(currentEventImage!);
        logger.debug('uploading image to firebase storage is completed',
            task.ref.fullPath);
        event = event.copyWith(imageUrl: task.ref.fullPath);
      } catch (e) {
        logger.error('cannot upload image to firebase storage', args: e);
      }
    }
    logger.debug("upload event:", event);
  }

  _updateEventTitle(String? title) {
    event = event.copyWith(title: title);
  }

  _updateCurrentEventImage(File? file) async {
    currentEventImage = file;
  }

  _updateEventStartDate(DateTime? datetime) {
    if (datetime != null) {
      setState(() {
        event = event.copyWith(
          eventStartDateTime: datetime,
          eventStartDate: DateFormat(Format.DATETIME_YYYYMMDD).format(datetime),
        );
      });
    }
  }

  _updateEventStartTime(DateTime? datetime) {
    if (datetime != null) {
      setState(() {
        event = event.copyWith(
          eventStartDateTime: datetime,
          eventStartTime: "",
        );
      });
    }
  }

  _updateEventEndDate(DateTime? datetime) {
    if (datetime != null) {
      setState(() {
        event = event.copyWith(
          eventEndDateTime: datetime,
          eventEndDate: DateFormat(Format.DATETIME_YYYYMMDD).format(datetime),
        );
      });
    }
  }

  _updateEventEndTime(DateTime? datetime) {
    if (datetime != null) {
      setState(() {
        event = event.copyWith(
          eventEndDateTime: datetime,
          eventEndTime: "",
        );
      });
    }
  }

  _updateEventLocation(String text) {
    setState(() {
      event = event.copyWith(location: text);
    });
  }

  _updateEventDescription(String text) {
    setState(() {
      event = event.copyWith(description: text);
    });
  }

  _updateEventCapacity(String text) {
    setState(() {
      event = event.copyWith(capacity: int.tryParse(text));
    });
  }

  _updateApplicationStartDate(DateTime? datetime) {
    if (datetime != null) {
      setState(() {
        event = event.copyWith(
          applicationStartDateTime: datetime,
          applicationStartDate:
              DateFormat(Format.DATETIME_YYYYMMDD).format(datetime),
        );
      });
    }
  }

  _updateApplicationStartTime(DateTime? datetime) {
    if (datetime != null) {
      setState(() {
        event = event.copyWith(
          applicationStartDateTime: datetime,
          applicationStartTime: "",
        );
      });
    }
  }

  _updateApplicationDeadDate(DateTime? datetime) {
    if (datetime != null) {
      setState(() {
        event = event.copyWith(
          applicationDeadDateTime: datetime,
          applicationDeadDate:
              DateFormat(Format.DATETIME_YYYYMMDD).format(datetime),
        );
      });
    }
  }

  _updateApplicationDeadTime(DateTime? datetime) {
    if (datetime != null) {
      setState(() {
        event = event.copyWith(
          applicationDeadDateTime: datetime,
          applicationDeadTime: "",
        );
      });
    }
  }

  _updateVideoDeliveryDate(DateTime? datetime) {
    if (datetime != null) {
      setState(() {
        event = event.copyWith(
          videoDeliveryDateTime: datetime,
          videoDeliveryDate:
              DateFormat(Format.DATETIME_YYYYMMDD).format(datetime),
        );
      });
    }
  }

  _updateVideoDeliveryTime(DateTime? datetime) {
    if (datetime != null) {
      setState(() {
        event = event.copyWith(
          videoDeliveryDateTime: datetime,
          videoDeliveryTime: "",
        );
      });
    }
  }

  _updateVideoDeliveryType(String text) {
    setState(() {
      event = event.copyWith(videoDeliveryType: 0);
    });
  }

  _updateVideoHolder(String text) {
    setState(() {
      event = event.copyWith(videoHolder: 0);
    });
  }

  _updateVideoUrl(String text) {
    setState(() {
      event = event.copyWith(videoUrl: text);
    });
  }

  _updateEventNotes(String text) {
    setState(() {
      event = event.copyWith(notes: text);
    });
  }

  _updateInquiryEmail(String text) {
    setState(() {
      event = event.copyWith(inquiryEmailAddress: text);
    });
  }
}
