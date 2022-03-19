import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment {
  String? id;
  String? commentCreated;
  String? createdDate;
  String? createdBy;
  String? lastUpdate;
  String? notes;
  String? postId;
  String? courseBelonging;


  Comment();

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);
  Map<String, dynamic> toJson() => _$CommentToJson(this);

}