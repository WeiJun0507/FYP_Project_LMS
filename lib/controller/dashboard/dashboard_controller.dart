import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp_lms/utils/date_util.dart';

import '../../web_service/model/course/course.dart';
import '../../web_service/model/user/account.dart';

class DashboardController {

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  String? accountId;
  String? accountName;
  int? accountType;
  Account? user;

  int pageNo = 1;
  bool allowNextPage = true,
      isLoading = false, hasInit = false;

  List<Course> upcomingCourseList = List.empty(growable: true);
  List<Map<String, dynamic>> upcomingDateList = List.empty(growable: true);

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


  Future initRefresh(Function setState) async {
    //FETCH UPCOMING COURSE
    fetchUpcomingCourse(setState);

    // FETCH POST
    return;
  }

  fetchUpcomingCourse(Function setState) async {
    upcomingCourseList.clear();
    upcomingDateList.clear();
    isLoading = true;
    setState(() {});

    if (accountType == 1) {
      //GET ACCOUNT COURSE TAKEN
    } else {
      print(
          '======================================BEGIN FETCH ACCOUNT===========================================');
      //GET ACCOUNT COURSE ASSIGNED
      DocumentSnapshot account = await _db.collection('account')
          .doc(accountId)
          .get();

      print(
          '======================================STOP FETCH ACCOUNT===========================================');
      //print('= ${account.data()} =');
      print(
          '======================================ACCOUNT DATA===================================================');

      List<String>? courseAssigned;
      if (account.data() != null) {
        courseAssigned = Account
            .fromJson(account.data() as Map<String, dynamic>)
            .courseAssigned;
      }

      if (courseAssigned != null) {
        courseAssigned.forEach((courseCode) async {
          print(
              '======================================BEGIN FETCH COURSE LIST===========================================');
          DocumentSnapshot snapshot = await _db.collection('Course').doc(courseCode).get();

          print(
              '======================================END FETCH COURSE LIST===========================================');
          //print('= ${snapshot.data()} =');
          print(
              '======================================COURSE DATA===========================================');

          if (snapshot.data() != null) {
            Course course = Course.fromJson(snapshot.data() as Map<String,dynamic>);
            upcomingCourseList.add(course);

            final DateTime courseCreatedDate = DateTime.parse(course.createdAt!);
            final DateTime today = DateTime.now();
            int dayDifference = today.difference(courseCreatedDate).inDays;
            for (int i = 0; i < dayDifference ~/ 7; i++) {
              courseCreatedDate.add(Duration(days: 7));
            }

            print('========================================= FETCH COURSE ACCORDING DATE ====================================');
            print('= QUERY PARAMETERS =');
            print('= ${DateUtil().getDateFormatServer().format(courseCreatedDate)} =');
            print('= ${DateUtil().getDateFormatServer().format(courseCreatedDate)}_$courseCode =');
            print('==========================================================================================================');

            QuerySnapshot snapshotData = await _db.collection('Course').doc(courseCode).collection('${DateUtil().getDateFormatServer().format(courseCreatedDate)}_$courseCode').get();
            print('= ${snapshotData.docs[0].data()} =');
            print('========================================= END FETCH COURSE ACCORDING DATE ====================================');
            if (snapshotData.docs.isNotEmpty) {
              Map<String, dynamic> data = snapshotData.docs[0].data() as Map<String,dynamic>;
              upcomingDateList.add({
                'date': data['date'],
                'duration': data['duration'],
                'createdAt': data['createdAt'],
              });

              upcomingDateList.sort((a,b) =>
                join(DateTime.now(), TimeOfDay(hour: int.tryParse(a['duration'].substring(0,2))!, minute: int.tryParse(a['duration'].substring(3,5))!))
                    .difference(
                    join(DateTime.now(), TimeOfDay(hour: int.tryParse(b['duration'].substring(0,2))!, minute: int.tryParse(b['duration'].substring(3,5))!)))
                    .inMilliseconds
              );
            }
          }
          setState(() {});
        });
        isLoading = false;
        setState(() {});
      }
    }
  }

  DateTime join(DateTime date, TimeOfDay time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }
}