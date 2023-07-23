import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color primaryColor = Color(0xFFF6F8FA);
Color darkPrimaryColor = Color(0xFF191720);
Color whiteBackground = Color.fromARGB(255, 230, 228, 237);
Color secondaryColor = Color(0xFFF3EE76);
Color lightBlue = Color(0xFF79DBFF);
Color greyBg = Color(0xFFB8B8B8);

final TextTheme myTextTheme = TextTheme(
  displayLarge: GoogleFonts.poppins(
      fontSize: 45,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.25,
      color: primaryColor),
  displayMedium: GoogleFonts.poppins(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.25,
      color: darkPrimaryColor),
  displaySmall: GoogleFonts.poppins(
      fontSize: 28, fontWeight: FontWeight.bold, color: darkPrimaryColor),
  headlineLarge: GoogleFonts.poppins(
      fontSize: 22, fontWeight: FontWeight.w600, color: primaryColor),
  headlineMedium: GoogleFonts.poppins(
      fontSize: 20, fontWeight: FontWeight.w600, color: lightBlue),
  headlineSmall: GoogleFonts.rubik(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: darkPrimaryColor,
      letterSpacing: 0.15),
  bodyLarge: GoogleFonts.poppins(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.15,
      color: darkPrimaryColor),
  bodyMedium: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.1,
      color: darkPrimaryColor),
  bodySmall: GoogleFonts.poppins(
      fontSize: 13,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.1,
      color: darkPrimaryColor),
  labelLarge: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: darkPrimaryColor,
      letterSpacing: 0.5),
  labelMedium: GoogleFonts.poppins(
      fontSize: 13,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: darkPrimaryColor),
  labelSmall: GoogleFonts.poppins(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: darkPrimaryColor),
);

final themeData = ThemeData(
  textTheme: myTextTheme,
  primaryColor: primaryColor,
  colorScheme: ColorScheme.fromSwatch().copyWith(secondary: secondaryColor),
  scaffoldBackgroundColor: Colors.white,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 16.0,
    showUnselectedLabels: true,
    unselectedItemColor: greyBg,
    selectedItemColor: whiteBackground,
    type: BottomNavigationBarType.fixed,
    backgroundColor: secondaryColor,
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: primaryColor,

    // enabledBorder: OutlineInputBorder(
    //   borderSide: BorderSide(width: 2.0, color: greyOutline),
    //   borderRadius: BorderRadius.circular(12),
    // ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 2.0, color: Colors.red),
      borderRadius: BorderRadius.circular(12),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: BorderSide(color: greyBg, width: 2.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: BorderSide(color: darkPrimaryColor, width: 2.0),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: BorderSide(color: Colors.red, width: 2.0),
    ),
  ),
);
