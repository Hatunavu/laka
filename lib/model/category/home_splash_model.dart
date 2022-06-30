import 'package:json_annotation/json_annotation.dart';
part 'home_splash_model.g.dart';

@JsonSerializable()
class HomeSplashMode {
  final int index;
  final String image;

  HomeSplashMode({required this.index, required this.image});
  factory HomeSplashMode.fromJson(Map<String, dynamic> json) =>
      _$HomeSplashModeFromJson(json);

  Map<String, dynamic> toJson() => _$HomeSplashModeToJson(this);
}
