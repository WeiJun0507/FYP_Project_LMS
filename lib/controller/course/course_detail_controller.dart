import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fyp_lms/utils/constant.dart';
import 'package:fyp_lms/utils/dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:fyp_lms/web_service/model/course_material/course_material.dart';
import 'package:fyp_lms/web_service/model/user/account.dart';
import '../../utils/date_util.dart';
import '../../web_service/model/course/course.dart';


class CourseDetailController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
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

  List attachmentList = List.empty(growable: true);

  uploadFile(BuildContext context, PlatformFile file) async {
    showLoading(context);

    final uploadedFile = _storage.ref().child('${course!.courseCode}_${course!.courseName}/${file.name}').putFile(File(file.path!));
    uploadedFile.then((TaskSnapshot snapshot) async {
      final downloadLink = await snapshot.ref.getDownloadURL();

      CourseMaterial courseMaterial = CourseMaterial();
      courseMaterial.materialPath = downloadLink;
      courseMaterial.materialName = file.name;
      courseMaterial.id = '${course!.courseCode}_${course!.courseName}_${file.name}';
      courseMaterial.courseBelonging = course!.courseCode;
      courseMaterial.createdDate = DateUtil().getDatetimeFormatServer().format(DateTime.now());
      courseMaterial.fileSize = file.size.toString();
      courseMaterial.materialType = file.name.isVideo ? 'video' : file.name.isImage ? 'image' : 'document';
      courseMaterial.submittedBy = accountId;

      _db.collection('course_material')
          .doc('${course!.courseCode}_${course!.courseName}')
          .collection('${course!.courseCode}_${course!.courseName}')
          .doc('${course!.courseCode}_${course!.courseName}_${file.name}')
          .set(courseMaterial.toJson()).then((_) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Row(
            children: [
              // ICON
              Container(
                padding: const EdgeInsets.all(large_padding),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
                child: Icon(Icons.done, color: Colors.greenAccent[700],),
              ),
              const SizedBox(width: normal_padding),
              // TEXT
              Text('File Upload Succeed.', style: GoogleFonts.poppins().copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),),
            ],
          ),
          behavior: SnackBarBehavior.floating,
          duration: Duration(milliseconds: 1500),
          margin: const EdgeInsets.only(left: large_padding, right: large_padding, bottom: x_large_padding),
          backgroundColor: Colors.greenAccent,

        ),);
      },
        onError: (e) {
            Navigator.of(context).pop();
            showInfoDialog(context, null, e.toString(), callback: () {
              Navigator.of(context).pop();
            });
        }
      );
    });
  }

}