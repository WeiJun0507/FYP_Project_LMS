import 'package:flutter/material.dart';
import 'package:fyp_lms/web_service/model/course/course.dart';
import 'package:google_fonts/google_fonts.dart';


import 'package:fyp_lms/utils/constant.dart';

Widget upcomingEventWidget(BuildContext context, course) {
  return Container(
    margin: const EdgeInsets.only(left: large_padding, right: large_padding),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      boxShadow: const [
        BoxShadow(
          color: COLOR_INVALID,
          offset: Offset(1.5, 1.5),
          blurRadius: 5,
        ),
      ],
    ),
    child: Container(
      padding: const EdgeInsets.all(large_padding),
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/course_icon.png'), fit: BoxFit.cover, opacity: 0.3),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: normal_padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Course Name: ', style: GoogleFonts.poppins().copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: TITLE,
                  )),
                  Text('Example Course Name And Longer Course Name Example Course Name And Longer Course Name', style: GoogleFonts.poppins().copyWith(
                    fontSize: HINT_TEXT,
                    color: Colors.black,
                  )),
                  const SizedBox(width: large_padding),

                  Text('Course Code: ', style: GoogleFonts.poppins().copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: TITLE,
                  )),
                  Text('CC101', style: GoogleFonts.poppins().copyWith(
                    fontSize: HINT_TEXT,
                    color: Colors.black,
                  )),

                  const SizedBox(height: x_large_padding),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Time: ', style: GoogleFonts.poppins().copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            )),
                            const SizedBox(width: 2.0),

                            Expanded(
                              child: Text('2:00p.m. - 3.30p.m.', style: GoogleFonts.poppins().copyWith(
                                fontSize: HINT_TEXT,
                                color: Colors.black,
                              ), softWrap: true,),
                            ),

                          ],
                        ),
                      ),

                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Venue: ', style: GoogleFonts.poppins().copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            )),
                            const SizedBox(width: 2.0),

                            Expanded(
                              child: Text('CG02 - Block C', style: GoogleFonts.poppins().copyWith(
                                fontSize: HINT_TEXT,
                                color: Colors.black,
                              ), softWrap: true,),
                            ),

                          ],
                        ),
                      )
                    ],
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(left: x_large_padding, right: x_large_padding, top: normal_padding),
                    padding: const EdgeInsets.only(top: normal_padding, bottom: normal_padding),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    child: Center(
                      child: Text('View More', style: GoogleFonts.poppins().copyWith(
                        fontSize: SUB_TITLE,
                      ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}