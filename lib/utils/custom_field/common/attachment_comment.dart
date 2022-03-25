import 'package:flutter/material.dart';
import 'package:fyp_lms/utils/constant.dart';
import 'package:fyp_lms/utils/custom_field/common/round_corner_document_view.dart';
import 'package:fyp_lms/utils/custom_field/common/round_corner_image_view.dart';
import 'package:fyp_lms/utils/general_utils.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart' as p;


Widget attachmentComment(
    BuildContext context,
    commentAttachment){

  List<dynamic> attachmentList = commentAttachment;

  return attachmentList.isEmpty ? Container(
    alignment: Alignment.topLeft,
    height: 120,
    child: Container(
      height: 120.0,
      width: 120.0,
      decoration: BoxDecoration(
          color: Colors.grey[100],
          border: Border.all(color: Colors.grey[300]!,width: 1.5),
          borderRadius: BorderRadius.all(Radius.circular(11))),
      margin: EdgeInsets.only(right: 6),
      padding: EdgeInsets.only(left: small_padding, right: small_padding, top: large_padding, bottom: large_padding),
      child: Column(
        children: const [
          Icon(Icons.priority_high_rounded),
          SizedBox(height: normal_padding),
          Text('No Attachment'),
        ],
      ),
    ),
  ) : Container(
    alignment: Alignment.topLeft,
    height: 60,
    child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: attachmentList.length,
        itemExtent: 56,
        padding: EdgeInsets.only(left: 14, right: 14),
        itemBuilder: (context, index) {

          String? path = attachmentList[index];
          String? pathCopy = attachmentList[index];
          int extensionIndex = path!.indexOf('?');
          if (pathCopy!.substring(pathCopy.indexOf('.', extensionIndex - 5) + 1, extensionIndex) != 'jpg' &&
              pathCopy.substring(pathCopy.indexOf('.', extensionIndex - 5) + 1, extensionIndex) != 'jpeg' &&
              pathCopy.substring(pathCopy.indexOf('.', extensionIndex - 5) + 1, extensionIndex) != 'png') {
            path = path.substring(0, extensionIndex);
          }

          //RENDER DOC VIEW
          return path.isDoc || path.isExcel || path.isPdf || path.isPPT || path.isTxt || p.extension(path) == '.csv' ?
          roundCornerDocument(path, (path) => null, size: 50.0, iconSize: 20.0, showDelete: false).onTap(() async {

            if(path!.contains('http')){
              GeneralUtil.openDocumentOnline(context,path);
              //String encodedPath = Uri.encodeFull(path);
              //await canLaunch(encodedPath) ? await launch(encodedPath) :  showInfoDialog(context,null,'Could not launch $path');
            }else {
              OpenFile.open(path);
            }

          }) :
          //RENDER IMAGE VIEW
          roundCornerImage(path, (path) => null, size: 50.0, space: 6, showDelete: false).onTap(() {
            Navigator.of(context).pushNamed('/ImagePreviewScreen', arguments: {
              'attachments': attachmentList,
              'currentIndex': index,
            });
          });
        }),
  );
}