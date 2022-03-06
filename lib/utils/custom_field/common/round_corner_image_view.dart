import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';



Widget roundCornerImage(
    String path,
    Function(String path) onDelete,
    {var size = 70.0, var space = 6, var showDelete = true, offlineMode = true}){


  return Stack(
    children: [
      AbsorbPointer(
        child: Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey[300]!,width: 1.5),
              borderRadius: BorderRadius.all(Radius.circular(11))),
          margin: EdgeInsets.only(right: 6),
          child: imageWidget(path, size),
        ),
      ),
      (!path.contains('http') && !offlineMode) ? Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
            color: Colors.white60,
            border: Border.all(color: Colors.grey[300]!,width: 1.5),
            borderRadius: BorderRadius.all(Radius.circular(11))),
        margin: EdgeInsets.only(right: 6),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              SizedBox(
                child: CircularProgressIndicator(strokeWidth: 3),
                height: 24.0,
                width: 24.0,
              )
            ]
        ),
      ) : SizedBox(),
      showDelete ? Positioned(
        child: Container(
          height: 24,
          width: 24,
          alignment: Alignment.topRight,

          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white
            ),
            child: Icon(
              Icons.cancel,
              color: Colors.red,
              size: 20,
            ),
          ).onTap((){
            onDelete(path);
          }),
        ),
        top: 3.5,
        right: 9.5,
      ) : SizedBox(),
    ],
  );
}

Widget imageWidget(String mPath,double size) {
  if (mPath.contains('http')) {

    return ClipRRect(
      borderRadius: BorderRadius.circular(9),
      child: Stack(
        children: [
          isVideo(mPath) ? Container(color: Colors.grey) : Image(
              image: CachedNetworkImageProvider(mPath),
              width: size,
              height: size,
              fit: BoxFit.cover),

          //DISPLAY PLAY ICON ON THE VIDEO THUMBNAIL
          isVideo(mPath) ? Positioned(
            child: Center(child: Icon(Icons.play_circle_outline, color: Colors.grey[600], size: 30)),
          ) : SizedBox(),
        ],
      ),
    ).onTap(() async {
      FocusManager.instance.primaryFocus!.unfocus();
    });
  }else{
    if(mPath.isEmpty){
      return ClipRRect(
          borderRadius: BorderRadius.circular(9),
          child: SizedBox(
              width: size,
              height: size
          ));
    }else{
      return ClipRRect(
        borderRadius: BorderRadius.circular(9),
        child: Stack(
          children: [
            isVideo(mPath) ? Container(color: Colors.grey) : Image.file(File(mPath), width: size, height: size, fit: BoxFit.cover),

            isVideo(mPath) ? Positioned(
              child: Center(child: Icon(Icons.play_circle_outline, color: Colors.grey[600], size: 30)),
            ) : SizedBox(),
          ],
        ),
      ).onTap(() async {
        FocusManager.instance.primaryFocus!.unfocus();
      });
    }

  }


}

isVideo(String path){
  String video = r'.(mp4|MP4|avi|wmv|rmvb|mpg|mpeg|3gp|mkv|mov|MOV)$';
  return hasMatch(path, video);
}