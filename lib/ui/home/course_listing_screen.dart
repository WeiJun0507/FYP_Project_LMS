import 'package:flutter/material.dart';
import 'package:fyp_lms/utils/constant.dart';
import 'package:fyp_lms/utils/custom_field/custom/custom_expansion_panel.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/dashboard/course_listing_controller.dart';

class CourseListingScreen extends StatefulWidget {
  const CourseListingScreen({Key? key}) : super(key: key);

  @override
  State<CourseListingScreen> createState() => _CourseListingScreenState();
}

class _CourseListingScreenState extends State<CourseListingScreen> {
  CourseListingController controller = CourseListingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                const Icon(Icons.edit, color: BG_COLOR_4, size: 22.0,),
              ],
            ),
          ),

          //CURRENT COURSE
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
            margin: EdgeInsets.only(top: large_padding, bottom: small_padding, left: MediaQuery.of(context).size.width * 0.15),
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
        ],
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {

        },
        child: Icon(Icons.add),
      ),
    );
  }
}
