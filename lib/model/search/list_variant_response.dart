import 'package:client_tggt/model/vendor/tagline_model.dart';
import 'package:client_tggt/model/vendor/variant_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'list_variant_response.g.dart';

@JsonSerializable()
class ListVariantResponse {
  @JsonKey(name: 'data')
  final List<VariantModel> data;
  final int status;
  final String? message;
  final dynamic errors;

  ListVariantResponse(
      {required this.data, required this.status, this.message, this.errors});
  factory ListVariantResponse.fromJson(Map<String, dynamic> json) =>
      _$ListVariantResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListVariantResponseToJson(this);
}
