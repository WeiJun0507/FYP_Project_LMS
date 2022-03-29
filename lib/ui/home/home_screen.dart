import 'package:flutter/material.dart';
import 'package:fyp_lms/ui/home/course_listing_screen.dart';
import 'package:fyp_lms/ui/home/dashboard_screen.dart';
import 'package:fyp_lms/ui/home/profile_screen.dart';
import 'package:fyp_lms/ui/home/uploaded_file_screen.dart';
import 'package:fyp_lms/utils/constant.dart';

import '../../controller/dashboard/dashboard_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  //====================== VARIABLES =================================

  TabController? _tabController;
  int _currentPage = 0;


  //====================== METHODS ===================================

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);

    _tabController!.addListener(() {
      setState(() {
        _currentPage = _tabController!.index;
      });

    });
  }

  _changeTab(int index) {
    setState(() {
      _tabController!.index = index;
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          bottomNavigationBar: Builder(
            builder: (context) {
              return BottomNavigationBar(
                elevation: 0,
                showUnselectedLabels: false,
                backgroundColor: Colors.white,
                type: BottomNavigationBarType.fixed,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Column(
                      children: const [
                        Icon(
                          Icons.home,
                          color: COLOR_INVALID,
                        ),
                        SizedBox(height: small_padding),
                      ],
                    ),
                    activeIcon: Column(
                      children: const [
                        Icon(
                          Icons.home,
                          color: BG_COLOR_4,
                        ),
                        SizedBox(height: small_padding),
                      ],
                    ),
                    label: 'Dashboard',
                  ),
                  BottomNavigationBarItem(
                    icon: Column(
                      children: const [
                        Icon(
                          Icons.home,
                          color: COLOR_INVALID,
                        ),
                        SizedBox(height: small_padding),
                      ],
                    ),
                    activeIcon: Column(
                      children: const [
                        Icon(
                          Icons.home,
                          color: BG_COLOR_4,
                        ),
                        SizedBox(height: small_padding),
                      ],
                    ),
                    label: 'Course',
                  ),
                  BottomNavigationBarItem(
                    icon: Column(
                      children: const [
                        Icon(
                          Icons.collections,
                          color: COLOR_INVALID,
                        ),
                        SizedBox(height: small_padding),
                      ],
                    ),
                    activeIcon: Column(
                      children: const [
                        Icon(
                          Icons.collections,
                          color: BG_COLOR_4,
                        ),
                        SizedBox(height: small_padding),
                      ],
                    ),
                    label: 'Uploaded File',
                  ),
                  BottomNavigationBarItem(
                    icon: Column(
                      children: const [
                        Icon(
                          Icons.emoji_people,
                          color: COLOR_INVALID,
                        ),
                        SizedBox(height: small_padding),
                      ],
                    ),
                    activeIcon: Column(
                      children: const [
                        Icon(
                          Icons.emoji_people,
                          color: BG_COLOR_4,
                        ),
                        SizedBox(height: small_padding),
                      ],
                    ),
                    label: 'Profile',
                  )
                ],
                selectedFontSize: 12,
                currentIndex: _currentPage,
                selectedItemColor: BG_COLOR_4,
                unselectedItemColor: COLOR_INVALID,
                onTap: (index){
                  _changeTab(index);
                },
              );
            },
          ),
          body: TabBarView(
            controller: _tabController,
            children: const [
              //DASHBOARD
              DashboardScreen(),

              //COURSE
              CourseListingScreen(),

              //UPLOADED PAGE
              UploadedFileScreen(),

              //PROFILE
              ProfileScreen(),
            ],
          ),
        ),
      ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
