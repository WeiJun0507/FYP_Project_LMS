import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp_lms/utils/dialog.dart';
import 'package:fyp_lms/web_service/model/course/course.dart';
import 'package:fyp_lms/web_service/model/post/post.dart';
import 'package:fyp_lms/web_service/model/user/account.dart';

class PostDetailController {
  //=================================VARIABLES===================================
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;


  String? accountId, accountName;
  int? accountType;
  Account? user;

  Post? post;

  Course? course;

  bool isLoading = false, isLiked = false;

  List<String> colorSelection = [
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

  List<Color> colorSelectionColor = [
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

  //====================================METHODS===================================

  deletePost(BuildContext context, Post post) async {
    showLoading(context);

    //DELETE POST
    await _db.collection('post').doc(post.id).delete();


    //DELETE POST MATERIAL
    QuerySnapshot postMaterialSnapshot = await _db.collection('post_material').doc(post.id).collection(post.id!).get();
    for (var postMaterial in postMaterialSnapshot.docs) {
      postMaterial.reference.delete();
    }

    Navigator.of(context).pop();
    showSuccessDialog(context, 'Delete Success', 'Post is Removed successfully', () {
      Navigator.of(context).pop();
    });
  }

}