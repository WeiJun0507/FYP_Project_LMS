import 'package:flutter/material.dart';
import 'package:fyp_lms/ui/home/course_listing_screen.dart';
import 'package:fyp_lms/ui/home/dashboard_screen.dart';
import 'package:fyp_lms/ui/home/profile_screen.dart';
import 'package:fyp_lms/ui/home/uploaded_file_screen.dart';
import 'package:fyp_lms/utils/constant.dart';

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
      switch(_tabController!.index) {
        //INITIALIZE DASHBOARD SCREEN, POST API FETCHING
        case 0:
          break;
        case 1:
          break;
        case 2:
          break;
        case 3:
          break;
        default:
          break;
      }
    });
  }

  _changeTab(int index) {

  }

  @override
  Widget build(BuildContext context) {
    //DO BOTTOM NAVIGATOR
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          backgroundColor: pageBackground,
          bottomNavigationBar: Builder(
            builder: (context) {
              return BottomNavigationBar(
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
                        SizedBox(height: SMALL_V_GAP),
                      ],
                    ),
                    activeIcon: Column(
                      children: const [
                        Icon(
                          Icons.home,
                          color: BG_COLOR_4,
                        ),
                        SizedBox(height: SMALL_V_GAP),
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
                        SizedBox(height: SMALL_V_GAP),
                      ],
                    ),
                    activeIcon: Column(
                      children: const [
                        Icon(
                          Icons.home,
                          color: BG_COLOR_4,
                        ),
                        SizedBox(height: SMALL_V_GAP),
                      ],
                    ),
                    label: 'Course',
                  ),
                  BottomNavigationBarItem(
                    icon: Column(
                      children: const [
                        Icon(
                          Icons.home,
                          color: COLOR_INVALID,
                        ),
                        SizedBox(height: SMALL_V_GAP),
                      ],
                    ),
                    activeIcon: Column(
                      children: const [
                        Icon(
                          Icons.home,
                          color: BG_COLOR_4,
                        ),
                        SizedBox(height: SMALL_V_GAP),
                      ],
                    ),
                    label: 'Uploaded File',
                  ),
                  BottomNavigationBarItem(
                    icon: Column(
                      children: const [
                        Icon(
                          Icons.home,
                          color: COLOR_INVALID,
                        ),
                        SizedBox(height: SMALL_V_GAP),
                      ],
                    ),
                    activeIcon: Column(
                      children: const [
                        Icon(
                          Icons.home,
                          color: BG_COLOR_4,
                        ),
                        SizedBox(height: SMALL_V_GAP),
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
          body: Stack(
            children: [
              TabBarView(
                controller: _tabController,
                children: [
                  //DASHBOARD
                  DashboardScreen(),

                  //COURSE
                  CourseListingScreen(),

                  //UPLOADED PAGE
                  UploadedFileScreen(),

                  //PROFILE
                  ProfileScreen(),
                ],
              )
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
