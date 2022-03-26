import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fyp_lms/utils/date_util.dart';
import 'package:fyp_lms/utils/dialog.dart';
import 'package:fyp_lms/web_service/model/course/course.dart';
import 'package:fyp_lms/web_service/model/post/post.dart';
import 'package:fyp_lms/web_service/model/user/account.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../web_service/model/course_material/course_material.dart';

class AddPostController {
  //=====================================================VARIABLES==================================================
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  String? id;

  /*  Post Title */
  String? title;

  /*  Post Type  */
  String? type;

  /*  Post Color  */
  Color? typeColor;

  /*  Post Created Date  */
  String? createdDate;

  /*  Post Last Update Date */
  String? lastUpdate;

  /*  Post createdBy  */
  String? createdBy;

  /*  Post createdBy  */
  String? createdByName;

  /*  User AccountType  */
  int? accountType;

  /*  Post courseBelonging  */
  String? courseBelonging;

  /*  Post Color  */
  Color? color;

  /*  Post Notes  */
  String? notes;

  /*  Post Attachments  */
  List<String>? attachments = List.empty(growable: true);
  List<String>? attachmentsFull = List.empty(growable: true);

  /*  Number of Likes Count  */
  int? likes;

  /*  Number of Comments Count  */
  int? commentsCount;

  Account? user;

  bool isEdit = false, isLoading = false;

  List<String> postTypeSelection = [
    'General',
    'Announcement',
    'Examination',
  ];

  List<String> postColorSelection = [
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

  List<Color> postColorSelectionColor = [
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

  List<Course> courseList = List.empty(growable: true);

  // populateData(Post post) {
  //   id = post.id;
  //   title = post.title;
  //   type = post.type;
  //   typeColor = post.typeColor;
  //   createdDate = post.createdDate;
  //   lastUpdate = post.lastUpdate;
  //   createdBy = post.createdBy;
  //   courseBelonging = post.courseBelonging;
  //   color = post.color;
  //   notes = post.notes;
  //   attachments = post.attachments;
  //   likes = post.likes;
  //   commentsCount = post.commentsCount;
  // }

  //==================================================METHODS===================================================

  fetchCourse(VoidCallback onCallback) async {
    isLoading = true;
    onCallback();

    print(
        '======================================BEGIN FETCH ACCOUNT===========================================');
    //GET ACCOUNT COURSE ASSIGNED
    DocumentSnapshot account = await _db.collection('account')
        .doc(user!.id)
        .get();

    print(
        '======================================STOP FETCH ACCOUNT===========================================');
    //print('= ${account.data()} =');
    print(
        '======================================ACCOUNT DATA===================================================');

    user = Account.fromJson(account.data() as Map<String, dynamic>);


    if (accountType == 1) {
      //GET ACCOUNT COURSE TAKEN
      List<String>? courseTaken = user!.courseTaken;
      courseList.clear();

      if (courseTaken != null) {
        for (var courseCode in courseTaken) {
          print(
              '======================================BEGIN FETCH COURSE LIST===========================================');
          DocumentSnapshot snapshot = await _db.collection('Course').doc(courseCode).get();

          print(
              '======================================END FETCH COURSE LIST===========================================');
          //print('= ${snapshot.data()} =');
          print(
              '======================================COURSE DATA===========================================');

          if (snapshot.data() != null) {
            courseList.add(Course.fromJson((snapshot.data() as Map<String, dynamic>)));
          }
          onCallback();
        }
      }

      isLoading = false;
      onCallback();
    } else {
      List<String>? courseAssigned = user!.courseAssigned;
      courseList.clear();

      if (courseAssigned != null) {
        for (var courseCode in courseAssigned) {
          print(
              '======================================BEGIN FETCH COURSE LIST===========================================');
          DocumentSnapshot snapshot =
          await _db.collection('Course').doc(courseCode).get();

          print(
              '======================================END FETCH COURSE LIST===========================================');
          //print('= ${snapshot.data()} =');
          print(
              '======================================COURSE DATA===========================================');

          if (snapshot.data() != null) {
            courseList.add(Course.fromJson((snapshot.data() as Map<String, dynamic>)));
          }
          onCallback();
        }
      }
      isLoading = false;
      onCallback();
    }

    courseBelonging = courseList[0].id;
  }

  compileData(
    BuildContext context,
    String title,
    String notes,
  ) async {
    //CONVERT COLOR INTO STRING
    String? errorMessage;
    if (title.isEmpty) {
      errorMessage ??= 'title cannot be empty.';
    }

    if (notes.isEmpty) {
      errorMessage ??= 'notes cannot be empty.';
    }

    if (errorMessage != null && errorMessage.isNotEmpty) {
      showInfoDialog(context, null, errorMessage);
      return;
    }

    showLoading(context);

    Post data = Post();
    data.id = '${courseBelonging}_$createdDate';
    data.title = title;
    data.type = type;
    data.typeColor =
        postColorSelection[postColorSelectionColor.indexOf(typeColor!)];
    data.createdDate = createdDate;
    data.lastUpdate = lastUpdate;
    data.createdBy = createdBy;
    data.createdByName = createdByName;
    data.courseBelonging = courseBelonging;
    data.color = postColorSelection[postColorSelectionColor.indexOf(color!)];
    data.notes = notes;
    data.attachments = attachments;
    data.likes = 0;
    data.commentsCount = 0;

    print('=========================================ADD POST TO COLLECTION=================================================');
    _db
        .collection('post')
        .doc('${courseBelonging}_$createdDate')
        .set(data.toJson())
        .then((_) async {
      List uploadedAttachment = List.empty(growable: true);

      if (attachments != null && attachments!.isNotEmpty) {
        int index = 0;
        for (var attachment in attachments!) {
          //UPLOAD FILE
          final uploaded =
          await uploadFile(context, File(attachments![index]), index);
          index++;

          //REPLACE ATTACHMENTS DATA INSIDE POST COLLECTION
          uploadedAttachment.add(uploaded);
        }
      }

      if (uploadedAttachment.isNotEmpty) {
        print('==================================================UPDATE POST DOCUMENT FIELD======================================');
        await _db
            .collection('post')
            .doc('${courseBelonging}_$createdDate')
            .update({
          'attachments': uploadedAttachment,
        }).then((_) {
          Navigator.of(context).pop();
          showSuccessDialog(context, 'Success', 'Post Created Successfully',
              () {
            Navigator.of(context).pop();
          });
        });
      } else {
        Navigator.of(context).pop();
        showSuccessDialog(context, 'Success', 'Post Created Successfully',
                () {
              Navigator.of(context).pop();
            });
      }
    }, onError: (e) {
      print(e.toString());
      showInfoDialog(context, null, e.toString());
    });
  }

  uploadFile(BuildContext context, File file, int index) async {
    print('=========================================PUTTING FILE INTO FIRECLOUD============================================');
    final TaskSnapshot uploadedFile = await _storage
        .ref()
        .child('${courseBelonging}_${createdDate}_${file.path}')
        .putFile(File(attachmentsFull![index]));
    final downloadLink = await uploadedFile.ref.getDownloadURL();

    CourseMaterial courseMaterial = CourseMaterial();
    courseMaterial.materialPath = downloadLink;
    courseMaterial.materialName = file.path;
    courseMaterial.id = '${courseBelonging}_${createdDate}_${file.path}';
    courseMaterial.courseBelonging = courseBelonging;
    courseMaterial.createdDate =
        DateUtil().getDatetimeFormatServer().format(DateTime.now());
    courseMaterial.fileSize =
        File(attachmentsFull![index]).readAsBytesSync().length.toString();
    courseMaterial.materialType = file.path.isVideo
        ? 'video'
        : file.path.isImage
            ? 'image'
            : 'document';
    courseMaterial.submittedBy = createdBy;
    print('===============================================ADD POST MATERIAL===================================================');

    DocumentSnapshot snapshot = await _db
        .collection('post_material')
        .doc('${courseBelonging}_$createdDate').get();
    List attachment = List.empty(growable: true);
    if (snapshot.data() != null) {
      attachment = (snapshot.data() as Map<String, dynamic>)['fileList'];
    }

    _db
        .collection('post_material')
        .doc('${courseBelonging}_$createdDate').set({
      'courseBelonging': courseBelonging,
      'createdDate': createdDate,
      'id': '${courseBelonging}_$createdDate',
      'fileList': [...attachment, '${courseBelonging}_${createdDate}_${file.path}']
    });
    _db
        .collection('post_material')
        .doc('${courseBelonging}_$createdDate')
        .collection('${courseBelonging}_$createdDate')
        .doc('${courseBelonging}_${createdDate}_${file.path}')
        .set(courseMaterial.toJson())
        .then((_) {}, onError: (e) {
      Navigator.of(context).pop();
    });
    return downloadLink;
  }
}
