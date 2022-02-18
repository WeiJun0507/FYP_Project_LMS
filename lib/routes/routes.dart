import 'package:flutter/material.dart';

import 'package:fyp_lms/ui/home/home_screen.dart';
import 'package:fyp_lms/ui/intro_screen.dart';

Map<String, Widget Function(BuildContext)> routesName = {
  '/': (context) => const HomeScreen(),
  '/login': (context) => const IntroScreen(),
};