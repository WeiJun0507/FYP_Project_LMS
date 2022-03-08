import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class AddCourseController {
  String? id;

  /*  Course Name  */
  String? courseName;

  /*  Course Overview  */
  String? courseOverview;

  /*  Course Duration  */
  List<String>? courseHour;

  /*  Course Description  */
  String? courseDescription;

  /*  Course Announcement  */
  String? courseAnnouncement;

  /*  Course Midterm  */
  String? courseMidtermDate;

  /*  Course Final  */
  String? courseAssignmentDate;

  /*  Course Final  */
  String? courseFinalDate;

  /*  Assigned To (Lecture Code)  */
  String? assignedTo;

  /*  Assigned To (Lecture Name)  */
  String? assignedToName;

  /*  Number of Student Enrolled  */
  int? studentEnrolled;

  /*  Course Color  */
  Color? color;

  /*  Course Image  */
  String? courseImage;


  List<String> courseColorSelection = [
    'Yellow',
    'Orange',
    'Red',
    'Pink',
    'Deep Purple',
    'Blue',
    'Light Blue',
    'Green Accent',
    'Green',
    'Teal',
  ];

  List<Color> courseColorSelectionColor = [
    Colors.yellow,
    Colors.orange,
    Colors.red,
    Colors.pink,
    Colors.deepPurple,
    Colors.blue,
    Colors.lightBlue,
    Colors.greenAccent,
    Colors.green,
    Colors.teal,
  ];

  compileData() {
    //CONVERT COLOR INTO STRING
  }


}