import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp_lms/utils/date_util.dart';
import 'package:fyp_lms/utils/dialog.dart';
import 'package:fyp_lms/web_service/model/course/course.dart';
import 'package:fyp_lms/web_service/model/user/account.dart';
import 'package:nb_utils/nb_utils.dart';

class AddCourseController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  String? id;

  /*  Course Code  */
  String? courseCode;

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

  /*  Course Venue */
  String? venue;


  /*  Course Color  */
  Color? color;

  /*  Course Image  */
  String? courseImage;

  bool isEdit = false;


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
    Colors.yellow[300]!,
    Colors.orange[300]!,
    Colors.red[300]!,
    Colors.pink[300]!,
    Colors.deepPurple[300]!,
    Colors.blue[300]!,
    Colors.lightBlue[300]!,
    Colors.greenAccent[200]!,
    Colors.green[300]!,
    Colors.teal[300]!,
  ];

  populateData(Course course) {
    id = course.id;
    courseCode = course.courseCode;
    courseName = course.courseName;
    courseOverview = course.courseOverview;
    courseHour = course.courseHour;

    courseDescription = course.courseDescription;
    courseAnnouncement = course.courseAnnouncement;
    courseMidtermDate = course.courseMidtermDate;
    courseAssignmentDate = course.courseAssignmentDate;
    courseFinalDate = course.courseFinal;
    assignedTo = course.assignedTo;
    assignedToName = course.assignedToName;
    studentEnrolled = course.studentEnrolled as int?;
    venue = course.venue;
    courseImage = course.courseImage;
  }

  //courseDescription.text,
  //                 courseOverview.text,
  //                 courseAnnouncement.text,
  //                 courseMidtermDate.text,
  //                 courseAssignmentDate.text,
  //                 courseFinal.text,
  //                 colorController.text,
  compileData(
      BuildContext context,
      String code,
      String name,
      String description,
      String overview,
      String announcement,
      String midtermDate,
      String assignmentDate,
      String finalDate,
      int color,
      String timeStart,
      String timeEnd,
      String venue,
      String studentEnrolled,
      ) async {
    //CONVERT COLOR INTO STRING
    String? errorMessage;
    if (code.isEmpty) {
      errorMessage ??= 'Course name cannot be empty.';
    }
    
    if (name.isEmpty) {
      errorMessage ??= 'Course name cannot be empty.';
    }

    if (description.isEmpty) {
      errorMessage ??= 'Course description cannot be empty.';
    }

    if (overview.isEmpty) {
      errorMessage ??= 'Course overview cannot be empty.';
    }

    if (announcement.isEmpty) {
      errorMessage ??= 'Course announcement cannot be empty.';
    }

    if (midtermDate.isEmpty) {
      errorMessage ??= 'Course midterm date cannot be empty.';
    }

    if (assignmentDate.isEmpty) {
      errorMessage ??= 'Course assignment date cannot be empty.';
    }

    if (finalDate.isEmpty) {
      errorMessage ??= 'Course final date cannot be empty.';
    }

    if (timeStart.isEmpty) {
      errorMessage ??= 'Course start duration cannot be empty.';
    }

    if (timeEnd.isEmpty) {
      errorMessage ??= 'Course end duration cannot be empty.';
    }

    if (venue.isEmpty) {
      errorMessage ??= 'Course venue cannot be empty.';
    }

    if (studentEnrolled.isEmpty) {
      errorMessage ??= 'Course cannot have empty student enrolled.';
    }

    if (errorMessage != null && errorMessage.isNotEmpty) {
      showInfoDialog(context, null, errorMessage);
      return;
    }

    showLoading(context);

    courseHour = [
      DateUtil().getTimeFormatServer().format(DateTime.parse(timeStart)),
      DateUtil().getTimeFormatServer().format(DateTime.parse(timeEnd)),
    ];
    
    Course data = Course();
    data.id = '${code}_$name';
    data.courseCode = code;
    data.courseName = name;
    data.courseHour = courseHour;
    data.assignedTo = assignedTo;
    data.assignedToName = assignedToName;
    data.courseDescription = description;
    data.courseOverview = overview;
    data.courseAnnouncement = announcement;
    data.courseMidtermDate = courseMidtermDate;
    data.courseAssignmentDate = courseAnnouncement;
    data.courseFinal = courseFinalDate;
    data.color = courseColorSelection[color];
    data.studentEnrolled = studentEnrolled;
    data.venue = venue;
    data.isHide = false;

    await _db.collection('Course').doc('${code}_$name').set(data.toJson()).then((value) async {
      //ADD DURATION
      for (int i = 0; i < 4; i++) {
        String today = DateUtil().getDateFormatServer().format(DateTime.now().add(Duration(days: i * 7)));
        _db.collection('Course').doc('${code}_$name').collection('${today}_${code}_$name')
            .doc('${DateUtil().getTimeFormatServer().format(DateTime.parse(timeStart))} - ${DateUtil().getTimeFormatServer().format(DateTime.parse(timeEnd))}')
            .set({'duration': '${DateUtil().getTimeFormatServer().format(DateTime.parse(timeStart))} - ${DateUtil().getTimeFormatServer().format(DateTime.parse(timeEnd))}',
        });
      }
      //UPDATE ASSIGNED COURSE FOR LECTURER
      final DocumentSnapshot userReference = await _db.collection('account').doc(assignedTo).get();
      List<String>? courseAssigned = Account.fromJson((userReference.data() as Map<String, dynamic>)).courseTaken;
      await _db.collection('account').doc(assignedTo).update({
        'courseAssigned': courseAssigned != null ? [...courseAssigned, '${code}_$name'] : ['${code}_$name'],
      }).then((result) {
        showSuccessDialog(context, 'Success', 'Course Created', () {
          Navigator.of(context).pop();
          Navigator.of(context).pop({
            'result': 200,
          });
        });
      });


    }, onError: (e) {
      Navigator.of(context).pop();
      showInfoDialog(context, null, e);
    });


  }


}