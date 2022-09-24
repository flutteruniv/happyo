import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:happyo/common/time_stamp_converter.dart';
import 'package:happyo/model/movie/movie_platform.dart';

part 'movie.freezed.dart';
part 'movie.g.dart';

@freezed
class Movie with _$Movie {
  factory Movie({
    // ID
    String? id,

    // 動画タイトル
    String? title,

    // 動画カテゴリ
    List<String>? categoryList,

    // サムネイル画像
    String? thumbnailImage,

    // ダウンロードURL
    String? downloadUrl,

    // ストリーミングURL
    String? streamingUrl,

    // プラットフォーム
    MoviePlatform? platform,

    // 投稿者Id
    String? hostId,

    // 投稿者名
    String? hostName,

    // YouTube動画のタグ
    List<String>? tagList,

    // いいね数
    int? likes,

    // 視聴数
    int? views,

    // 作成日時
    @TimestampConverter() DateTime? createdAt,

    // 作成者
    String? createdBy,

    // 更新日時
    @TimestampConverter() DateTime? updatedAt,

    // 更新者
    String? updatedBy,

    // 削除日時
    @TimestampConverter() DateTime? deletedAt,

    // 削除者
    String? deletedBy,
  }) = _Movie;

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
}
