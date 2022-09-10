import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie.freezed.dart';
part 'movie.g.dart';

@freezed
class Movie with _$Movie {
  factory Movie({
    // YouTube動画Id
    String? youtubeId,

    // その他動画のURL
    String? hlsUrl,

    // いいね数
    int? likes,

    // 視聴数
    int? views,

    // 投稿者名
    String? hostName,

    // 投稿者Id
    String? hostId,

    // ダウンロードURL
    String? downloadUrl,

    // コンテンツ所持者(0:Happyo, 1:YouTube)
    int? videoHolder,

    // 動画カテゴリ
    List<String>? category,

    // 動画投稿日時
    DateTime? postedAt,

    // 動画タイトル
    String? title,

    // YouTube動画のタグ
    List<String>? tag,
  }) = _Movie;

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
}
