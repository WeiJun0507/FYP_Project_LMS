import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GeneralUtil {

  static setSystemStyle(){
    if(Platform.isAndroid){
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.black, // status bar color
        statusBarBrightness: Brightness.light,//status bar brigtness
        statusBarIconBrightness:Brightness.light , //status barIcon Brightness
        systemNavigationBarColor: Colors.black, // navigation bar color
        systemNavigationBarDividerColor: Colors.white,//Navigation bar divider color
        systemNavigationBarIconBrightness: Brightness.light, //navigation bar icon
      ));
    }
  }

  Color getTextColor(Color color) {
    return color.computeLuminance() > 0.5
        ? Colors.black
        : Colors.white;
  }

  String getShortName(String? name){
    String shortname = '';
    if(name != null) {
      List<String> names = name.split(' ');
      if (names.length > 1) {
        shortname = (names[0].isNotEmpty ? names[0].substring(0, 1) : '') + (names[1].isNotEmpty ? names[1].substring(0, 1) : '');
      }else if(names.length == 1){
        shortname = (names[0].isNotEmpty ? names[0].substring(0, 1) : '');
      }else {
        shortname = '';
      }
    }

    return shortname.replaceAll('&', '');
  }



}