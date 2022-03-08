import 'package:flutter/material.dart';
import 'package:fyp_lms/controller/course/add_course_controller.dart';
import 'package:fyp_lms/utils/constant.dart';
import 'package:fyp_lms/utils/custom_field/input/datetime_field.dart';
import 'package:fyp_lms/utils/custom_field/input/dropdown_field.dart';
import 'package:fyp_lms/utils/custom_field/input/text_input_field.dart';
import 'package:fyp_lms/utils/custom_field/input/textarea_input_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

class AddCourseScreen extends StatefulWidget {
  const AddCourseScreen({Key? key}) : super(key: key);

  @override
  State<AddCourseScreen> createState() => _AddCourseScreenState();
}

class _AddCourseScreenState extends State<AddCourseScreen> {
  AddCourseController controller = AddCourseController();
  SharedPreferences? _sPref;

  TextEditingController nameController = TextEditingController();
  TextEditingController courseDescription = TextEditingController();
  TextEditingController courseOverview = TextEditingController();
  TextEditingController courseAnnouncement = TextEditingController();
  TextEditingController courseMidtermDate = TextEditingController();
  TextEditingController courseAssignmentDate = TextEditingController();
  TextEditingController courseFinal = TextEditingController();
  TextEditingController colorController = TextEditingController();

  int colorSelection = 0;


  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) {
      setState(() {
        _sPref = value;
        initializeData();
      });
    });
  }

  initializeData() {
    //_sPref.setString('accountInfo', jsonEncode(createdUser));

    controller.assignedTo = _sPref!.getString('account');
    controller.assignedToName = _sPref!.getString('username');
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
        title: Text('Add New Course', style: GoogleFonts.poppins().copyWith(
          fontSize: TITLE,
          fontWeight: FontWeight.bold,
        ),),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: controller.color ?? BG_COLOR_4,
                // borderRadius: BorderRadius.only(
                //   bottomLeft: Radius.circular(10.0),
                //   bottomRight: Radius.circular(10.0),
                // ),
              ),
              padding: const EdgeInsets.all(large_padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //TITLE
                  Text('Course Name:', style: GoogleFonts.poppins().copyWith(
                    fontSize: TITLE,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),),
                  //TextField
                  Container(
                    margin: const EdgeInsets.all(normal_padding),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      controller: nameController,
                      onChanged: (value) {
                        setState(() {});
                      },
                      style: GoogleFonts.poppins().copyWith(
                          fontSize: 14, color: Colors.black
                      ),
                      minLines: 1,
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[200]!),
                              borderRadius: BorderRadius.all(Radius.circular(10.0))
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[200]!),
                              borderRadius: BorderRadius.all(Radius.circular(10.0))
                          ),
                          contentPadding: const EdgeInsets.only(left: 12, bottom: 10, top: 10, right: 12),
                          suffixIcon: nameController.text.isEmpty ? null :
                          IconButton(
                            iconSize: 20,
                            icon: const Icon(Icons.cancel),
                            onPressed: (){
                              setState(() {
                                nameController.text = '';
                              });
                            },
                          )
                      ),
                    )
                  ),
                ],
              )
            ),
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
                    size: 18,
                    color: Colors.grey,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(('Assigned To'.toUpperCase()),
                              style: TextStyle(
                                  fontSize: 11.5,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500)),
                          SizedBox(height: 7),
                          //ASSIGNED CHIP VIEW
                          Container(
                              width: 110,
                              margin: EdgeInsets.only(right: small_padding, top: small_padding),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[200]!),
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.grey[200],
                              ),
                              child: Row(
                                children: [
                                  Container(
                                      height: 17,
                                      width: 17,
                                      margin: EdgeInsets.only(right: 5, left: 4, top: 4, bottom: 4),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.pink,
                                      ),
                                      child: Icon(Icons.business,color: white,size: 10)
                                  ),
                                  Flexible(child: Text(controller.assignedToName!, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.w600, color: Colors.black54))),
                                  SizedBox(width: 7),
                                ],
                              )
                          ),
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
              child: Text('Course Detail', style: TextStyle(
                  fontWeight: FontWeight.w600
              )),
            ),

            Container(
              color: Colors.white,
              child: Column(
                children: [
                  textInputField(courseDescription, () {}, 'Course Description'),
                  textareaInputField(courseOverview, () {}, 'Course Overview'),
                  textInputField(courseAnnouncement, () {}, 'Course Announcement'),
                  datetimeField(context, courseMidtermDate, controller.courseMidtermDate, () {
                    setState(() {});
                  }, 'Course Mid Term Date'),
                  datetimeField(context, courseAssignmentDate, controller.courseAssignmentDate, () {
                    setState(() {});
                  }, 'Course Assignment'),
                  datetimeField(context, courseFinal, controller.courseFinalDate, () {
                    setState(() {});
                  }, 'Course Final Examination'),

                  //DROPDOWN SELECT COLOR
                  dropdownField(context, controller.courseColorSelection, controller.courseColorSelectionColor, colorController, () {
                    setState(() {
                      int selectedColor = controller.courseColorSelection.indexOf(colorController.text.toString());
                      controller.color = controller.courseColorSelectionColor[selectedColor];
                    });
                  }, 'Course Color'),
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
