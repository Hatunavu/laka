import 'package:client_tggt/model/newfeed/post/post.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_reaction_response.g.dart';

@JsonSerializable()
class UpdateReactionResponse {
  @JsonKey(name: 'data')
  final UpdateReactionData data;
  final int status;
  final String? message;

  UpdateReactionResponse(
      {required this.data, required this.status, this.message});
  factory UpdateReactionResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateReactionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateReactionResponseToJson(this);
}

@JsonSerializable()
class UpdateReactionData {
  @JsonKey(name: '_id')
  final String id;
  final ReactedModel? reacted;
  final ReactionModel? totalReactions;

  UpdateReactionData({required this.id, this.reacted, this.totalReactions});
  factory UpdateReactionData.fromJson(Map<String, dynamic> json) =>
      _$UpdateReactionDataFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateReactionDataToJson(this);
}
