import 'package:client_tggt/model/vendor/services_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_list_services_response.g.dart';

@JsonSerializable()
class GetListServicesResponse {
  @JsonKey(name: 'data')
  final ListServicesDocs? data;
  final int? status;
  final String? message;
  final dynamic errors;

  GetListServicesResponse({this.data, this.status, this.message, this.errors});

  factory GetListServicesResponse.fromJson(Map<String, dynamic> json) =>
      _$GetListServicesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetListServicesResponseToJson(this);
}

@JsonSerializable()
class ListServicesDocs {
  @JsonKey(name: 'docs')
  final List<ServicesModel>? docs;
  final int? totalDocs;

  ListServicesDocs({this.docs, this.totalDocs});

  factory ListServicesDocs.fromJson(Map<String, dynamic> json) =>
      _$ListServicesDocsFromJson(json);

  Map<String, dynamic> toJson() => _$ListServicesDocsToJson(this);
}
