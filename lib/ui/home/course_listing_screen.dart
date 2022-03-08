import 'package:flutter/material.dart';
import 'package:fyp_lms/utils/constant.dart';
import 'package:fyp_lms/utils/custom_field/custom/custom_expansion_panel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../controller/dashboard/course_listing_controller.dart';

class CourseListingScreen extends StatefulWidget {
  const CourseListingScreen({Key? key}) : super(key: key);

  @override
  State<CourseListingScreen> createState() => _CourseListingScreenState();
}

class _CourseListingScreenState extends State<CourseListingScreen> {
  CourseListingController controller = CourseListingController();


  @override
  void initState() {
    super.initState();
    controller.fetchCurrentCourse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getColorFromHex('F5F5F5'),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 16.0, top: 50.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Course', style: GoogleFonts.poppins().copyWith(
                  fontSize: BIG_TITLE,
                  fontWeight: FontWeight.bold,
                ),),
                const SizedBox(width: small_padding,),
                const Icon(Icons.edit, color: BG_COLOR_4, size: 22.0,).onTap(() {
                  setState(() {
                    controller.editMode = !controller.editMode;
                  });
                }),
              ],
            ),
          ),

          //CURRENT COURSE
          Container(
            margin: const EdgeInsets.only(left: normal_padding, right: normal_padding, top: 12),
            child: CustomExpansionPanelList(
              elevation: 1,
              expandedHeaderPadding: EdgeInsets.symmetric(vertical: 3, horizontal: 2),
              animationDuration: Duration(milliseconds: 700),
              children: [
                CustomExpansionPanel(
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return Container(
                      padding: const EdgeInsets.only(left: large_padding, right: large_padding, top: normal_padding, bottom: normal_padding),
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Current Semester Course', style: GoogleFonts.poppins().copyWith(
                            fontSize: TITLE,
                          ),),

                          Text('Year 3 Semester 3', style: GoogleFonts.poppins().copyWith(
                            fontSize: SUB_TITLE,
                            color: Colors.grey,
                          ),)
                        ],
                      ),
                    );
                  },
                  body: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return controller.editMode ? Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(normal_padding),
                            child: Icon(Icons.delete, color: Colors.red, size: 18.0,),
                          ).onTap(() {
                            //REMOVE COURSE
                          }),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(left: large_padding, right: large_padding, bottom: normal_padding),
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                border: Border.all(color: Colors.grey, width: 0.5),
                              ),
                              child: ListTile(
                                leading: Text('${index + 1})'),
                                title: Text('Course $index CC10$index'),
                                trailing: Icon(Icons.zoom_out_map, size: 18.0),
                              ),
                            ),
                          )
                        ],
                      ) : Container(
                        margin: const EdgeInsets.only(left: large_padding, right: large_padding, bottom: normal_padding),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          border: Border.all(color: Colors.grey, width: 0.5),
                        ),
                        child: ListTile(
                          leading: Text('${index + 1})'),
                          title: Text('Course $index CC10$index'),
                          trailing: Icon(Icons.zoom_out_map, size: 18.0),
                        ),
                      );
                    },
                  ),
                  isExpanded: controller.courseListingIsExpanded,
                  canTapOnHeader: true
                ),
              ],
              expansionCallback: (int panelIndex, bool isExpanded) {
                setState(() {
                  controller.courseListingIsExpanded = !controller.courseListingIsExpanded;
                });
              },
            ),
          ),

          //SEPARATE INDICATOR
          Container(
            margin: EdgeInsets.only(top: large_padding, bottom: large_padding, left: MediaQuery.of(context).size.width * 0.15),
            width: MediaQuery.of(context).size.width * 0.7,
            alignment: Alignment.center,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 2,
                    color: Colors.grey[300],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: small_padding, right: small_padding),
                  height: 5,
                  width: 5,
                  decoration: ShapeDecoration(
                    color: Colors.grey[300],
                    shape: CircleBorder(),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 2,
                    color: Colors.grey[300],
                  ),
                ),
              ],
            ),
          ),

          Container(
            margin: const EdgeInsets.only(left: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Previous Semester Course', style: GoogleFonts.poppins().copyWith(
                  fontSize: TITLE,
                  fontWeight: FontWeight.bold,
                ),),
                const SizedBox(width: small_padding,),
                const Icon(Icons.edit, color: BG_COLOR_4, size: 22.0,),
              ],
            ),
          ),

          //PREVIOUS COURSE
          Container(
            margin: EdgeInsets.only(left: 16, right: 16, top: 12),
            child: CustomExpansionPanelList(
              expandedHeaderPadding: EdgeInsets.symmetric(vertical: 2),
              animationDuration: Duration(milliseconds: 700),
              children: [
                CustomExpansionPanel(
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return Container(
                        padding: const EdgeInsets.only(left: large_padding, right: large_padding, top: normal_padding, bottom: normal_padding),
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Current Semester Course', style: GoogleFonts.poppins().copyWith(
                              fontSize: TITLE,
                            ),),

                            Text('Year 3 Semester 3', style: GoogleFonts.poppins().copyWith(
                              fontSize: SUB_TITLE,
                              color: Colors.grey,
                            ),)
                          ],
                        ),
                      );
                    },
                    body: Container(

                    ),
                    isExpanded: controller.previousCourseListingIsExpanded,
                    canTapOnHeader: true
                ),
              ],
              expansionCallback: (int panelIndex, bool isExpanded) {
                setState(() {
                  controller.previousCourseListingIsExpanded = !controller.previousCourseListingIsExpanded;
                });
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          //HANDLE FOR DIFFERENT ACCOUNT TYPE
          // 1 - STUDENT
          // 2 - LECTURER
          Navigator.of(context).pushNamed('/AddCourseScreen');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
