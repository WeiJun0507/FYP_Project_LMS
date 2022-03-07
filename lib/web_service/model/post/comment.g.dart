// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post()
  ..id = json['id'] as String?
  ..commentCreated = json['commentCreated'] as String?
  ..createdDate = json['createdDate'] as String?
  ..createdBy = json['createdBy'] as String?
  ..lastUpdate = json['lastUpdate'] as String?
  ..notes = json['notes'] as String?
  ..postId = json['postId'] as String?
  ..courseBelonging = json['courseBelonging'] as String?;

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'commentCreated': instance.commentCreated,
      'createdDate': instance.createdDate,
      'createdBy': instance.createdBy,
      'lastUpdate': instance.lastUpdate,
      'notes': instance.notes,
      'postId': instance.postId,
      'courseBelonging': instance.courseBelonging,
    };
