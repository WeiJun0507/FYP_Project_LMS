import 'package:flutter/material.dart';
import 'package:fyp_lms/ui/home/home_screen.dart';
import 'package:fyp_lms/ui/intro_screen.dart';
import 'package:nb_utils/nb_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPreferences? sPrefs;


  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((value) {
      sPrefs = value;
      initializeApp();
    });

  }

  initializeApp() {
    bool? isLoggedIn;
    if (sPrefs != null) isLoggedIn = sPrefs!.getBool('isLoggedIn');
    if (isLoggedIn != null && isLoggedIn) {
      Navigator.of(context).pushReplacementNamed('/');
    }

    if (isLoggedIn == null || ( !isLoggedIn)) {
      Navigator.of(context).pushReplacementNamed('/Login');
    }
    Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Welcome'),
      ),
    );
  }

  @override
  void dispose() {
    sPrefs!.clear();
    super.dispose();
  }
}
