// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_reaction_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateReactionResponse _$UpdateReactionResponseFromJson(
        Map<String, dynamic> json) =>
    UpdateReactionResponse(
      data: UpdateReactionData.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as int,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$UpdateReactionResponseToJson(
        UpdateReactionResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
    };

UpdateReactionData _$UpdateReactionDataFromJson(Map<String, dynamic> json) =>
    UpdateReactionData(
      id: json['_id'] as String,
      reacted: json['reacted'] == null
          ? null
          : ReactedModel.fromJson(json['reacted'] as Map<String, dynamic>),
      totalReactions: json['totalReactions'] == null
          ? null
          : ReactionModel.fromJson(
              json['totalReactions'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UpdateReactionDataToJson(UpdateReactionData instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'reacted': instance.reacted,
      'totalReactions': instance.totalReactions,
    };
