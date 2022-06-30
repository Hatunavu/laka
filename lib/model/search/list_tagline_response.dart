import 'package:client_tggt/model/vendor/tagline_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'list_tagline_response.g.dart';

@JsonSerializable()
class ListTagLinesResponse {
  @JsonKey(name: 'data')
  final List<TaglineModel> data;
  final int status;
  final String? message;
  final dynamic errors;

  ListTagLinesResponse(
      {required this.data, required this.status, this.message, this.errors});
  factory ListTagLinesResponse.fromJson(Map<String, dynamic> json) =>
      _$ListTagLinesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListTagLinesResponseToJson(this);
}
