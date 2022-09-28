import 'package:freezed_annotation/freezed_annotation.dart';

part 'master.freezed.dart';
part 'master.g.dart';

@freezed
class Master with _$Master {
  factory Master({
    @Default([]) List<String> categories,
  }) = _Master;

  factory Master.fromJson(Map<String, dynamic> json) => _$MasterFromJson(json);

  // Future<String> get appVersion async {
  //   return 'ver1.0.0';
  // }
}
