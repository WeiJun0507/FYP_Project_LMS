// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Course _$CourseFromJson(Map<String, dynamic> json) => Course()
  ..id = json['id'] as int?
  ..courseName = json['courseName'] as String?
  ..courseOverview = json['courseOverview'] as String?
  ..courseHour =
      (json['courseHour'] as List<dynamic>?)?.map((e) => e as String).toList()
  ..courseDescription = json['courseDescription'] as String?
  ..courseAnnouncement = json['courseAnnouncement'] as String?
  ..courseMidtermDate = json['courseMidtermDate'] as String?
  ..courseFinal = json['courseFinal'] as String?
  ..assignedTo = json['assignedTo'] as String?
  ..studentEnrolled = json['studentEnrolled'] as int?
  ..color = json['color'] as String?
  ..courseImage = json['courseImage'] as String?
  ..isHide = json['isHide'] as String?;

Map<String, dynamic> _$CourseToJson(Course instance) => <String, dynamic>{
      'id': instance.id,
      'courseName': instance.courseName,
      'courseOverview': instance.courseOverview,
      'courseHour': instance.courseHour,
      'courseDescription': instance.courseDescription,
      'courseAnnouncement': instance.courseAnnouncement,
      'courseMidtermDate': instance.courseMidtermDate,
      'courseFinal': instance.courseFinal,
      'assignedTo': instance.assignedTo,
      'studentEnrolled': instance.studentEnrolled,
      'color': instance.color,
      'courseImage': instance.courseImage,
      'isHide': instance.isHide,
    };
