import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable()
class Post {
  String? id;
  String? title;
  String? type;
  String? typeColor;
  String? createdDate;
  String? lastUpdate;
  String? createdBy;
  String? courseBelonging;
  String? color;
  String? notes;
  List<String>? attachments;
  String? likes;
  String? commentsCount;

  Post();

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);

}