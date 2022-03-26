import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:chewie/chewie.dart';
import 'package:fyp_lms/web_service/model/course/course.dart';
import 'package:fyp_lms/web_service/model/post/post.dart';
import 'package:fyp_lms/web_service/model/user/account.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:video_player/video_player.dart';

class ImagePreviewController {
  //=============================    VARIABLES   ==============================
  String? accountId;
  String? accountName;
  Account? user;
  int? accountType;

  //CLICKED INDEX
  late int currentIndex;

  Course? course;
  Post? post;

  bool isLoading = false, barVisible = true, fromCourse = false, fromPost = false;

  int onScreenPointer = 0;

  //ALL ATTACHMENT LIST
  List<dynamic> attachmentList = List.empty();
  List<dynamic> attachmentListOri = List.empty();
  Map<int, VideoPlayerController> videoPlayerController = {};
  Map<int, ChewieController> customVideoPlayerController = {};

  ui.Image? imageInfo;
  double? scaleImageHeight;

  /*late VideoPlayerController videoPlayerController;
  CustomVideoPlayerController customVideoPlayerController =
  CustomVideoPlayerController();*/

  //=============================    METHODS   ================================

  initialization(BuildContext context, VoidCallback onCallback) async {
    convertFileToImage(context, attachmentList[currentIndex], onCallback);

    for (int index = 0; index < attachmentList.length; index++) {

      var element = attachmentList[index];
      if (isVideo(element)) {
        if (element.toString().contains('http')) {
          VideoPlayerController videoController =
              VideoPlayerController.network(Uri.encodeFull(element));
          await videoController.initialize();

          videoPlayerController.putIfAbsent(index, () => videoController);
          customVideoPlayerController.putIfAbsent(
              index,
              () => ChewieController(
                    videoPlayerController: videoController,
                    autoPlay: false,
                    looping: false,
                    autoInitialize: true,
                  ));
        } else {
          VideoPlayerController videoController =
              VideoPlayerController.file(File(element));
          await videoController.initialize();

          videoPlayerController.putIfAbsent(index, () => videoController);
          customVideoPlayerController.putIfAbsent(
              index,
              () => ChewieController(
                    videoPlayerController: videoController,
                    autoPlay: false,
                    looping: false,
                    autoInitialize: true,
                  ));
        }
      }
      onCallback();
    }
    onCallback();
  }

  onChangedPage(BuildContext context, int index, VoidCallback onCallback) {
    currentIndex = index;
    convertFileToImage(context, attachmentList[currentIndex], onCallback);
    onCallback();
  }

  isVideo(String path) {
    String video = r'.(mp4|MP4|avi|wmv|rmvb|mpg|mpeg|3gp|mkv|mov|MOV)$';
    return hasMatch(path, video);
  }

  void dispose() {
    customVideoPlayerController.forEach((_, v) {
      v.dispose();
    });
    videoPlayerController.forEach((_, v) {
      v.dispose();
    });
  }

  convertFileToImage(BuildContext context, String currentImage,
      VoidCallback onCallback) async {
    if (currentImage.contains('http') && currentImage.isImage) {
      isLoading = true;
      onCallback();
      Image image = Image.network(currentImage);
      image.image.resolve(ImageConfiguration()).addListener(
        ImageStreamListener(
          (ImageInfo image, bool synchronousCall) {
            imageInfo = image.image;
            scaleImageHeight =
                (image.image.height * MediaQuery.of(context).size.width) /
                    image.image.width;

            isLoading = false;
            onCallback();
          },
        ),
      );
    } else {
      if (currentImage.isImage) {
        Uint8List imgBytes = File(currentImage).readAsBytesSync();
        ui.Codec codec = await ui.instantiateImageCodec(imgBytes);
        ui.FrameInfo frame = await codec.getNextFrame();

        imageInfo = frame.image;
        scaleImageHeight =
            (frame.image.height * MediaQuery.of(context).size.width) /
                frame.image.width;
      } else {
        scaleImageHeight = MediaQuery.of(context).size.width;
      }
    }
    onCallback();
  }
}
