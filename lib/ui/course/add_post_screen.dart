import 'package:flutter/material.dart';
import 'package:fyp_lms/controller/post/add_post_controller.dart';
import 'package:fyp_lms/utils/constant.dart';
import 'package:fyp_lms/utils/custom_field/input/datetime_field.dart';
import 'package:fyp_lms/utils/custom_field/input/dropdown_field.dart';
import 'package:fyp_lms/utils/custom_field/input/number_input_field.dart';
import 'package:fyp_lms/utils/custom_field/input/text_input_field.dart';
import 'package:fyp_lms/utils/custom_field/input/textarea_input_field.dart';
import 'package:fyp_lms/utils/custom_field/input/time_range_field.dart';
import 'package:fyp_lms/utils/date_util.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../web_service/model/course/course.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  AddPostController controller = AddPostController();
  SharedPreferences? _sPref;

  TextEditingController notesDescription = TextEditingController();
  TextEditingController postTypeController = TextEditingController();


  int postTypeSelection = 0;

  String? timeStartDisplay;
  String? timeEndDisplay;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) {
      setState(() {
        _sPref = value;
        initializeData();
      });
    });

    postTypeController.text = controller.postTypeSelection[0];
    timeStartDisplay = DateUtil().getDatetimeFormatServer().format(DateTime.now());
    timeEndDisplay = DateUtil().getDatetimeFormatServer().format(DateTime.now().add(Duration(hours: 2)));
  }

  initializeData() {
    //_sPref.setString('accountInfo', jsonEncode(createdUser));
    // controller.createdBy = _sPref!.getString('account');
    controller.createdBy = _sPref!.getString('username');
    controller.createdDate = DateUtil().getDatetimeFormatServer().format(DateTime.now());
      final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
      if (arguments['course'] != null) {
        setState(() {
          controller.isEdit = true;
          Course course = arguments['course'];
          controller.populateData(course);

          codeController.text = course.courseCode!;
          nameController.text = course.courseName!;
          courseDescription.text = course.courseDescription!;
          timeStart.text = course.courseHour![0];
          timeEnd.text = course.courseHour![1];

          DateTime now = DateTime.now();
          List<String> start = course.courseHour![0].split(':');
          List<String> end = course.courseHour![1].split(':');
          timeStartDisplay = DateUtil().getDatetimeFormatServer().format(DateTime(now.year,now.month,now.day,int.tryParse(start[0])!,int.tryParse(start[1])!));
          timeEndDisplay = DateUtil().getDatetimeFormatServer().format(DateTime(now.year,now.month,now.day,int.tryParse(end[0])!,int.tryParse(end[1])!));

          courseOverview.text = course.courseOverview!;
          courseAnnouncement.text = course.courseAnnouncement!;
          courseMidtermDate.text = DateUtil().getDatetimeFormatDisplay().format(DateTime.parse(course.courseMidtermDate!));
          courseAssignmentDate.text = DateUtil().getDatetimeFormatDisplay().format(DateTime.parse(course.courseAssignmentDate!));
          courseFinal.text = DateUtil().getDatetimeFormatDisplay().format(DateTime.parse(course.courseFinal!));
          colorController.text = course.color!;
          controller.color = controller.courseColorSelectionColor[controller.courseColorSelection.indexOf(course.color!)];
          courseVenue.text = course.venue!;
          studentEnrolled.text = course.studentEnrolled!;
        });
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: controller.color ?? BG_COLOR_4,
        leading: Icon(Icons.arrow_back, color: Colors.white,).onTap(() {
          Navigator.of(context).pop();
        }),
        centerTitle: true,
        title: Text(controller.isEdit ? 'edit Post' : 'Add New Post', style: GoogleFonts.poppins().copyWith(
          fontSize: TITLE,
          fontWeight: FontWeight.bold,
        ),),
        elevation: 0,
        actions: [
          Container(
            padding: const EdgeInsets.all(normal_padding),
            alignment: Alignment.center,
            child: Text('Done', style: GoogleFonts.poppins().copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),),
          ).onTap(() {
            controller.compileData(
              context,
              codeController.text,
              nameController.text,
              courseDescription.text,
              courseOverview.text,
              courseAnnouncement.text,
              courseMidtermDate.text,
              courseAssignmentDate.text,
              courseFinal.text,
              colorSelection,
              timeStartDisplay!,
              timeEndDisplay!,
              courseVenue.text,
              studentEnrolled.text,
            );
          })
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 7),

            //ASSIGNED_TO
            Container(
              color: Colors.white,
              margin: EdgeInsets.only(bottom: 7),
              padding: EdgeInsets.only(top: 12, left: 14, bottom: 12, right: 12),
              child: Row(
                children: [
                  Icon(
                    Icons.person_pin_rounded,
                    size: 36,
                    color: Colors.grey,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //ASSIGNED CHIP VIEW
                          Text(controller.assignedToName ?? 'Empty', overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black54)),
                        ],
                      )
                  ),
                ],
              ),
            ),

            Container(
              color: Colors.white,
              padding: EdgeInsets.only(top: large_padding,bottom: normal_padding),
              alignment: Alignment.center,
              child: Text('Post Detail', style: TextStyle(
                  fontWeight: FontWeight.w600
              )),
            ),

            Container(
              color: Colors.white,
              child: Column(
                children: [
                  textareaInputField(notesDescription, () {}, 'Post Description:', ),
                  //DROPDOWN SELECT COLOR
                  dropdownField(context, controller.postTypeSelection, controller.postTypeSelection, postTypeController, () {
                    setState(() {
                      postTypeSelection = controller.postTypeSelection.indexOf(postTypeController.text.toString());
                    });
                  }, 'Post Type'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }
}
