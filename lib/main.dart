import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fyp_lms/ui/intro_screen.dart';
import 'package:nb_utils/nb_utils.dart';

import 'routes/routes.dart';
import 'ui/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initialize();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const HomeScreen());
}

class StarterPage extends StatefulWidget {
  const StarterPage({Key? key}) : super(key: key);

  @override
  State<StarterPage> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<StarterPage> {
  SharedPreferences? sPref;


  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((value) => sPref = value);
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //use sharedPreferences to identify
      home: sPref?.getBool('isLogging') != null ? const HomeScreen() : const IntroScreen(),
      initialRoute: '/',
      routes: routesName,
    );
  }

  @override
  void dispose() {
    sPref!.clear();
    super.dispose();
  }
}
