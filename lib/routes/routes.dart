import 'package:flutter/material.dart';

import 'package:fyp_lms/ui/home/home_screen.dart';
import 'package:fyp_lms/ui/intro_screen.dart';
import 'package:fyp_lms/ui/splash_screen.dart';

Map<String, Widget Function(BuildContext)> routesName = {
  '/SplashScreen': (context) => const SplashScreen(),

  '/': (context) => const HomeScreen(),
  '/Login': (context) => const IntroScreen(),

};