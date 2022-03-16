import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp_lms/utils/date_util.dart';
import 'package:fyp_lms/utils/dialog.dart';
import 'package:fyp_lms/web_service/model/post/post.dart';
import 'package:fyp_lms/web_service/model/user/account.dart';
import 'package:nb_utils/nb_utils.dart';

class AddPostController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  String? id;

  /*  Post Title */
  String? title;

  /*  Post Type  */
  String? type;

  /*  Post Color  */
  String? typeColor;

  /*  Post Created Date  */
  String? createdDate;

  /*  Post Last Update Date */
  String? lastUpdate;

  /*  Post createdBy  */
  String? createdBy;

  /*  Post courseBelonging  */
  String? courseBelonging;

  /*  Post Color  */
  String? color;

  /*  Post Notes  */
  String? notes;

  /*  Post Attachments  */
  List<String>? attachments;

  /*  Number of Likes Count  */
  String? likes;

  /*  Number of Comments Count  */
  String? commentsCount;


  bool isEdit = false;


  List<String> postTypeSelection = [
    'General',
    'Announcement',
    'Examination',
  ];


  populateData(Post post) {
    id = post.id;
    title = post.title;
    type = post.type;
    typeColor = post.typeColor;
    createdDate = post.createdDate;
    lastUpdate = post.lastUpdate;
    createdBy = post.createdBy;
    courseBelonging = post.courseBelonging;
    color = post.color;
    notes = post.notes;
    attachments = post.attachments;
    likes = post.likes;
    commentsCount = post.commentsCount;
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
      String title,
      String type,
      String typeColor,
      String createdDate,
      String lastUpdate,
      String createdBy,
      String courseBelonging,
      String color,
      String notes,
      String attachments,
      String likes,
      String commentsCount,
      ) async {
    //CONVERT COLOR INTO STRING
    String? errorMessage;
    if (title.isEmpty) {
      errorMessage ??= 'title cannot be empty.';
    }

    if (type.isEmpty) {
      errorMessage ??= 'type cannot be empty.';
    }

    if (typeColor.isEmpty) {
      errorMessage ??= 'typeColor cannot be empty.';
    }

    if (createdDate.isEmpty) {
      errorMessage ??= 'createdDate cannot be empty.';
    }

    if (lastUpdate.isEmpty) {
      errorMessage ??= 'lastUpdate cannot be empty.';
    }

    if (createdBy.isEmpty) {
      errorMessage ??= 'createdBy cannot be empty.';
    }

    if (courseBelonging.isEmpty) {
      errorMessage ??= 'courseBelonging cannot be empty.';
    }

    if (color.isEmpty) {
      errorMessage ??= 'Color cannot be empty.';
    }

    if (notes.isEmpty) {
      errorMessage ??= 'notes cannot be empty.';
    }

    if (errorMessage != null && errorMessage.isNotEmpty) {
      showInfoDialog(context, null, errorMessage);
      return;
    }

    showLoading(context);

    // courseHour = [
    //   DateUtil().getTimeFormatServer().format(DateTime.parse(timeStart)),
    //   DateUtil().getTimeFormatServer().format(DateTime.parse(timeEnd)),
    // ];


    Post data = Post();
    data.id = '${courseBelonging}_posts';
    data.title = title;
    data.type = type;
    data.typeColor = typeColor;
    data.createdDate = createdDate;
    data.lastUpdate = lastUpdate;
    data.createdBy = createdBy;
    data.courseBelonging = courseBelonging;
    data.color = color;
    data.notes = notes;
    // data.attachments = attachments;
    data.likes = likes;
    data.commentsCount = commentsCount;

    _db.collection('post').doc('${courseBelonging}_Posts').set(data.toJson());


  }


}