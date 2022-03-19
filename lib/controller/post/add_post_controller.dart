import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fyp_lms/utils/date_util.dart';
import 'package:fyp_lms/utils/dialog.dart';
import 'package:fyp_lms/web_service/model/post/post.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../web_service/model/course_material/course_material.dart';

class AddPostController {
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


  bool isEdit = false;

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
    data.typeColor = postColorSelection[postColorSelectionColor.indexOf(typeColor!)];
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

    _db.collection('post').doc('${courseBelonging}_$createdDate').set(data.toJson()).then((_) async {
      List uploadedAttachment = List.empty(growable: true);
      int index = 0;
      for (var attachment in attachments!) {
        //UPLOAD FILE
        final uploaded = await uploadFile(context, File(attachments![index]), index);
        index++;

        //REPLACE ATTACHMENTS DATA INSIDE POST COLLECTION
        uploadedAttachment.add(uploaded);
      }

      if (uploadedAttachment.isNotEmpty) {
        await _db.collection('post').doc('${courseBelonging}_$createdDate').update({
          'attachments': uploadedAttachment,
        }).then((_) {
          Navigator.of(context).pop();
          showSuccessDialog(context, 'Success', 'Post Created Successfully', () {
            Navigator.of(context).pop();

          });
        });
      }
    }, onError: (e) {
      print(e.toString());
      showInfoDialog(context, null, e.toString());
    });

  }

  uploadFile(BuildContext context, File file, int index) async {
    final TaskSnapshot uploadedFile = await _storage.ref().child('${courseBelonging}_${createdDate}_${file.path}').putFile(File(attachmentsFull![index]));
    final downloadLink = await uploadedFile.ref.getDownloadURL();

    CourseMaterial courseMaterial = CourseMaterial();
    courseMaterial.materialPath = downloadLink;
    courseMaterial.materialName = file.path;
    courseMaterial.id = '${courseBelonging}_${createdDate}_${file.path}';
    courseMaterial.courseBelonging = courseBelonging;
    courseMaterial.createdDate = DateUtil().getDatetimeFormatServer().format(DateTime.now());
    courseMaterial.fileSize = File(attachmentsFull![index]).readAsBytesSync().length.toString();
    courseMaterial.materialType = file.path.isVideo ? 'video' : file.path.isImage ? 'image' : 'document';
    courseMaterial.submittedBy = createdBy;

    _db.collection('post_material')
        .doc('${courseBelonging}_$createdDate')
        .collection('${courseBelonging}_$createdDate')
        .doc('${courseBelonging}_${createdDate}_${file.path}')
        .set(courseMaterial.toJson()).then((_) {},
        onError: (e) {
          Navigator.of(context).pop();
          showInfoDialog(context, null, e.toString(), callback: () {
            Navigator.of(context).pop();
          });
        }
    );
    return downloadLink;
  }


}