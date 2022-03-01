import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fyp_lms/ui/intro_screen.dart';
import 'package:fyp_lms/ui/splash_screen.dart';
import 'package:nb_utils/nb_utils.dart';

import 'routes/routes.dart';
import 'ui/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initialize();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const StarterPage());
}

class StarterPage extends StatelessWidget {
  const StarterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //use sharedPreferences to identify
      initialRoute: '/SplashScreen',
      routes: routesName,
    );
  }
}

