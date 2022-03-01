import 'package:json_annotation/json_annotation.dart';

part 'course.g.dart';

@JsonSerializable()
class Course {
  int? id;

  /*  Course Name  */
  String? courseName;

  /*  Course Duration  */
  List<String>? courseHour;

  /*  Course Description  */
  String? courseDescription;

  /*  Course Announcement  */
  String? courseAnnouncement;

  /*  Course Midterm  */
  String? courseMidtermDate;

  /*  Course Final  */
  String? courseFinal;

  /*  Assigned To (Lecture Code)  */
  String? assignedTo;

  /*  Number of Student Enrolled  */
  int? studentEnrolled;

  /*  Course Color  */
  String? color;

  /*  HIDE COURSE  */
  String? isHide;


  Course();

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);
  Map<String, dynamic> toJson() => _$CourseToJson(this);

}