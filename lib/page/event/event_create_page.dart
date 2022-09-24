import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:happyo/common/format.dart';
import 'package:happyo/common/logger.dart';
import 'package:happyo/common/routes.dart';
import 'package:happyo/model/event/happyo_event.dart';
import 'package:happyo/page/event/form/event_date_field.dart';
import 'package:happyo/page/event/form/event_dropdown_field.dart';
import 'package:happyo/page/event/form/event_form_group.dart';
import 'package:happyo/page/event/form/event_form_group_header.dart';
import 'package:happyo/page/event/form/event_form_label.dart';
import 'package:happyo/page/event/form/event_image_form.dart';
import 'package:happyo/page/event/form/event_number_field.dart';
import 'package:happyo/page/event/form/event_text_field.dart';
import 'package:happyo/page/event/form/event_time_field.dart';
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
    final _formKey = GlobalKey<FormState>();
    const topPadding = EdgeInsets.only(top: 12);

    return Scaffold(
      appBar: AppBar(
        title: const Text('イベント作成'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 9),
            child: TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _uploadEvent();
                  Routes.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "イベントを作成しました。",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                      backgroundColor: Theme.of(context).colorScheme.background,
                    ),
                  );
                } else {
                  logger.debug(
                      'form values are invalid.', _formKey.currentState!);
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
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // イベント基本情報
                EventFormGroup(
                  header: EventFormGroupHeader('イベント基本情報'),
                  children: [
                    Padding(
                      padding: topPadding,
                      child: EventTextField(
                        label: EventFormLabel('イベントタイトル'),
                        required: true,
                        maxLength: 30,
                        onChanged: _updateEventTitle,
                        validator: _validateEventTitle,
                      ),
                    ),
                    Padding(
                      padding: topPadding,
                      child: EventImageForm(
                        label: EventFormLabel('イベント画像'),
                        onChanged: _updateCurrentEventImage,
                      ),
                    ),
                  ],
                ),
                // イベント情報
                EventFormGroup(
                  header: EventFormGroupHeader('イベント情報'),
                  children: [
                    Padding(
                      padding: topPadding,
                      child: EventDateField(
                        label: EventFormLabel('イベント開始日'),
                        required: true,
                        initialDate: event.eventStartDateTime,
                        firstDate: nowDateTime,
                        lastDate: nowDateTime.add(const Duration(days: 3650)),
                        onChanged: _updateEventStartDate,
                        validator: _validateEventStartDate,
                      ),
                    ),
                    Padding(
                      padding: topPadding,
                      child: EventTimeField(
                        label: EventFormLabel('イベント開始時間'),
                        required: true,
                        initialDateTime: event.eventStartDateTime,
                        onChanged: _updateEventStartTime,
                        validator: _validateEventStartTime,
                      ),
                    ),
                    Padding(
                      padding: topPadding,
                      child: EventDateField(
                        label: EventFormLabel('イベント終了日'),
                        initialDate: event.eventEndDateTime,
                        firstDate: nowDateTime,
                        lastDate: nowDateTime.add(const Duration(days: 3650)),
                        onChanged: _updateEventEndDate,
                      ),
                    ),
                    Padding(
                      padding: topPadding,
                      child: EventTimeField(
                        label: EventFormLabel('イベント終了時間'),
                        initialDateTime: event.eventEndDateTime,
                        onChanged: _updateEventEndTime,
                      ),
                    ),
                    Padding(
                      padding: topPadding,
                      child: EventTextField(
                        label: EventFormLabel('イベント開催場所'),
                        required: true,
                        onChanged: _updateEventLocation,
                        validator: _validateEventLocation,
                      ),
                    ),
                    Padding(
                      padding: topPadding,
                      child: EventTextField(
                        label: EventFormLabel('イベントの説明'),
                        required: true,
                        maxLines: 5,
                        maxLength: 2000,
                        onChanged: _updateEventDescription,
                        validator: _validateEventDescription,
                      ),
                    ),
                  ],
                ),
                // 募集情報
                EventFormGroup(
                  header: EventFormGroupHeader('募集情報'),
                  children: [
                    Padding(
                      padding: topPadding,
                      child: EventNumberField(
                        label: EventFormLabel('定員'),
                        required: true,
                        onChanged: _updateEventCapacity,
                        validator: _validateEventCapacity,
                      ),
                    ),
                    Padding(
                      padding: topPadding,
                      child: EventDateField(
                        label: EventFormLabel('募集開始日'),
                        initialDate: event.applicationStartDateTime,
                        firstDate: nowDateTime,
                        lastDate: nowDateTime.add(const Duration(days: 3650)),
                        onChanged: _updateApplicationStartDate,
                      ),
                    ),
                    Padding(
                      padding: topPadding,
                      child: EventTimeField(
                        label: EventFormLabel('募集開始時間'),
                        initialDateTime: event.applicationStartDateTime,
                        onChanged: _updateApplicationStartTime,
                      ),
                    ),
                    Padding(
                      padding: topPadding,
                      child: EventDateField(
                        label: EventFormLabel('募集締切日'),
                        initialDate: event.applicationDeadDateTime,
                        firstDate: nowDateTime,
                        lastDate: nowDateTime.add(const Duration(days: 3650)),
                        onChanged: _updateApplicationDeadDate,
                      ),
                    ),
                    Padding(
                      padding: topPadding,
                      child: EventTimeField(
                        label: EventFormLabel('募集締切時間'),
                        initialDateTime: event.applicationDeadDateTime,
                        onChanged: _updateApplicationDeadTime,
                      ),
                    ),
                  ],
                ),
                // 動画コンテンツ情報
                EventFormGroup(
                  header: EventFormGroupHeader('動画コンテンツ情報'),
                  children: [
                    Padding(
                      padding: topPadding,
                      child: EventDateField(
                        label: EventFormLabel('動画配信予定日'),
                        initialDate: event.videoDeliveryDateTime,
                        firstDate: nowDateTime,
                        lastDate: nowDateTime.add(const Duration(days: 3650)),
                        onChanged: _updateVideoDeliveryDate,
                      ),
                    ),
                    Padding(
                      padding: topPadding,
                      child: EventTimeField(
                        label: EventFormLabel('動画配信予定時間'),
                        initialDateTime: event.videoDeliveryDateTime,
                        onChanged: _updateVideoDeliveryTime,
                      ),
                    ),
                    Padding(
                      padding: topPadding,
                      child: EventDropdownField(
                        label: EventFormLabel('動画配信プラットフォーム'),
                        items: const [
                          DropdownMenuItem(value: 0, child: Text("HAPPYO")),
                          DropdownMenuItem(value: 1, child: Text("YouTube")),
                        ],
                        required: true,
                        onChanged: _updateVideoPlatform,
                        validator: _validateVideoPlatform,
                      ),
                    ),
                    Padding(
                      padding: topPadding,
                      child: EventDropdownField(
                        label: EventFormLabel('動画配信タイプ'),
                        items: const [
                          DropdownMenuItem(value: 0, child: Text("LIVE配信")),
                          DropdownMenuItem(value: 1, child: Text("録画配信")),
                        ],
                        required: true,
                        onChanged: _updateVideoDeliveryType,
                        validator: _validateVideoDeliveryType,
                      ),
                    ),
                    Padding(
                      padding: topPadding,
                      child: EventTextField(
                        label: EventFormLabel('動画URL'),
                        onChanged: _updateVideoUrl,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: topPadding,
                  child: EventTextField(
                    label: EventFormLabel('注意事項'),
                    maxLength: 300,
                    maxLines: 5,
                    onChanged: _updateEventNotes,
                  ),
                ),
                Padding(
                  padding: topPadding,
                  child: EventTextField(
                    label: EventFormLabel('問合せ先メールアドレス'),
                    onChanged: _updateInquiryEmail,
                    validator: _validateInquiryEmail,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _validateEventTitle(String? value) {
    if (value!.isEmpty) {
      return "イベントタイトルは必須です";
    }
    return null;
  }

  String? _validateEventStartDate(DateTime? value) {
    if (value == null) {
      return "イベント開始日は必須です";
    }
    return null;
  }

  String? _validateEventStartTime(DateTime? value) {
    if (value == null) {
      return "イベント開始時間は必須です";
    }
    return null;
  }

  String? _validateEventLocation(String? value) {
    if (value!.isEmpty) {
      return "イベント開催場所は必須です";
    }
    return null;
  }

  String? _validateEventDescription(String? value) {
    if (value!.isEmpty) {
      return "イベントの説明は必須です";
    }
    return null;
  }

  String? _validateEventCapacity(String? value) {
    const maxValue = 999;
    if (value!.isEmpty) {
      return "定員は必須です";
    }
    if (int.parse(value) > maxValue) {
      return "定員は$maxValue以下で入力してください";
    }
    return null;
  }

  String? _validateInquiryEmail(String? value) {
    if (value!.isEmpty) return null;
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return "メールアドレスの形式ではありません";
    }
    return null;
  }

  String? _validateVideoPlatform(int? value) {
    if (value == null) return "動画配信プラットフォームを選択してください";
    return null;
  }

  String? _validateVideoDeliveryType(int? value) {
    if (value == null) return "動画配信タイプを選択してください";
    return null;
  }

  _uploadEvent() async {
    final db = FirebaseFirestore.instance;
    final doc = db.collection("test").doc();
    await doc.set(event.toJson());
    event = event.copyWith(id: doc.id);

    if (currentEventImage != null) {
      FirebaseStorage storage = FirebaseStorage.instance;
      try {
        final filePath = "event_image/${event.id}";
        logger.debug('uploading image to firebase storage is completed', {
          "from": currentEventImage!.path,
          "to": filePath,
        });
        final task = await storage.ref(filePath).putFile(currentEventImage!);
        final imageUrl = await task.ref.getDownloadURL();
        event = event.copyWith(imageUrl: imageUrl);
      } catch (e, st) {
        logger.error('cannot upload image to firebase storage', args: [e, st]);
      }
    }

    doc.set(event.toJson());

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
      event = event.copyWith(
        eventStartDateTime: datetime,
        eventStartDate: DateFormat(Format.DATETIME_YYYYMMDD).format(datetime),
        eventStartTime: DateFormat(Format.DATETIME_HHMM).format(datetime),
      );
    }
  }

  _updateEventStartTime(DateTime? datetime) {
    if (datetime != null) {
      event = event.copyWith(
        eventStartDateTime: datetime,
        eventStartDate: DateFormat(Format.DATETIME_YYYYMMDD).format(datetime),
        eventStartTime: DateFormat(Format.DATETIME_HHMM).format(datetime),
      );
    }
  }

  _updateEventEndDate(DateTime? datetime) {
    if (datetime != null) {
      event = event.copyWith(
        eventEndDateTime: datetime,
        eventEndDate: DateFormat(Format.DATETIME_YYYYMMDD).format(datetime),
        eventEndTime: DateFormat(Format.DATETIME_HHMM).format(datetime),
      );
    }
  }

  _updateEventEndTime(DateTime? datetime) {
    if (datetime != null) {
      event = event.copyWith(
        eventEndDateTime: datetime,
        eventEndDate: DateFormat(Format.DATETIME_YYYYMMDD).format(datetime),
        eventEndTime: DateFormat(Format.DATETIME_HHMM).format(datetime),
      );
    }
  }

  _updateEventLocation(String? text) {
    event = event.copyWith(location: text);
  }

  _updateEventDescription(String? text) {
    event = event.copyWith(description: text);
  }

  _updateEventCapacity(String? text) {
    event = event.copyWith(capacity: int.tryParse(text!));
  }

  _updateApplicationStartDate(DateTime? datetime) {
    if (datetime != null) {
      event = event.copyWith(
        applicationStartDateTime: datetime,
        applicationStartDate:
            DateFormat(Format.DATETIME_YYYYMMDD).format(datetime),
        applicationStartTime: DateFormat(Format.DATETIME_HHMM).format(datetime),
      );
    }
  }

  _updateApplicationStartTime(DateTime? datetime) {
    if (datetime != null) {
      event = event.copyWith(
        applicationStartDateTime: datetime,
        applicationStartDate:
            DateFormat(Format.DATETIME_YYYYMMDD).format(datetime),
        applicationStartTime: DateFormat(Format.DATETIME_HHMM).format(datetime),
      );
    }
  }

  _updateApplicationDeadDate(DateTime? datetime) {
    if (datetime != null) {
      event = event.copyWith(
        applicationDeadDateTime: datetime,
        applicationDeadDate:
            DateFormat(Format.DATETIME_YYYYMMDD).format(datetime),
        applicationDeadTime: DateFormat(Format.DATETIME_HHMM).format(datetime),
      );
    }
  }

  _updateApplicationDeadTime(DateTime? datetime) {
    if (datetime != null) {
      event = event.copyWith(
        applicationDeadDateTime: datetime,
        applicationDeadDate:
            DateFormat(Format.DATETIME_YYYYMMDD).format(datetime),
        applicationDeadTime: DateFormat(Format.DATETIME_HHMM).format(datetime),
      );
    }
  }

  _updateVideoDeliveryDate(DateTime? datetime) {
    if (datetime != null) {
      event = event.copyWith(
        videoDeliveryDateTime: datetime,
        videoDeliveryDate:
            DateFormat(Format.DATETIME_YYYYMMDD).format(datetime),
        videoDeliveryTime: DateFormat(Format.DATETIME_HHMM).format(datetime),
      );
    }
  }

  _updateVideoDeliveryTime(DateTime? datetime) {
    if (datetime != null) {
      event = event.copyWith(
        videoDeliveryDateTime: datetime,
        videoDeliveryDate:
            DateFormat(Format.DATETIME_YYYYMMDD).format(datetime),
        videoDeliveryTime: DateFormat(Format.DATETIME_HHMM).format(datetime),
      );
    }
  }

  _updateVideoPlatform(int? text) {
    // TODO: change type to VideoHolder
    // event = event.copyWith(videoHolder: 0);
  }

  _updateVideoDeliveryType(int? value) {
    event = event.copyWith(videoDeliveryType: value);
  }

  _updateVideoUrl(String? text) {
    event = event.copyWith(videoUrl: text);
  }

  _updateEventNotes(String? text) {
    event = event.copyWith(notes: text);
  }

  _updateInquiryEmail(String? text) {
    event = event.copyWith(inquiryEmailAddress: text);
  }
}
