import 'package:flutter/material.dart';

import 'color_schemes.g.dart';

class AppTheme {
  /// Light mode theme data.
  static var light = ThemeData(
    colorScheme: lightColorScheme,

    // Global Style.
    checkboxTheme: ThemeData.light().checkboxTheme.copyWith(
          fillColor: MaterialStateProperty.all(lightColorScheme.primary),
        ),
    // textTheme: GoogleFonts.promptTextTheme(ThemeData.light().textTheme),
  );

  /// Dark mode theme data.
  static var dark = ThemeData(
    colorScheme: darkColorScheme,

    // Global Style.
    checkboxTheme: ThemeData.dark().checkboxTheme.copyWith(
          fillColor: MaterialStateProperty.all(darkColorScheme.primary),
        ),
    // textTheme: GoogleFonts.promptTextTheme(ThemeData.dark().textTheme),
  );
}
