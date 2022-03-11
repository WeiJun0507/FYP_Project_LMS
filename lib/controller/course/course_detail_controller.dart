import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp_lms/web_service/model/user/account.dart';

import '../../web_service/model/course/course.dart';

class CourseDetailController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? accountId;
  String? accountName;
  int? accountType;
  Account? user;

  bool isLoading = false;

  Course? course;

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

}