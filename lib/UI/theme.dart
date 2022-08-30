import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

const Color bluishClr = Color(0xFF4e5ae8);
const Color darkgreyClr = Color(0xFF121212);
const PrimaryClr = bluishClr;
const Color pinkClr = Color(0xFFff4667);
const Color darkGreyClr = Color(0xFF121212);
const Color yellowClr = Color(0xFFFF8746);


class Themes {

  static final light = ThemeData(
    backgroundColor: Colors.white,
    primaryColor: Colors.blue,
    brightness: Brightness.light,
  );

  static final dark = ThemeData(
    backgroundColor: darkgreyClr,
    primaryColor: Colors.grey,
    brightness: Brightness.dark,
  );



}
TextStyle get subHeadingStyle{
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 24,
      color: Get.isDarkMode? Colors.grey[400]:Colors.grey
    ),
  );
}

TextStyle get HeadingStyle{
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 30,
    ),
  );
}
TextStyle get titleStyle{
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 16,
      color: Get.isDarkMode?Colors.white:Colors.grey,
    ),
  );
}
TextStyle get subTitleStyle{
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 14,
      color: Get.isDarkMode?Colors.grey[100]:Colors.grey[700],
    ),
  );
}