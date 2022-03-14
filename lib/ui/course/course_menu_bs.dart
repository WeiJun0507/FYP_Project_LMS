import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fyp_lms/controller/course/course_detail_controller.dart';
import 'package:fyp_lms/web_service/model/course_material/course_material.dart';
import 'package:nb_utils/nb_utils.dart';


Widget courseMenuBS (BuildContext context, CourseDetailController controller){

  return GestureDetector(
    onTap: () {
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    },
    child: SingleChildScrollView(
      child: Container(
        //color: Colors.white,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(10.0),
                topRight: const Radius.circular(10.0))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.drag_handle,
              color: Colors.grey,
            ),
            Container(
              padding: EdgeInsets.only(top: 13, bottom: 10, left: 10),
              child: Row(
                children: [
                  Icon(
                    Icons.check,
                    color: Colors.greenAccent,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Text('Add Course Material',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600
                              ))
                      ),
                      Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Text('Upload Course Material',
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey
                              ))
                      ),
                    ],
                  )
                ],
              ),
            ).onTap(() async {
              FilePickerResult? pickResult = await FilePicker.platform.pickFiles(
                  type: FileType.any,
                  allowMultiple: false,
              );

              if (pickResult != null) {
                Navigator.of(context).pop();
                controller.uploadFile(context, pickResult.files[0]);
              }
            }),
            Divider(
              height: 1,
              indent: 10,
              endIndent: 10,
            ),

            Container(
              padding: EdgeInsets.only(top: 13, bottom: 10, left: 10),
              child: Row(
                children: [
                  Icon(
                    Icons.check,
                    color: Colors.grey,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Text('Course Material',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600
                              ))
                      ),
                      Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Text('Browse Course Uploaded Material',
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey
                              ))
                      ),
                    ],
                  )
                ],
              ),
            ).onTap((){

            }),
            Divider(
              height: 1,
              indent: 10,
              endIndent: 10,
            ),

            Container(
              padding: EdgeInsets.only(top: 13, bottom: 10, left: 10),
              child: Row(
                children: [
                  Icon(
                    Icons.check,
                    color: Colors.grey,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Text('Course Edit',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600
                              ))
                      ),
                      Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Text('Edit the Course detail',
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey
                              ))
                      ),
                    ],
                  )
                ],
              ),
            ).onTap((){
              Navigator.of(context).pop(2);
            }),
            Divider(
              height: 1,
              indent: 10,
              endIndent: 10,
            ),

          ],
        ),
      ),
    ),
  );

}