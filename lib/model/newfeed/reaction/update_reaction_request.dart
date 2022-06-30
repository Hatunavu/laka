import 'package:json_annotation/json_annotation.dart';

part 'update_reaction_request.g.dart';

@JsonSerializable()
class UpdateReactionRequest {
  final String type;

  UpdateReactionRequest({required this.type});

  factory UpdateReactionRequest.fromJson(Map<String, dynamic> json) {
    return _$UpdateReactionRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UpdateReactionRequestToJson(this);
}
