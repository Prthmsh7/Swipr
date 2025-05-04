import 'package:flutter/material.dart';

class AppTheme {
  // Colors
  static const Color primaryColor = Color(0xFF3366FF);
  static const Color accentColor = Color(0xFFFF6B6B);
  static const Color backgroundColor = Color(0xFFF8F9FA);
  static const Color cardColor = Colors.white;
  static const Color textColor = Color(0xFF212529);
  static const Color secondaryTextColor = Color(0xFF6C757D);
  static const Color borderColor = Color(0xFFDEE2E6);
  static const Color successColor = Color(0xFF28A745);
  static const Color errorColor = Color(0xFFDC3545);

  // Text Styles
  static const TextStyle headingStyle = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  static const TextStyle subheadingStyle = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
    color: textColor,
  );

  static const TextStyle bodyStyle = TextStyle(
    fontSize: 16.0,
    color: textColor,
  );

  static const TextStyle captionStyle = TextStyle(
    fontSize: 14.0,
    color: secondaryTextColor,
  );

  static const TextStyle priceStyle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    color: primaryColor,
  );

  // Button Style
  static final ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: primaryColor,
    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  );

  // Card Decoration
  static final BoxDecoration cardDecoration = BoxDecoration(
    color: cardColor,
    borderRadius: BorderRadius.circular(16.0),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        spreadRadius: 1,
        blurRadius: 10,
        offset: Offset(0, 5),
      ),
    ],
  );

  // ThemeData
  static ThemeData get themeData {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: cardColor,
        foregroundColor: textColor,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: primaryColor),
      ),
      textTheme: TextTheme(
        displayLarge: headingStyle,
        displayMedium: subheadingStyle,
        bodyLarge: bodyStyle,
        bodyMedium: captionStyle,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: primaryButtonStyle,
      ),
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        secondary: accentColor,
        error: errorColor,
      ),
    );
  }
} 