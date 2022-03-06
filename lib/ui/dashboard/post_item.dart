import 'package:flutter/material.dart';
import 'package:fyp_lms/utils/constant.dart';
import 'package:fyp_lms/utils/general_utils.dart';
import 'package:google_fonts/google_fonts.dart';

Widget postItem() {
  return Container(
    height: 200,
    margin: const EdgeInsets.only(left: large_padding, right: large_padding, top: large_padding),
    padding: const EdgeInsets.all(normal_padding),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      boxShadow: const [
        BoxShadow(
          offset: Offset(1.0, 1.0),
          color: Colors.grey,
          blurRadius: 1,
        )
      ]
    ),
    child: Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //USER ACCOUNT
            Row(
              children: [
                //SHORT NAME
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(large_padding),
                  margin: const EdgeInsets.all(normal_padding),
                  decoration: ShapeDecoration(
                    color: Colors.blue,
                    shape: CircleBorder(),
                  ),
                  child: Text(GeneralUtil().getShortName('A B'), style: GoogleFonts.poppins().copyWith(
                    fontSize: SUB_TITLE,
                    color: Colors.white,
                  ),),
                ),

                // POST CREATOR INFORMATION
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Lecture Name', style: GoogleFonts.poppins().copyWith(

                      ),),
                      Text('15:43pm 01-01-2022, Wed', style: GoogleFonts.poppins().copyWith(
                        color: Colors.grey,
                        fontSize: SUB_TITLE,
                      ),),
                      Text('CourseName_CourseCode', style: GoogleFonts.poppins().copyWith(
                        fontSize: SUB_TITLE,
                        color: BG_COLOR_4,
                      )),
                    ],
                  ),
                )
              ],
            ),

            const SizedBox(height: small_padding),

            //DESCRIPTION
            Container(
              margin: const EdgeInsets.all(normal_padding),
              child: Text('Description Here...'),
            ),

            // DOCS, IMAGE DISPLAY

            Spacer(),
            Container(
              margin: const EdgeInsets.only(bottom: normal_padding, top: normal_padding),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //LIKES
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //ICON
                        Icon(Icons.favorite, size: 18, color: Colors.grey,),
                        const SizedBox(width: normal_padding,),
                        //TEXT
                        Text('Like 0', style: GoogleFonts.poppins().copyWith(
                          fontSize: SUB_TITLE,
                        ),),
                      ],
                    ),
                  ),
                  //COMMENT
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //ICON
                        Icon(Icons.message, size: 18, color: Colors.grey,),
                        const SizedBox(width: normal_padding,),
                        //TEXT
                        Text('Comment 0', style: GoogleFonts.poppins().copyWith(
                          fontSize: SUB_TITLE,
                        ),)
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),

        //MORE VERT (delete, edit)
      ],
    ),
  );
}