import 'package:flutter/material.dart';
import 'package:fyp_lms/ui/home/custom_profile_clipper.dart';
import 'package:fyp_lms/utils/constant.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:fyp_lms/controller/auth/auth_services.dart';
import 'package:fyp_lms/utils/general_utils.dart';
import 'package:google_fonts/google_fonts.dart';
class ProfileScreen extends StatefulWidget {

  const ProfileScreen({Key? key}) : super(key: key);

  @override
State<ProfileScreen> createState() => _ProfileScreenState();
}
final AuthService _auth = AuthService();

Widget buildCoverImage() => ClipPath(
  clipper: CustomProfileClipper(),
  child: Container(
    width: double.infinity,
    height: 280,
    color: BG_COLOR_4,
  ),

);
Widget buildProfileImage() => Container(
  alignment: Alignment.center,
  padding: const EdgeInsets.all(45),
  margin: const EdgeInsets.all(normal_padding),
  decoration: ShapeDecoration(
    color: Colors.blue,
    shape: CircleBorder(),
  ),
  child: Text(GeneralUtil().getShortName('W J'), style: GoogleFonts.poppins().copyWith(
    fontSize: BIG_TITLE,
    color: Colors.white,
  ),),
);

Widget buildTop(){
  return Stack(
    clipBehavior: Clip.none,
    alignment: Alignment.center,
    children: [
      Container(
          margin: EdgeInsets.only(bottom: 66),
          child: buildCoverImage()
      ),
      Positioned(
        top: 215,
        child: buildProfileImage(),
      ),
    ],
  );
}

Widget buildContent(){
  return Column(
      children: [
        const SizedBox(height: 6),
        Text('Wei Jun', style: TextStyle(fontSize: TITLE, fontWeight: FontWeight.bold),),
        const SizedBox(height: 3),
        Text('Course: Java Web', style: TextStyle(fontSize: SUB_TITLE),),
        const SizedBox(height: 3),
        Text('Year 3 Sem 3', style: TextStyle(fontSize: SUB_TITLE),),
      ]
  );
}

Widget buildButtons(context){
  return Container(
    margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
    padding: EdgeInsets.all(20),
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      boxShadow: [
        BoxShadow(
          offset: Offset(1.0, 1.0),
          color: Colors.grey,
          blurRadius: 1,
        )
      ]
    ),
    child:Row(
      children: const [
        Icon(
            Icons.directions_run_outlined,
            color: BG_COLOR_2
        ),
        // Icons.person_outline_outlined
        SizedBox(width: 30),
        Expanded(
          child:
          Text("Log Out"),
        ),
        Icon(Icons.chevron_right_outlined),
      ],
    ),
  ).onTap(() async {
    SharedPreferences _sPref = await SharedPreferences.getInstance();
    _sPref.clear();
    _auth.signOut();
    Navigator.of(context).pushReplacementNamed('/Login');

  });
}
class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          buildTop(),
          buildContent(),
          buildButtons(context),
        ],
      ),
    );
  }
}