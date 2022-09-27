import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:happyo/model/movie/movie_platform.dart';
import 'package:happyo/model/pricing/pricing.dart';
import 'package:happyo/model/user/user.dart';
import 'package:intl/intl.dart';

part 'happyo_event.freezed.dart';
part 'happyo_event.g.dart';

@freezed
class HappyoEvent with _$HappyoEvent {
  static final DateFormat dateFormat = DateFormat.Md();
  static final DateFormat timeFormat = DateFormat.Hm();
  factory HappyoEvent({
    // ID
    String? id,

    // 件名
    String? title,

    // イメージ画像
    String? imageUrl,

    // イベント開始予定日時
    DateTime? eventStartDateTime,

    // イベント開始予定日
    String? eventStartDate,

    // イベント開始予定時刻
    String? eventStartTime,

    // イベント終了予定日時
    DateTime? eventEndDateTime,

    // イベント終了予定日
    String? eventEndDate,

    // イベント終了予定時刻
    String? eventEndTime,

    // イベント開催場所 ※都道府県で検索する場合があるかも
    String? location,

    // イベントの説明(Markdown形式)
    String? description,

    // 登壇者のリスト
    List<User>? speakerList,

    // 視聴ターゲット
    String? targetAudience,

    // 募集開始日時
    DateTime? applicationStartDateTime,

    // 募集開始日
    String? applicationStartDate,

    // 募集開始時刻
    String? applicationStartTime,

    // 募集締切日時
    DateTime? applicationDeadDateTime,

    // 募集締切日
    String? applicationDeadDate,

    // 募集締切時刻
    String? applicationDeadTime,

    // 定員
    int? capacity,

    // 料金設定のリスト
    List<Pricing>? pricingList,

    // 注意事項(Markdown形式)
    String? notes,

    // 動画配信予定日時
    DateTime? videoDeliveryDateTime,

    // 動画配信予定日
    String? videoDeliveryDate,

    // 動画配信予定時刻
    String? videoDeliveryTime,

    // 動画配信タイプ(0:undefined, 1:Live, 2:Streaming)
    int? videoDeliveryType,

    // コンテンツ所持者
    MoviePlatform? videoHolder,

    // 動画URL
    String? videoUrl,

    // イベント主催者ID(0:undefined)
    int? hostId,

    // イベント主催者名
    String? hostName,

    // イベントステータス(0:開催前, 1:開催中, 2:開催終了, 3:中止, 4:延期)
    int? status,

    // イベント用問合せ先メールアドレス
    String? inquiryEmailAddress,

    // ハッシュタグのリスト
    List<String>? tagList,
  }) = _HappyoEvent;
  factory HappyoEvent.fromJson(Map<String, dynamic> json) =>
      _$HappyoEventFromJson(json);
}
