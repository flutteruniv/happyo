import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:happyo/common/logger.dart';
import 'package:happyo/model/event/happyo_event.dart';
import 'package:happyo/model/pricing/pricing.dart';
import 'package:happyo/model/user/user.dart';

// 初期値
const String? DEFAULT_ID = null;
const String? DEFAULT_IMAGE_URL = null;
const DateTime? DEFAULT_EVENT_START_DATETIME = null;
const String? DEFAULT_EVENT_START_DATE = null;
const String? DEFAULT_EVENT_START_TIME = null;
const DateTime? DEFAULT_EVENT_END_DATETIME = null;
const String? DEFAULT_EVENT_END_DATE = null;
const String? DEFAULT_EVENT_END_TIME = null;
const String? DEFAULT_LOCATION = null;
const String? DEFAULT_DESCRIPTION = null;
const List? DEFAULT_SPEAKER_LIST = null;
const String? DEFAULT_TARGET_AUDIENCE = null;
const DateTime? DEFAULT_APPLICATION_START_DATETIME = null;
const String? DEFAULT_APPLICATION_START_DATE = null;
const String? DEFAULT_APPLICATION_START_TIME = null;
const DateTime? DEFAULT_APPLICATION_DEAD_DATETIME = null;
const String? DEFAULT_APPLICATION_DEAD_DATE = null;
const String? DEFAULT_APPLICATION_DEAD_TIME = null;
const int? DEFAULT_CAPACITY = null;
const List? DEFAULT_PRICING_LIST = null;
const String? DEFAULT_NOTES = null;
const DateTime? DEFAULT_VIDEO_DELIVERY_DATETIME = null;
const String? DEFAULT_VIDEO_DELIVERY_DATE = null;
const String? DEFAULT_VIDEO_DELIVERY_TIME = null;
const int? DEFAULT_VIDEO_DELIVERY_TYPE = null;
const int? DEFAULT_VIDEO_HOLDER = null;
const String? DEFAULT_VIDEO_URL = null;
const int? DEFAULT_HOST_ID = null;
const String? DEFAULT_HOST_NAME = null;
const int? DEFAULT_STATUS = null;
const String? DEFAULT_INQUIRY_EMAIL_ADDRESS = null;
const List<String>? DEFAULT_TAG_LIST = null;

// 更新前値
const String? BEFORE_TITLE = '更新前 タイトル';

// 更新値
const String? AFTER_ID = '更新後 ID';
const String? AFTER_TITLE = '更新後 タイトル';
const String? AFTER_IMAGE_URL = '更新後 URL';
const int? AFTER_EVENT_START_DATETIME_YEAR = 2023;
const int? AFTER_EVENT_START_DATETIME_MONTH = 1;
const int? AFTER_EVENT_START_DATETIME_DAY = 1;
const int? AFTER_EVENT_START_DATETIME_HOUR = 0;
const int? AFTER_EVENT_START_DATETIME_MINUTE = 0;
const int? AFTER_EVENT_END_DATETIME_YEAR = 2023;
const int? AFTER_EVENT_END_DATETIME_MONTH = 1;
const int? AFTER_EVENT_END_DATETIME_DAY = 1;
const int? AFTER_EVENT_END_DATETIME_HOUR = 0;
const int? AFTER_EVENT_END_DATETIME_MINUTE = 0;
const String? AFTER_LOCATION = '更新後 開催場所';
const String? AFTER_DESCRIPTION = '更新後 説明';
const List<User>? AFTER_SPEAKER_LIST = [];
const String? AFTER_TARGET_AUDIENCE = '更新後 おすすめ対象視聴者';
// const DateTime? AFTER_APPLICATION_START_DATETIME = null;
const int? AFTER_APPLICATION_START_DATETIME_YEAR = 2022;
const int? AFTER_APPLICATION_START_DATETIME_MONTH = 12;
const int? AFTER_APPLICATION_START_DATETIME_DAY = 31;
const int? AFTER_APPLICATION_START_DATETIME_HOUR = 23;
const int? AFTER_APPLICATION_START_DATETIME_MINUTE = 59;
// const DateTime? AFTER_APPLICATION_DEAD_DATETIME = null;
const int? AFTER_APPLICATION_DEAD_DATETIME_YEAR = 2023;
const int? AFTER_APPLICATION_DEAD_DATETIME_MONTH = 1;
const int? AFTER_APPLICATION_DEAD_DATETIME_DAY = 1;
const int? AFTER_APPLICATION_DEAD_DATETIME_HOUR = 0;
const int? AFTER_APPLICATION_DEAD_DATETIME_MINUTE = 0;
const int? AFTER_CAPACITY = 20;
const List<Pricing>? AFTER_PRICING_LIST = [];
const String? AFTER_NOTES = '更新後 注意事項';
// const DateTime? AFTER_VIDEO_DELIVERY_DATETIME = null;
const int? AFTER_VIDEO_DELIVERY_DATETIME_YEAR = 2022;
const int? AFTER_VIDEO_DELIVERY_DATETIME_MONTH = 12;
const int? AFTER_VIDEO_DELIVERY_DATETIME_DAY = 31;
const int? AFTER_VIDEO_DELIVERY_DATETIME_HOUR = 0;
const int? AFTER_VIDEO_DELIVERY_DATETIME_MINUTE = 0;
const int? AFTER_VIDEO_DELIVERY_TYPE = 1;
const int? AFTER_VIDEO_HOLDER = 1;
const String? AFTER_VIDEO_URL = '更新後 動画URL';
const int? AFTER_HOST_ID = 1;
const String? AFTER_HOST_NAME = '更新後 ホスト名';
const int? AFTER_STATUS = 1;
const String? AFTER_INQUIRY_EMAIL_ADDRESS = '更新後 問合せ用メールアドレス';
const List<String>? AFTER_TAG_LIST = [];

final afterEventStartDateTime = DateTime(
  AFTER_EVENT_START_DATETIME_YEAR!,
  AFTER_EVENT_START_DATETIME_MONTH!,
  AFTER_EVENT_START_DATETIME_DAY!,
  AFTER_EVENT_START_DATETIME_HOUR!,
  AFTER_EVENT_START_DATETIME_MINUTE!,
);

final afterEventStartDate =
    HappyoEvent.dateFormat.format(afterEventStartDateTime);
final afterEventStartTime =
    HappyoEvent.timeFormat.format(afterEventStartDateTime);

final afterEventEndDateTime = DateTime(
  AFTER_EVENT_END_DATETIME_YEAR!,
  AFTER_EVENT_END_DATETIME_MONTH!,
  AFTER_EVENT_END_DATETIME_DAY!,
  AFTER_EVENT_END_DATETIME_HOUR!,
  AFTER_EVENT_END_DATETIME_MINUTE!,
);
final afterEventEndDate = HappyoEvent.dateFormat.format(afterEventEndDateTime);
final afterEventEndTime = HappyoEvent.timeFormat.format(afterEventEndDateTime);

final afterApplicationStartDateTime = DateTime(
  AFTER_APPLICATION_START_DATETIME_YEAR!,
  AFTER_APPLICATION_START_DATETIME_MONTH!,
  AFTER_APPLICATION_START_DATETIME_DAY!,
  AFTER_APPLICATION_START_DATETIME_HOUR!,
  AFTER_APPLICATION_START_DATETIME_MINUTE!,
);
final afterApplicationStartDate =
    HappyoEvent.dateFormat.format(afterApplicationStartDateTime);
final afterApplicationStartTime =
    HappyoEvent.timeFormat.format(afterApplicationStartDateTime);

final afterApplicationDeadDateTime = DateTime(
  AFTER_APPLICATION_DEAD_DATETIME_YEAR!,
  AFTER_APPLICATION_DEAD_DATETIME_MONTH!,
  AFTER_APPLICATION_DEAD_DATETIME_DAY!,
  AFTER_APPLICATION_DEAD_DATETIME_HOUR!,
  AFTER_APPLICATION_DEAD_DATETIME_MINUTE!,
);
final afterApplicationDeadDate =
    HappyoEvent.dateFormat.format(afterApplicationDeadDateTime);
final afterApplicationDeadTime =
    HappyoEvent.timeFormat.format(afterApplicationDeadDateTime);

final afterVideDeliveryDateTime = DateTime(
  AFTER_VIDEO_DELIVERY_DATETIME_YEAR!,
  AFTER_VIDEO_DELIVERY_DATETIME_MONTH!,
  AFTER_VIDEO_DELIVERY_DATETIME_DAY!,
  AFTER_VIDEO_DELIVERY_DATETIME_HOUR!,
  AFTER_VIDEO_DELIVERY_DATETIME_MINUTE!,
);
final afterVideDeliveryDate =
    HappyoEvent.dateFormat.format(afterVideDeliveryDateTime);
final afterVideDeliveryTime =
    HappyoEvent.timeFormat.format(afterVideDeliveryDateTime);

const defaultInstanceJsonText = '{'
    'id: $DEFAULT_ID'
    ', title: $BEFORE_TITLE'
    ', imageUrl: $DEFAULT_IMAGE_URL'
    ', eventStartDateTime: $DEFAULT_EVENT_START_DATETIME'
    ', eventStartDate: $DEFAULT_EVENT_START_DATE'
    ', eventStartTime: $DEFAULT_EVENT_START_TIME'
    ', eventEndDateTime: $DEFAULT_EVENT_END_DATETIME'
    ', eventEndDate: $DEFAULT_EVENT_END_DATE'
    ', eventEndTime: $DEFAULT_EVENT_START_TIME'
    ', location: $DEFAULT_LOCATION'
    ', description: $DEFAULT_DESCRIPTION'
    ', speakerList: $DEFAULT_SPEAKER_LIST'
    ', targetAudience: $DEFAULT_TARGET_AUDIENCE'
    ', applicationStartDateTime: $DEFAULT_APPLICATION_START_DATETIME'
    ', applicationStartDate: $DEFAULT_APPLICATION_START_DATE'
    ', applicationStartTime: $DEFAULT_APPLICATION_START_TIME'
    ', applicationDeadDateTime: $DEFAULT_APPLICATION_DEAD_DATETIME'
    ', applicationDeadDate: $DEFAULT_APPLICATION_DEAD_DATE'
    ', applicationDeadTime: $DEFAULT_APPLICATION_DEAD_TIME'
    ', capacity: $DEFAULT_CAPACITY'
    ', pricingList: $DEFAULT_PRICING_LIST'
    ', notes: $DEFAULT_NOTES'
    ', videoDeliveryDateTime: $DEFAULT_VIDEO_DELIVERY_DATETIME'
    ', videoDeliveryDate: $DEFAULT_VIDEO_DELIVERY_DATE'
    ', videoDeliveryTime: $DEFAULT_VIDEO_DELIVERY_TIME'
    ', videoDeliveryType: $DEFAULT_VIDEO_DELIVERY_TYPE'
    ', videoHolder: $DEFAULT_VIDEO_HOLDER'
    ', videoUrl: $DEFAULT_VIDEO_URL'
    ', hostId: $DEFAULT_HOST_ID'
    ', hostName: $DEFAULT_HOST_NAME'
    ', status: $DEFAULT_STATUS'
    ', inquiryEmailAddress: $DEFAULT_INQUIRY_EMAIL_ADDRESS'
    ', tagList: $DEFAULT_TAG_LIST'
    '}';

final afterInstanceJsonText = '{'
    'id: $AFTER_ID'
    ', title: $AFTER_TITLE'
    ', imageUrl: $AFTER_IMAGE_URL'
    ', eventStartDateTime: ${afterEventStartDateTime.toIso8601String()}'
    ', eventStartDate: $afterEventStartDate'
    ', eventStartTime: $afterEventStartTime'
    ', eventEndDateTime: ${afterEventEndDateTime.toIso8601String()}'
    ', eventEndDate: $afterEventEndDate'
    ', eventEndTime: $afterEventEndTime'
    ', location: $AFTER_LOCATION'
    ', description: $AFTER_DESCRIPTION'
    ', speakerList: $AFTER_SPEAKER_LIST'
    ', targetAudience: $AFTER_TARGET_AUDIENCE'
    ', applicationStartDateTime: ${afterApplicationStartDateTime.toIso8601String()}'
    ', applicationStartDate: $afterApplicationStartDate'
    ', applicationStartTime: $afterApplicationStartTime'
    ', applicationDeadDateTime: ${afterApplicationDeadDateTime.toIso8601String()}'
    ', applicationDeadDate: $afterApplicationDeadDate'
    ', applicationDeadTime: $afterApplicationDeadTime'
    ', capacity: $AFTER_CAPACITY'
    ', pricingList: $AFTER_PRICING_LIST'
    ', notes: $AFTER_NOTES'
    ', videoDeliveryDateTime: ${afterVideDeliveryDateTime.toIso8601String()}'
    ', videoDeliveryDate: $afterVideDeliveryDate'
    ', videoDeliveryTime: $afterVideDeliveryTime'
    ', videoDeliveryType: $AFTER_VIDEO_DELIVERY_TYPE'
    ', videoHolder: $AFTER_VIDEO_HOLDER'
    ', videoUrl: $AFTER_VIDEO_URL'
    ', hostId: $AFTER_HOST_ID'
    ', hostName: $AFTER_HOST_NAME'
    ', status: $AFTER_STATUS'
    ', inquiryEmailAddress: $AFTER_INQUIRY_EMAIL_ADDRESS'
    ', tagList: $AFTER_TAG_LIST'
    '}';

const defaultJsonText = '{'
    '"id": $DEFAULT_ID'
    ', "title": "$BEFORE_TITLE"'
    ', "imageUrl": $DEFAULT_IMAGE_URL'
    ', "eventStartDateTime": $DEFAULT_EVENT_START_DATETIME'
    ', "eventStartDate": $DEFAULT_EVENT_START_DATE'
    ', "eventStartTime": $DEFAULT_EVENT_START_TIME'
    ', "eventEndDateTime": $DEFAULT_EVENT_END_DATETIME'
    ', "eventEndDate": $DEFAULT_EVENT_END_DATE'
    ', "eventEndTime": $DEFAULT_EVENT_END_DATETIME'
    ', "location": $DEFAULT_LOCATION'
    ', "description": $DEFAULT_DESCRIPTION'
    ', "speakerList": $DEFAULT_SPEAKER_LIST'
    ', "targetAudience": $DEFAULT_TARGET_AUDIENCE'
    ', "applicationStartDateTime": $DEFAULT_APPLICATION_START_DATETIME'
    ', "applicationStartDate": $DEFAULT_APPLICATION_START_DATE'
    ', "applicationStartTime": $DEFAULT_APPLICATION_START_TIME'
    ', "applicationDeadDateTime": $DEFAULT_APPLICATION_DEAD_DATETIME'
    ', "applicationDeadDate": $DEFAULT_APPLICATION_DEAD_DATE'
    ', "applicationDeadTime": $DEFAULT_APPLICATION_DEAD_TIME'
    ', "capacity": $DEFAULT_CAPACITY'
    ', "pricingList": $DEFAULT_PRICING_LIST'
    ', "notes": $DEFAULT_NOTES'
    ', "videoDeliveryDateTime": $DEFAULT_VIDEO_DELIVERY_DATETIME'
    ', "videoDeliveryDate": $DEFAULT_VIDEO_DELIVERY_DATE'
    ', "videoDeliveryTime": $DEFAULT_VIDEO_DELIVERY_TIME'
    ', "videoDeliveryType": $DEFAULT_VIDEO_DELIVERY_TYPE'
    ', "videoHolder": $DEFAULT_VIDEO_HOLDER'
    ', "videoUrl": $DEFAULT_VIDEO_URL'
    ', "hostId": $DEFAULT_HOST_ID'
    ', "hostName": $DEFAULT_HOST_NAME'
    ', "status": $DEFAULT_STATUS'
    ', "inquiryEmailAddress": $DEFAULT_INQUIRY_EMAIL_ADDRESS'
    ', "tagList": $DEFAULT_TAG_LIST'
    '}';

final afterJsonText = '{'
    '"id": "$AFTER_ID"'
    ', "title": "$AFTER_TITLE"'
    ', "imageUrl": "$AFTER_IMAGE_URL"'
    ', "eventStartDateTime": "${afterEventStartDateTime.toIso8601String()}"'
    ', "eventStartDate": "$afterEventStartDate"'
    ', "eventStartTime": "$afterEventStartTime"'
    ', "eventEndDateTime": "${afterEventEndDateTime.toIso8601String()}"'
    ', "eventEndDate": "$afterEventEndDate"'
    ', "eventEndTime": "$afterEventEndTime"'
    ', "location": "$AFTER_LOCATION"'
    ', "description": "$AFTER_DESCRIPTION"'
    ', "speakerList": $AFTER_SPEAKER_LIST'
    ', "targetAudience": "$AFTER_TARGET_AUDIENCE"'
    ', "applicationStartDateTime": "${afterApplicationStartDateTime.toIso8601String()}"'
    ', "applicationStartDate": "$afterApplicationStartDate"'
    ', "applicationStartTime": "$afterApplicationStartTime"'
    ', "applicationDeadDateTime": "${afterApplicationDeadDateTime.toIso8601String()}"'
    ', "applicationDeadDate": "$afterApplicationDeadDate"'
    ', "applicationDeadTime": "$afterApplicationDeadTime"'
    ', "capacity": $AFTER_CAPACITY'
    ', "pricingList": $AFTER_PRICING_LIST'
    ', "notes": "$AFTER_NOTES"'
    ', "videoDeliveryDateTime": "$afterVideDeliveryDateTime"'
    ', "videoDeliveryDate": "$afterVideDeliveryDate"'
    ', "videoDeliveryTime": "$afterVideDeliveryTime"'
    ', "videoDeliveryType": $AFTER_VIDEO_DELIVERY_TYPE'
    ', "videoHolder": $AFTER_VIDEO_HOLDER'
    ', "videoUrl": "$AFTER_VIDEO_URL"'
    ', "hostId": $AFTER_HOST_ID'
    ', "hostName": "$AFTER_HOST_NAME"'
    ', "status": $AFTER_STATUS'
    ', "inquiryEmailAddress": "$AFTER_INQUIRY_EMAIL_ADDRESS"'
    ', "tagList": $AFTER_TAG_LIST'
    '}';

void main() {
  group('HappyoEvent_正常系:インスタンス作成', () {
    late HappyoEvent e;
    setUpAll(() {
      e = getDefaultEventInstance();
      logger.debug('HappyoEvent', e);
    });
    test('case1_デフォ値の確認', () {
      expect(DEFAULT_ID, e.id);
      expect(BEFORE_TITLE, e.title);
      expect(DEFAULT_IMAGE_URL, e.imageUrl);
      expect(DEFAULT_EVENT_START_DATETIME, e.eventStartDateTime);
      expect(DEFAULT_EVENT_START_DATE, e.eventStartDate);
      expect(DEFAULT_EVENT_START_TIME, e.eventStartTime);
      expect(DEFAULT_EVENT_END_DATETIME, e.eventEndDateTime);
      expect(DEFAULT_EVENT_END_DATE, e.eventEndDate);
      expect(DEFAULT_EVENT_END_TIME, e.eventEndTime);
      expect(DEFAULT_LOCATION, e.location);
      expect(DEFAULT_DESCRIPTION, e.description);
      expect(DEFAULT_SPEAKER_LIST, e.speakerList);
      expect(DEFAULT_TARGET_AUDIENCE, e.targetAudience);
      expect(DEFAULT_APPLICATION_START_DATETIME, e.applicationStartDateTime);
      expect(DEFAULT_APPLICATION_DEAD_DATETIME, e.applicationDeadDateTime);
      expect(DEFAULT_CAPACITY, e.capacity);
      expect(DEFAULT_PRICING_LIST, e.pricingList);
      expect(DEFAULT_NOTES, e.notes);
      expect(DEFAULT_VIDEO_DELIVERY_DATETIME, e.videoDeliveryDateTime);
      expect(DEFAULT_VIDEO_DELIVERY_TYPE, e.videoDeliveryType);
      expect(DEFAULT_VIDEO_HOLDER, e.videoHolder);
      expect(DEFAULT_VIDEO_URL, e.videoUrl);
      expect(DEFAULT_HOST_ID, e.hostId);
      expect(DEFAULT_HOST_NAME, e.hostName);
      expect(DEFAULT_STATUS, e.status);
      expect(DEFAULT_INQUIRY_EMAIL_ADDRESS, e.inquiryEmailAddress);
      expect(DEFAULT_TAG_LIST, e.tagList);
    });

    test('case2_値の更新確認', () {
      e = updateEvent(e);
      expect(AFTER_ID, e.id);
      expect(AFTER_TITLE, e.title);
      expect(AFTER_IMAGE_URL, e.imageUrl);
      expect(afterEventStartDateTime, e.eventStartDateTime);
      expect(afterEventStartDate, e.eventStartDate);
      expect(afterEventStartTime, e.eventStartTime);
      expect(afterEventEndDateTime, e.eventEndDateTime);
      expect(afterEventEndDate, e.eventEndDate);
      expect(afterEventEndTime, e.eventEndTime);
      expect(AFTER_LOCATION, e.location);
      expect(AFTER_DESCRIPTION, e.description);
      expect(AFTER_SPEAKER_LIST, e.speakerList);
      expect(AFTER_TARGET_AUDIENCE, e.targetAudience);
      expect(afterApplicationStartDateTime, e.applicationStartDateTime);
      expect(afterApplicationStartDate, e.applicationStartDate);
      expect(afterApplicationStartTime, e.applicationStartTime);
      expect(afterApplicationDeadDateTime, e.applicationDeadDateTime);
      expect(afterApplicationDeadDate, e.applicationDeadDate);
      expect(afterApplicationDeadTime, e.applicationDeadTime);
      expect(AFTER_CAPACITY, e.capacity);
      expect(AFTER_PRICING_LIST, e.pricingList);
      expect(AFTER_NOTES, e.notes);
      expect(afterVideDeliveryDateTime, e.videoDeliveryDateTime);
      expect(afterVideDeliveryDate, e.videoDeliveryDate);
      expect(afterVideDeliveryTime, e.videoDeliveryTime);
      expect(AFTER_VIDEO_DELIVERY_TYPE, e.videoDeliveryType);
      expect(AFTER_VIDEO_HOLDER, e.videoHolder);
      expect(AFTER_VIDEO_URL, e.videoUrl);
      expect(AFTER_HOST_ID, e.hostId);
      expect(AFTER_HOST_NAME, e.hostName);
      expect(AFTER_STATUS, e.status);
      expect(AFTER_INQUIRY_EMAIL_ADDRESS, e.inquiryEmailAddress);
      expect(AFTER_TAG_LIST, e.tagList);
    });
  });

  group('HappyoEvent_正常系:オブジェクトからjson形式に変換する', () {
    late HappyoEvent e;
    setUpAll(() {
      e = getDefaultEventInstance();
    });

    test('case1_デフォ値の確認', () {
      var text = e.toJson().toString();
      expect(text, defaultInstanceJsonText);
    });

    test('case2_値の更新確認', () {
      e = updateEvent(e);
      var text = e.toJson().toString();
      expect(text, afterInstanceJsonText);
    });
  });

  group('HappyoEvent_正常系:json形式からオブジェクトに変換する', () {
    late HappyoEvent e;
    setUpAll(() {
      e = getDefaultEventInstance();
    });
    test('case1_デフォ値の確認', () {
      var event = HappyoEvent.fromJson(jsonDecode(defaultJsonText));
      expect(e, event);
    });

    test('case2_値の更新確認', () {
      e = updateEvent(e);
      var event = HappyoEvent.fromJson(jsonDecode(afterJsonText));
      expect(e, event);
    });
  });
}

HappyoEvent getDefaultEventInstance() {
  return HappyoEvent(title: BEFORE_TITLE!);
}

HappyoEvent updateEvent(HappyoEvent e) {
  return e.copyWith(
    id: AFTER_ID,
    title: AFTER_TITLE!,
    imageUrl: AFTER_IMAGE_URL,
    eventStartDateTime: afterEventStartDateTime,
    eventStartDate: afterEventStartDate,
    eventStartTime: afterEventStartTime,
    eventEndDateTime: afterEventEndDateTime,
    eventEndDate: afterEventEndDate,
    eventEndTime: afterEventEndTime,
    location: AFTER_LOCATION,
    description: AFTER_DESCRIPTION,
    speakerList: AFTER_SPEAKER_LIST,
    targetAudience: AFTER_TARGET_AUDIENCE,
    applicationStartDateTime: afterApplicationStartDateTime,
    applicationStartDate: afterApplicationStartDate,
    applicationStartTime: afterApplicationStartTime,
    applicationDeadDateTime: afterApplicationDeadDateTime,
    applicationDeadDate: afterApplicationDeadDate,
    applicationDeadTime: afterApplicationDeadTime,
    capacity: AFTER_CAPACITY,
    pricingList: AFTER_PRICING_LIST,
    notes: AFTER_NOTES,
    videoDeliveryDateTime: afterVideDeliveryDateTime,
    videoDeliveryDate: afterVideDeliveryDate,
    videoDeliveryTime: afterVideDeliveryTime,
    videoDeliveryType: AFTER_VIDEO_DELIVERY_TYPE,
    videoHolder: AFTER_VIDEO_HOLDER,
    videoUrl: AFTER_VIDEO_URL,
    hostId: AFTER_HOST_ID,
    hostName: AFTER_HOST_NAME,
    status: AFTER_STATUS,
    inquiryEmailAddress: AFTER_INQUIRY_EMAIL_ADDRESS,
    tagList: AFTER_TAG_LIST,
  );
}
