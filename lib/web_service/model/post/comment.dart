import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable()
class Post {
  String? id;
  String? commentCreated;
  String? createdDate;
  String? createdBy;
  String? lastUpdate;
  String? notes;
  String? postId;
  String? courseBelonging;


  Post();

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);

}