import 'package:cinema_hub/models/user_data.dart';
import 'package:cinema_hub/utils/app_colors.dart';
import 'package:flutter/material.dart';
import '../enums/theme_type.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = userData.isDarkMode ? ThemeMode.dark : ThemeMode.light;
  // ThemeMode.system;

  bool get isDarkMode => userData.isDarkMode;

  void setTheme({
    ThemeType themeType = ThemeType.darkMode,
    required bool isOn,
  }) {
    // dark/light mode
    if (themeType == ThemeType.darkMode) {
      themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
      notifyListeners();
    }
    // admin/regular user mode
    else if (themeType == ThemeType.adminMode) {
      notifyListeners();
    }
  }
}

class Themes {
  // ===========================================================================
  //                            * Dark Theme
  // ===========================================================================

  static ThemeData getThemeDark() => ThemeData.dark().copyWith(
        // textTheme: const TextTheme(
        //   displayLarge: TextStyle(fontSize: 52, fontWeight: FontWeight.bold),
        //   titleLarge: TextStyle(fontSize: 36, fontStyle: FontStyle.italic),
        //   bodyMedium: TextStyle(fontSize: 14, fontFamily: 'Hind'),
        // ),
        brightness: Brightness.dark,
        scaffoldBackgroundColor: ThemeDark.colorPrimaryDark,
        colorScheme: const ColorScheme.dark(),
        primaryColor: const Color(0xFF1B1B1B),
        primaryColorDark: ThemeDark.colorPrimaryDark,
        primaryColorLight: ThemeDark.colorPrimaryLight,
        primaryTextTheme: Typography().white,
        appBarTheme: AppBarTheme(
          color: ThemeDark.colorAppBar,
          surfaceTintColor: Colors.transparent,
          titleTextStyle: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          centerTitle: true,
        ),
        bottomAppBarTheme:
            BottomAppBarTheme(color: ThemeDark.colorPrimaryLight),
        textTheme: Typography().white,
        iconTheme: const IconThemeData(color: Colors.white),
        buttonTheme: ButtonThemeData(
          buttonColor: AppColors.colorDeepBlue,
          shape:
              BeveledRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textTheme: ButtonTextTheme.primary,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: const WidgetStatePropertyAll(Colors.white),
            overlayColor: WidgetStatePropertyAll(AppColors.colorButtonSplash),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: const WidgetStatePropertyAll(EdgeInsets.zero),
            visualDensity: VisualDensity.compact,
          ),
        ),
        // text field character indicator
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.grey.shade500,
        ),
        inputDecorationTheme: InputDecorationTheme(
          isDense: true,
          filled: true,
          fillColor: ThemeDark.colorPrimaryLight,
          suffixIconColor: Colors.white,
          hintStyle: TextStyle(
            color: ThemeDark.colorPrimaryLight.withAlpha(50),
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          shape: const CircleBorder(),
          foregroundColor: Colors.white,
          backgroundColor: AppColors.colorDeepBlue,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            backgroundColor: WidgetStatePropertyAll(AppColors.colorDeepBlue),
            foregroundColor: const WidgetStatePropertyAll(Colors.white),
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: ThemeDark.colorAppBar,
          selectedItemColor: Colors.white,
          unselectedItemColor: ThemeDark.colorIconsUnselected,
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: ThemeDark.colorAppBar,
          contentTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          elevation: 1,
        ),
        bottomSheetTheme:
            const BottomSheetThemeData(backgroundColor: Colors.transparent),
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: AppColors.colorDeepBlue,
        ),
        tabBarTheme: TabBarTheme(
          labelStyle:
              const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
          labelColor: AppColors.colorThemeBlackWhite,
          overlayColor: const WidgetStatePropertyAll(Colors.transparent),
          dividerColor: Colors.transparent,
          indicatorSize: TabBarIndicatorSize.tab,
        ),
        dividerTheme: DividerThemeData(
          color: AppColors.colorThemeBlackWhite.withAlpha(25),
        ),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        expansionTileTheme: ExpansionTileThemeData(
          tilePadding: const EdgeInsets.symmetric(horizontal: 10),
          childrenPadding: EdgeInsets.zero,
          expandedAlignment: Alignment.topCenter,
          iconColor: AppColors.colorIcons,
        ),
      );

  // ===========================================================================
  //                            * Light Theme
  // ===========================================================================

  static ThemeData getThemeLight() => ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: ThemeLight.colorPrimaryDark,
        primaryColor: const Color.fromARGB(255, 233, 233, 238),
        primaryColorDark: ThemeLight.colorPrimaryDark,
        primaryColorLight: ThemeLight.colorPrimaryLight,
        primaryTextTheme: Typography().black,
        textTheme: Typography().black,
        colorScheme: const ColorScheme.light(),
        appBarTheme: AppBarTheme(
          color: ThemeLight.colorAppBar,
          surfaceTintColor: Colors.transparent,
          elevation: 1,
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(
            color: ThemeLight.colorIcons,
          ),
          centerTitle: true,
        ),
        bottomAppBarTheme:
            BottomAppBarTheme(color: ThemeLight.colorPrimaryLight),
        iconTheme: IconThemeData(color: ThemeLight.colorIcons),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            backgroundColor: const WidgetStatePropertyAll(Color(0XFF007bff)),
            foregroundColor: const WidgetStatePropertyAll(Colors.white),
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          shape: const CircleBorder(),
          foregroundColor: Colors.white,
          backgroundColor: AppColors.colorBlue,
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: const WidgetStatePropertyAll(Colors.black),
            overlayColor: WidgetStatePropertyAll(AppColors.colorButtonSplash),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: const WidgetStatePropertyAll(EdgeInsets.zero),
            visualDensity: VisualDensity.compact,
          ),
        ),
        iconButtonTheme: const IconButtonThemeData(
          style: ButtonStyle(
            visualDensity: VisualDensity.compact,
            padding: WidgetStatePropertyAll(EdgeInsets.zero),
          ),
        ),
        textSelectionTheme:
            const TextSelectionThemeData(cursorColor: Colors.black),

        // text field icon
        inputDecorationTheme: InputDecorationTheme(
          isDense: true,
          suffixIconColor: Colors.black,
          hintStyle: TextStyle(
            color: ThemeLight.colorPrimaryDark.withAlpha(55),
          ),
          contentPadding: EdgeInsets.zero,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: ThemeLight.colorAppBar,
          selectedItemColor: ThemeLight.colorIcons,
          unselectedItemColor: ThemeLight.colorIconsUnselected,
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: ThemeLight.colorAppBar,
          contentTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          elevation: 1,
        ),
        bottomSheetTheme:
            const BottomSheetThemeData(backgroundColor: Colors.transparent),
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: AppColors.colorBlue,
        ),
        tabBarTheme: TabBarTheme(
          labelStyle:
              const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
          labelColor: AppColors.colorThemeBlackWhite,
          overlayColor: const WidgetStatePropertyAll(Colors.transparent),
          dividerColor: Colors.transparent,
          indicatorSize: TabBarIndicatorSize.tab,
        ),
      );
}
