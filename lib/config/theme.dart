import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AtentoTheme {
  static ThemeData get theme => ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        primaryColor: const Color(0xFF190E38),
        scaffoldBackgroundColor: const Color(0xFF190E38),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF190E38),
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
        ),
        iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
            foregroundColor: const Color(0xFF130F26),
            backgroundColor: Colors.white,
            iconSize: 30,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            disabledBackgroundColor: Colors.grey.shade700,
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF130F26)),
        drawerTheme: const DrawerThemeData(
          backgroundColor: Color(0xFF92A3FD),
          elevation: 0,
        ),
        textTheme: TextTheme(
          displayLarge: GoogleFonts.montserrat(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 55,
          ),
          displayMedium: GoogleFonts.montserrat(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 30,
          ),
          displaySmall: GoogleFonts.montserrat(
            color: Colors.white,
            fontWeight: FontWeight.w300,
            fontSize: 20,
          ),
          bodyLarge: GoogleFonts.montserrat(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          bodyMedium: GoogleFonts.montserrat(
            color: Color(0xFF7B6F72),
            fontSize: 14,
          ),
          labelLarge: GoogleFonts.montserrat(
            color: Colors.black,
            fontWeight: FontWeight.w800,
            fontSize: 50,
          ),
          labelMedium: GoogleFonts.montserrat(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 36,
          ),
          labelSmall: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF92A3FD),
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 15,
            ),
          ),
        ),
      );
}
