import '../core.dart';

class AppTheme {
  // LIGHT COLORS
  static const Color creamBackground = Color(0xFFFAF3E0); // softer cream
  static const Color whiteSurface = Colors.white;

  static const Color primaryOrange = Color(0xFFFF7A3D);
  static const Color softOrange = Color(0xFFFFB38A);
  static const Color warmAccent = Color(0xFFFFD2B5);

  static const Color textDark = Color(0xFF2B2B2B);

  // DARK THEME (kept but slightly warmed to match brand)
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkText = Color(0xFFFFF1E6);

  // LIGHT THEME
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: creamBackground,

    colorScheme: const ColorScheme.light(
      primary: primaryOrange,
      secondary: softOrange,
      surface: whiteSurface,
      onSurface: textDark,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
    ),

    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: textDark),
      bodyLarge: TextStyle(color: textDark, fontSize: 16),
      titleLarge: TextStyle(
        color: textDark,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryOrange,
        foregroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
    ),
  );

  // DARK THEME
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkBackground,

    colorScheme: const ColorScheme.dark(
      primary: primaryOrange,
      secondary: softOrange,
      surface: darkSurface,
      onSurface: darkText,
      onPrimary: Colors.black,
      onSecondary: Colors.black,
    ),

    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: darkText),
      bodyLarge: TextStyle(color: darkText, fontSize: 16),
      titleLarge: TextStyle(
        color: darkText,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryOrange,
        foregroundColor: Colors.black,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
    ),
  );
}