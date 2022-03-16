import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fyp_lms/utils/constant.dart';
import 'package:fyp_lms/utils/date_util.dart';
import 'package:fyp_lms/utils/dialog.dart';
import 'package:fyp_lms/web_service/model/post/post.dart';
import 'package:fyp_lms/web_service/model/user/account.dart';
import 'package:google_fonts/google_fonts.dart';
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
    data.typeColor = postColorSelection[postColorSelectionColor.indexOf(color!)];
    data.createdDate = createdDate;
    data.lastUpdate = lastUpdate;
    data.createdBy = createdBy;
    data.courseBelonging = courseBelonging;
    data.color = postColorSelection[postColorSelectionColor.indexOf(color!)];
    data.notes = notes;
    data.attachments = attachments;
    data.likes = 0;
    data.commentsCount = 0;

    _db.collection('post').doc('${courseBelonging}_$createdDate').set(data.toJson()).then((_) {
      attachments!.forEach((file) {
        //UPLOAD FILE
        //REPLACE ATTACHMENTS DATA INSIDE POST COLLECTION
      });
    }, onError: (e) {
      print(e.toString());
      showInfoDialog(context, null, e.toString());
    });

  }

  uploadFile(BuildContext context, PlatformFile file) async {
    showLoading(context);

    final uploadedFile = _storage.ref().child('${courseBelonging}_$createdDate/${file.name}').putFile(File(file.path!));
    uploadedFile.then((TaskSnapshot snapshot) async {
      final downloadLink = await snapshot.ref.getDownloadURL();

      CourseMaterial courseMaterial = CourseMaterial();
      courseMaterial.materialPath = downloadLink;
      courseMaterial.materialName = file.name;
      courseMaterial.id = '${courseBelonging}_${createdDate}_${file.name}';
      courseMaterial.courseBelonging = courseBelonging;
      courseMaterial.createdDate = DateUtil().getDatetimeFormatServer().format(DateTime.now());
      courseMaterial.fileSize = file.size.toString();
      courseMaterial.materialType = file.name.isVideo ? 'video' : file.name.isImage ? 'image' : 'document';
      courseMaterial.submittedBy = createdBy;

      _db.collection('post_material')
          .doc('${courseBelonging}_$createdDate')
          .collection('${courseBelonging}_$createdDate')
          .doc('${courseBelonging}_${createdDate}_${file.name}')
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