// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User()
  ..id = json['id'] as int?
  ..accountType = json['accountType'] as int?
  ..verified = json['verified'] as String?
  ..displayName = json['displayName'] as String?
  ..academicEnrolled = json['academicEnrolled'] as String?
  ..currentAcademicYear = json['currentAcademicYear'] as String?
  ..currentEnrolledCourseCode =
      (json['currentEnrolledCourseCode'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
  ..courseTaken =
      (json['courseTaken'] as List<dynamic>?)?.map((e) => e as String).toList()
  ..courseAssigned = (json['courseAssigned'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList();

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'accountType': instance.accountType,
      'verified': instance.verified,
      'displayName': instance.displayName,
      'academicEnrolled': instance.academicEnrolled,
      'currentAcademicYear': instance.currentAcademicYear,
      'currentEnrolledCourseCode': instance.currentEnrolledCourseCode,
      'courseTaken': instance.courseTaken,
      'courseAssigned': instance.courseAssigned,
    };
