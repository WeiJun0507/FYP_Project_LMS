import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp_lms/web_service/model/course/course.dart';
import 'package:fyp_lms/web_service/model/user/account.dart';
import 'package:nb_utils/nb_utils.dart';

class CourseListingController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? accountId;
  String? accountName;
  int? accountType;
  Account? user;

  List<Course> currentCourseList = List.empty(growable: true);
  List<Course> hideCourseList = List.empty(growable: true);

  bool isLoading = false, courseListingIsExpanded = true, previousCourseListingIsExpanded = true, editMode = false;

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

  fetchCurrentCourse(Function setState) async {
    isLoading = true;
    setState(() {});
    if (accountType == 1) {
      //GET ACCOUNT COURSE TAKEN
    } else {
      print('======================================BEGIN FETCH ACCOUNT===========================================');
      //GET ACCOUNT COURSE ASSIGNED
      DocumentSnapshot account = await _db.collection('account').doc(accountId).get();

      print('======================================STOP FETCH ACCOUNT===========================================');
      //print('= ${account.data()} =');
      print('======================================ACCOUNT DATA===================================================');

      List<String>? courseAssigned;
      if (account.data() != null) {
        courseAssigned = Account.fromJson(account.data() as Map<String, dynamic>).courseAssigned;
      }
      currentCourseList.clear();
      hideCourseList.clear();
      if (courseAssigned != null) {
        courseAssigned.forEach((courseCode) async {
          print('======================================BEGIN FETCH COURSE LIST===========================================');
          DocumentSnapshot snapshot = await _db.collection('Course').doc(courseCode).get();

          print('======================================END FETCH COURSE LIST===========================================');
          //print('= ${snapshot.data()} =');
          print('======================================COURSE DATA===========================================');

          if (snapshot.data() != null && !(snapshot.data() as Map<String,dynamic>)['isHide']) {
            currentCourseList.add(Course.fromJson((snapshot.data() as Map<String,dynamic>)));
          } else {
            hideCourseList.add(Course.fromJson((snapshot.data() as Map<String,dynamic>)));
          }
          setState(() {});
        });
        isLoading = false;
        setState(() {});
      }
    }

  }
}