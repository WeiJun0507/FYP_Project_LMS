import 'package:flutter/material.dart';
import 'package:fyp_lms/utils/constant.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 0,
      ),
      body: CustomScrollView(
        slivers: [
          //PROFILE ICON
          SliverToBoxAdapter(
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: const EdgeInsets.all(X_LARGE_V_GAP),
                padding: const EdgeInsets.all(V_GAP),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Icon(Icons.person, color: BG_COLOR_4, size: 22,),
              ),
            ),
          ),

          //UPCOMING COURSE
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.only(left: LARGE_H_GAP, right: LARGE_H_GAP),
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
                padding: const EdgeInsets.all(LARGE_H_GAP),
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/course_icon.png'), fit: BoxFit.cover, opacity: 0.3),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: H_GAP),
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
                            const SizedBox(width: LARGE_V_GAP),

                            Text('Course Code: ', style: GoogleFonts.poppins().copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: TITLE,
                            )),
                            Text('CC101', style: GoogleFonts.poppins().copyWith(
                              fontSize: HINT_TEXT,
                              color: Colors.black,
                            )),

                            const SizedBox(height: X_LARGE_V_GAP),

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
                              margin: const EdgeInsets.only(left: X_LARGE_H_GAP, right: X_LARGE_H_GAP, top: V_GAP),
                              padding: const EdgeInsets.only(top: H_GAP, bottom: H_GAP),
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
            ),
          ),

          //CAROUSEL SLIDER INDICATOR

          
          //POST LISTING
          SliverPadding(
            padding: const EdgeInsets.only(left: LARGE_H_GAP, top: X_LARGE_V_GAP),
            sliver: SliverToBoxAdapter(
              child: Text('Post: ', style: GoogleFonts.poppins().copyWith(
                fontWeight: FontWeight.w900,
                letterSpacing: 1.1,
                color: BG_COLOR_4,
              ),),
            ),
          ),

        ],
      ),
    );
  }
}
