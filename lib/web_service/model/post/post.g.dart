// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post()
  ..id = json['id'] as String?
  ..title = json['title'] as String?
  ..type = json['type'] as String?
  ..typeColor = json['typeColor'] as String?
  ..createdDate = json['createdDate'] as String?
  ..lastUpdate = json['lastUpdate'] as String?
  ..createdBy = json['createdBy'] as String?
  ..courseBelonging = json['courseBelonging'] as String?
  ..color = json['color'] as String?
  ..notes = json['notes'] as String?
  ..attachments =
      (json['attachments'] as List<dynamic>?)?.map((e) => e as String).toList()
  ..likes = json['likes'] as String?
  ..commentsCount = json['commentsCount'] as String?;

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'type': instance.type,
      'typeColor': instance.typeColor,
      'createdDate': instance.createdDate,
      'lastUpdate': instance.lastUpdate,
      'createdBy': instance.createdBy,
      'courseBelonging': instance.courseBelonging,
      'color': instance.color,
      'notes': instance.notes,
      'attachments': instance.attachments,
      'likes': instance.likes,
      'commentsCount': instance.commentsCount,
    };
