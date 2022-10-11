import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

const colorPrimary = Color(0xff001149); // primary color
const colorSecondary = Color.fromARGB(255, 0, 28, 119); // primary color

const colorDarkPink = Color(0xffE90C4D); //  secondary color
const colorWhite = Colors.white; //  secondary color
const colorBlack = Colors.black; //  secondary color

const colorPrimarylight = Color(0xffD7E0FF);
const colorError = Colors.red;

final lightThemeData = ThemeData(
  brightness: Brightness.light,
  primaryColor: colorPrimary,
  fontFamily: "Lato",
);

final appBarTheme = AppBarTheme(
    iconTheme: IconThemeData(color: colorPrimarylight),
    titleTextStyle: TextStyle(color: colorPrimarylight),
    actionsIconTheme: IconThemeData(color: colorPrimarylight),
    backgroundColor: colorPrimary);

final elevatedButtonThemeData = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    primary: colorDarkPink,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    // onPrimary: Colors.amber,
    // shape:MaterialStateProperty.all() ,
    // backgroundColor: MaterialStateProperty.all(colorDarkPink),
  ),
);

void p(String s) {
  return print(s);
}
