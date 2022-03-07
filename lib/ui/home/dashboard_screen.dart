import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:fyp_lms/utils/constant.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/dashboard/dashboard_controller.dart';
import 'package:fyp_lms/ui/dashboard/upcoming_event_widget.dart';
import 'package:fyp_lms/ui/dashboard/post_item.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DashboardController controller = DashboardController();

  final ScrollController scrollController = ScrollController();


  @override
  void initState() {
    super.initState();
    //Todo: fetch course

    //Todo: fetch post

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 0,
      ),
      body: RefreshIndicator(
        displacement: 60,
        onRefresh: () => controller.initRefresh(),
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            //PROFILE ICON
            SliverToBoxAdapter(
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.only(top: x_large_padding, bottom: x_large_padding, right: large_padding),
                  padding: const EdgeInsets.all(normal_padding),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: Icon(Icons.person, color: BG_COLOR_4, size: 22,),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.only(bottom: 20.0, left: large_padding),
                child: Text('UPCOMING EVENT', style: GoogleFonts.poppins().copyWith(
                  fontSize: BIG_TITLE,
                  fontWeight: FontWeight.bold,
                ),),
              ),
            ),

            //UPCOMING COURSE
            SliverToBoxAdapter(
              child: CarouselSlider.builder(
                itemCount: 3,
                itemBuilder: (BuildContext ctx, int index, int pageIndex) {
                  return upcomingEventWidget(context, null);
                },
                options: CarouselOptions(
                  enableInfiniteScroll: false,
                  enlargeCenterPage: false,
                  disableCenter: true,
                  viewportFraction: 0.9,
                  //scrollPhysics:
                ),
              )
            ),


            //POST LISTING
            SliverPadding(
              padding: const EdgeInsets.only(left: large_padding, top: x_large_padding),
              sliver: SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('RECENT POST', style: GoogleFonts.poppins().copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.1,
                      fontSize: BIG_TITLE,
                    ),),

                    Container(
                      margin: const EdgeInsets.only(right: large_padding, top: normal_padding, bottom: normal_padding),
                      padding: const EdgeInsets.only(left: large_padding, right: large_padding, top: small_padding, bottom: small_padding),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        color: BG_COLOR_4.withOpacity(0.2),
                      ),
                      child: Icon(Icons.add, size: 18,),
                    )
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: ListView.builder(
                controller: scrollController,
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (BuildContext ctx, int index) {
                  return postItem();
                },
                padding: const EdgeInsets.only(bottom: x_large_padding),
              ),
            )

          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
