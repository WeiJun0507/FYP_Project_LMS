import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  int? id;

  /*  1 - student; 2 - lecturer  */
  int? accountType;

  /*  Account Verification  */
  String? verified;

  /*  Account Display Name  */
  String? displayName;

  /*  Academic Enrolled  */
  String? academicEnrolled;

  /*  Current Semester  */
  String? currentAcademicYear;

  /*  Current Semester Enrolled Course Code  */
  List<String>? currentEnrolledCourseCode;

  /*  Course Taken  */
  List<String>? courseTaken;

  /*  Course Assigned for Account Type 2  */
  List<String>? courseAssigned;

  User();

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

}