import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData buildThemeData(BuildContext context) {
  return ThemeData(
    primaryTextTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.black,
          displayColor: Colors.black,
        ),
    primaryIconTheme:
        Theme.of(context).primaryIconTheme.copyWith(color: Colors.black),
    accentColor: Color(0xFFeeeeee),
    textTheme: GoogleFonts.ubuntuTextTheme(
      Theme.of(context).textTheme.copyWith(
          headline6: Theme.of(context).textTheme.headline6.copyWith(
              fontSize: 20,
              wordSpacing: 3,
              height: 1.3,
              color: Color(0xFF221f20)),
          subtitle1: Theme.of(context).textTheme.subtitle1.copyWith(
                fontSize: 17,
                color: Color(0xFF6b6e78),
                wordSpacing: 1.5,
              ),
          bodyText1: Theme.of(context).textTheme.bodyText1.copyWith(
                fontSize: 15,
                color: Colors.black,
              ),
          headline5: Theme.of(context)
              .textTheme
              .headline5
              .copyWith(color: Colors.black)),
    ),
    primaryColor: Color(0xFF397e2f),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      color: Colors.white,
    ),
  );
}
