import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Themes {
  static Color getTeamOneColor() => Color.fromRGBO(35, 175, 255, 1);

  static Color getTeamTwoColor() => Color.fromRGBO(245, 25, 0, 1);

  static Color getSelectedPlayerColor() => Color.fromRGBO(50, 255, 15, 1);

  static Color getPrimaryColor() => Color.fromRGBO(30, 35, 125, 1);

  static Color getAccentColor() => Color.fromRGBO(255, 170, 50, 1);

  static ThemeData getLightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: getPrimaryColor(),
      accentColor: getPrimaryColor(),
      indicatorColor: getPrimaryColor(),
      dividerColor: getPrimaryColor(),
      appBarTheme: AppBarTheme(
        color: Colors.transparent,
        centerTitle: true,
        elevation: 1000.0,
        iconTheme: IconThemeData(
          color: Colors.black,
          size: 24,
        ),
        actionsIconTheme: IconThemeData(
          color: Colors.black,
          size: 24,
        ),
        textTheme: TextTheme(
          headline6: GoogleFonts.getFont(
            'Oxygen',
            color: Colors.black,
            fontSize: 18,
          ),
        ),
      ),
      tabBarTheme: TabBarTheme(
        labelColor: Colors.black,
        labelStyle: GoogleFonts.getFont(
          'Oxygen',
          fontSize: 16,
        ),
        unselectedLabelStyle: GoogleFonts.getFont(
          'Oxygen',
          fontSize: 14,
        ),
      ),
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              12,
            ),
          ),
        ),
        titleTextStyle: GoogleFonts.getFont(
          'Oxygen',
          fontSize: 16,
          color: Colors.black,
        ),
      ),
      textTheme: TextTheme(
        subtitle1: GoogleFonts.getFont(
          'Oxygen',
          fontSize: 16,
        ),
        bodyText1: GoogleFonts.getFont(
          'Oxygen',
          fontSize: 16,
        ),
        bodyText2: GoogleFonts.getFont(
          'Oxygen',
          fontSize: 16,
        ),
      ),
      buttonTheme: ButtonThemeData(
        splashColor: getPrimaryColor(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              14,
            ),
          ),
        ),
      ),
    );
  }

  static ThemeData getDarkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: getPrimaryColor(),
      accentColor: getAccentColor(),
      indicatorColor: getAccentColor(),
      dividerColor: getAccentColor(),
      appBarTheme: AppBarTheme(
        color: Colors.transparent,
        centerTitle: true,
        elevation: 1000.0,
        iconTheme: IconThemeData(
          color: Colors.white,
          size: 24,
        ),
        actionsIconTheme: IconThemeData(
          color: Colors.white,
          size: 24,
        ),
        textTheme: TextTheme(
          headline6: GoogleFonts.getFont(
            'Oxygen',
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
      tabBarTheme: TabBarTheme(
        labelColor: Colors.white,
        labelStyle: GoogleFonts.getFont(
          'Oxygen',
          fontSize: 16,
        ),
        unselectedLabelStyle: GoogleFonts.getFont(
          'Oxygen',
          fontSize: 14,
        ),
      ),
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              12,
            ),
          ),
        ),
        titleTextStyle: GoogleFonts.getFont(
          'Oxygen',
          fontSize: 16,
          color: Colors.white,
        ),
      ),
      textTheme: TextTheme(
        subtitle1: GoogleFonts.getFont(
          'Oxygen',
          fontSize: 16,
        ),
        bodyText1: GoogleFonts.getFont(
          'Oxygen',
          fontSize: 16,
        ),
        bodyText2: GoogleFonts.getFont(
          'Oxygen',
          fontSize: 16,
        ),
      ),
      buttonTheme: ButtonThemeData(
        splashColor: getPrimaryColor(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              14,
            ),
          ),
        ),
      ),
    );
  }

  static ThemeData getAmoledTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.black,
      primaryColor: getPrimaryColor(),
      accentColor: getAccentColor(),
      indicatorColor: getAccentColor(),
      dividerColor: getAccentColor(),
      appBarTheme: AppBarTheme(
        color: Colors.transparent,
        centerTitle: true,
        elevation: 1000.0,
        iconTheme: IconThemeData(
          color: Colors.white,
          size: 24,
        ),
        actionsIconTheme: IconThemeData(
          color: Colors.white,
          size: 24,
        ),
        textTheme: TextTheme(
          headline6: GoogleFonts.getFont(
            'Oxygen',
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
      tabBarTheme: TabBarTheme(
        labelColor: Colors.white,
        labelStyle: GoogleFonts.getFont(
          'Oxygen',
          fontSize: 16,
        ),
        unselectedLabelStyle: GoogleFonts.getFont(
          'Oxygen',
          fontSize: 14,
        ),
      ),
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              12,
            ),
          ),
        ),
        titleTextStyle: GoogleFonts.getFont(
          'Oxygen',
          fontSize: 16,
          color: Colors.white,
        ),
      ),
      textTheme: TextTheme(
        subtitle1: GoogleFonts.getFont(
          'Oxygen',
          fontSize: 16,
        ),
        bodyText1: GoogleFonts.getFont(
          'Oxygen',
          fontSize: 16,
        ),
        bodyText2: GoogleFonts.getFont(
          'Oxygen',
          fontSize: 16,
        ),
      ),
      buttonTheme: ButtonThemeData(
        splashColor: getPrimaryColor(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              14,
            ),
          ),
        ),
      ),
    );
  }
}
