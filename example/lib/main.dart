import 'package:example/screens/data_table2_fixed_nm.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'nav_helper.dart';
import 'screens/async_paginated_data_table2.dart';
import 'screens/data_table.dart';
import 'screens/data_table2.dart';
import 'screens/data_table2_rounded.dart';
import 'screens/data_table2_scrollup.dart';
import 'screens/data_table2_simple.dart';
import 'screens/data_table2_tests.dart';
import 'screens/paginated_data_table.dart';
import 'screens/paginated_data_table2.dart';

void main() {
  runApp(MyApp());
  // Add import
  // import 'package:data_table_2/data_table_2.dart';
  // and uncomment below line to remove widgets' logs
  //dataTableShowLogs = false;
}

const String initialRoute = '/datatable2';

Scaffold _getScaffold(BuildContext context, Widget body,
    [List<String>? options]) {
  var defaultOption = getCurrentRouteOption(context);
  if (defaultOption.isEmpty && options != null && options.isNotEmpty) {
    defaultOption = options[0];
  }
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.grey[200],
      shadowColor: Colors.transparent,
      automaticallyImplyLeading: false,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
            padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
            color: Colors.grey[850],
            //screen selection
            child: DropdownButton<String>(
              icon: const Icon(Icons.arrow_forward),
              dropdownColor: Colors.grey[800],
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.white),
              value: _getCurrentRoute(context),
              onChanged: (v) {
                Navigator.of(context).pushNamed(v!);
              },
              items: const [
                DropdownMenuItem(
                  value: '/datatable2',
                  child: Text('DataTable2'),
                ),
                DropdownMenuItem(
                  value: '/datatable2simple',
                  child: Text('Simple'),
                ),
                DropdownMenuItem(
                  value: '/datatable2scrollup',
                  child: Text('Scroll-up/Scroll-left'),
                ),
                DropdownMenuItem(
                  value: '/datatable2fixedmn',
                  child: Text('Fixed Rows/Cols'),
                ),
                DropdownMenuItem(
                  value: '/paginated2',
                  child: Text('PaginatedDataTable2'),
                ),
                DropdownMenuItem(
                  value: '/asyncpaginated2',
                  child: Text('AsyncPaginatedDataTable2'),
                ),
                DropdownMenuItem(
                  value: '/datatable',
                  child: Text('DataTable'),
                ),
                DropdownMenuItem(
                  value: '/paginated',
                  child: Text('PaginatedDataTable'),
                ),
                if (kDebugMode)
                  DropdownMenuItem(
                    value: '/datatable2tests',
                    child: Text('Unit Tests Preview'),
                  ),
              ],
            )),
        options != null && options.isNotEmpty
            ? Flexible(
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(12, 4, 0, 4),
                        child: DropdownButton<String>(
                            icon: const SizedBox(),
                            dropdownColor: Colors.grey[300],
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: Colors.black),
                            value: defaultOption,
                            onChanged: (v) {
                              var r = _getCurrentRoute(context);
                              Navigator.of(context).pushNamed(r, arguments: v);
                            },
                            items: options
                                .map<DropdownMenuItem<String>>(
                                    (v) => DropdownMenuItem<String>(
                                          value: v,
                                          child: Text(v),
                                        ))
                                .toList()))))
            : const SizedBox()
      ]),
    ),
    body: body,
  );
}

String _getCurrentRoute(BuildContext context) {
  return ModalRoute.of(context) != null &&
          ModalRoute.of(context)!.settings.name != null
      ? ModalRoute.of(context)!.settings.name!
      : initialRoute;
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      restorationScopeId: 'main',
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      initialRoute: initialRoute,

      routes: {
        '/datatable2': (context) {
          final currentRouteOption = getCurrentRouteOption(context);
          return _getScaffold(
              context,
              currentRouteOption == rounded
                  ? const DataTable2RoundedDemo()
                  : const DataTable2Demo(),
              getOptionsForRoute('/datatable2'));
        },
        '/datatable2simple': (context) =>
            _getScaffold(context, const DataTable2SimpleDemo()),
        '/datatable2scrollup': (context) =>
            _getScaffold(context, const DataTable2ScrollupDemo()),
        '/datatable2fixedmn': (context) => _getScaffold(
            context,
            const DataTable2FixedNMDemo(),
            getOptionsForRoute('/datatable2fixedmn')),
        '/paginated2': (context) => _getScaffold(context,
            const PaginatedDataTable2Demo(), getOptionsForRoute('/paginated2')),
        '/asyncpaginated2': (context) => _getScaffold(
            context,
            const AsyncPaginatedDataTable2Demo(),
            getOptionsForRoute('/asyncpaginated2')),
        '/datatable': (context) => _getScaffold(context, const DataTableDemo()),
        '/paginated': (context) =>
            _getScaffold(context, const PaginatedDataTableDemo()),
        '/datatable2tests': (context) =>
            _getScaffold(context, const DataTable2Tests()),
      },
      localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
      supportedLocales: const [
        Locale('en', ''),
        Locale('be', ''),
        Locale('ru', ''),
        Locale('fr', ''),
        Locale('zh', ''),
      ],
      // change to see how PaginatedDataTable2 controls (e.g. Rows per page) get translated
      locale: const Locale('en', ''),
    );
  }
}

class AppTheme {
  static final lightTheme = ThemeData(
    useMaterial3: true,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.textFieldColor,
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: Colors.blue,
      secondary: AppColors.secondary,
      brightness: Brightness.light,
    ),
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    dividerColor: Colors.grey,
    dividerTheme: const DividerThemeData(
      color: Colors.grey,
      thickness: .4,
      indent: 5,
      endIndent: 5,
    ),
    checkboxTheme: const CheckboxThemeData(
      checkColor: WidgetStatePropertyAll(Colors.white),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
      side: BorderSide(width: 1, color: AppColors.borderTextColor),
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 1, color: AppColors.borderTextColor),
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
    ),
    fontFamily: 'Montserrat',
    sliderTheme: SliderThemeData(overlayShape: SliderComponentShape.noOverlay),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        foregroundColor: AppColors.textColor,
        textStyle: const TextStyle(
          color: AppColors.textColor,
          fontFamily: 'Montserrat',
          fontSize: 12,
        ),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.borderTextColor,
          width: borderWidth,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.textFieldColor, width: 1.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.borderTextColor,
          width: borderWidth,
        ),
      ),
      hintStyle: TextStyle(
        fontStyle: FontStyle.italic,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.textHintColor,
      ),
      labelStyle: TextStyle(fontSize: 12),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        color: AppColors.textColor,
        fontWeight: FontWeight.normal,
        fontFamily: 'Montserrat',
        overflow: TextOverflow.ellipsis,
      ),
      headlineMedium: TextStyle(
        color: AppColors.textColor,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        fontFamily: 'Montserrat',
        overflow: TextOverflow.ellipsis,
      ),
      headlineSmall: TextStyle(
        color: AppColors.textColor,
        fontWeight: FontWeight.w600,
        fontFamily: 'Montserrat',
        overflow: TextOverflow.ellipsis,
      ),
      titleSmall: TextStyle(
        color: AppColors.textColor,
        fontFamily: 'Montserrat',
        fontSize: 12,
        overflow: TextOverflow.ellipsis,
      ),
      titleMedium: TextStyle(
        color: AppColors.textColor,
        fontFamily: 'Montserrat',
        fontSize: 12,
        overflow: TextOverflow.ellipsis,
      ),
      titleLarge: TextStyle(
        color: AppColors.textColor,
        fontFamily: 'Montserrat',
        fontSize: 16,
        overflow: TextOverflow.ellipsis,
      ),
      bodySmall: TextStyle(
        color: AppColors.textColor,
        fontFamily: 'Montserrat',
        fontSize: 10,
        overflow: TextOverflow.ellipsis,
      ),
      bodyMedium: TextStyle(
        color: AppColors.textColor,
        fontFamily: 'Montserrat',
        fontSize: 12,
        overflow: TextOverflow.ellipsis,
      ),
      bodyLarge: TextStyle(
        color: AppColors.textColor,
        fontFamily: 'Montserrat',
        fontSize: 12,
        overflow: TextOverflow.ellipsis,
      ),
      labelLarge: TextStyle(
        color: AppColors.textColor,
        fontWeight: FontWeight.normal,
        fontFamily: 'Montserrat',
        fontSize: 16,
        overflow: TextOverflow.ellipsis,
      ),
      labelMedium: TextStyle(
        color: AppColors.textColor,
        fontWeight: FontWeight.w500,
        fontFamily: 'Montserrat',
        fontSize: 14,
        overflow: TextOverflow.ellipsis,
      ),
      labelSmall: TextStyle(
        color: AppColors.textColor,
        fontWeight: FontWeight.w600,
        fontFamily: 'Montserrat',
        overflow: TextOverflow.ellipsis,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        textStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          fontFamily: 'Montserrat',
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        padding: const EdgeInsets.all(8.0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
    ),
    listTileTheme: const ListTileThemeData(
      titleTextStyle: TextStyle(
        fontSize: 14,
        color: AppColors.textColor,
        fontWeight: FontWeight.w500,
        fontFamily: 'Montserrat',
      ),
    ),
    snackBarTheme: const SnackBarThemeData(
      behavior: SnackBarBehavior.fixed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
    ),
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.textFieldColor,
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: Colors.blue,
      secondary: AppColors.secondary,
      brightness: Brightness.dark,
    ),
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.darkBackground,
    brightness: Brightness.dark,
    fontFamily: 'Montserrat',
    dividerColor: Colors.grey,
    dividerTheme: const DividerThemeData(
      color: Colors.grey,
      thickness: .4,
      indent: 5,
      endIndent: 5,
    ),
    checkboxTheme: const CheckboxThemeData(
      checkColor: WidgetStatePropertyAll(Colors.white),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
      side: BorderSide(width: 1, color: AppColors.borderTextColor),
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 1, color: AppColors.borderTextColor),
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
    ),
    sliderTheme: SliderThemeData(
      overlayShape: SliderComponentShape.noOverlay,
      activeTrackColor: const Color(0xffB7B7B7),
      inactiveTrackColor: Colors.grey.withValues(alpha: .3),
      thumbColor: const Color(0xffB7B7B7),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        foregroundColor: AppColors.textColor,
        textStyle: const TextStyle(
          color: AppColors.textColor,
          fontFamily: 'Montserrat',
          fontSize: 12,
        ),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.borderTextColor,
          width: borderWidth,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.textFieldColor, width: 1.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.borderTextColor,
          width: borderWidth,
        ),
      ),
      hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
      labelStyle: TextStyle(fontSize: 12, color: Colors.white),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.normal,
        fontFamily: 'Montserrat',
        overflow: TextOverflow.ellipsis,
      ),
      headlineMedium: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontFamily: 'Montserrat',
        fontSize: 20,
        overflow: TextOverflow.ellipsis,
      ),
      headlineSmall: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontFamily: 'Montserrat',
        overflow: TextOverflow.ellipsis,
      ),
      titleSmall: TextStyle(
        color: AppColors.textColor,
        fontFamily: 'Montserrat',
        fontSize: 12,
        overflow: TextOverflow.ellipsis,
      ),
      titleMedium: TextStyle(
        color: AppColors.textColor,
        fontFamily: 'Montserrat',
        fontSize: 12,
        overflow: TextOverflow.ellipsis,
      ),
      titleLarge: TextStyle(
        color: AppColors.textColor,
        fontFamily: 'Montserrat',
        fontSize: 16,
        overflow: TextOverflow.ellipsis,
      ),
      bodySmall: TextStyle(
        color: AppColors.textColor,
        fontFamily: 'Montserrat',
        fontSize: 10,
        overflow: TextOverflow.ellipsis,
      ),
      bodyMedium: TextStyle(
        color: AppColors.textColor,
        fontFamily: 'Montserrat',
        fontSize: 12,
        overflow: TextOverflow.ellipsis,
      ),
      bodyLarge: TextStyle(
        color: AppColors.textColor,
        fontFamily: 'Montserrat',
        fontSize: 12,
        overflow: TextOverflow.ellipsis,
      ),
      labelLarge: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.normal,
        fontFamily: 'Montserrat',
        fontSize: 16,
        overflow: TextOverflow.ellipsis,
      ),
      labelMedium: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontFamily: 'Montserrat',
        fontSize: 14,
        overflow: TextOverflow.ellipsis,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        textStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          fontFamily: 'Montserrat',
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
      ),
    ),
    listTileTheme: const ListTileThemeData(
      titleTextStyle: TextStyle(
        fontSize: 14,
        color: AppColors.textColor,
        fontWeight: FontWeight.w500,
        fontFamily: 'Montserrat',
      ),
    ),
  );
}

class AppColors {
  static const Color primary = Colors.white;
  static const Color secondary = Colors.white;

  static const Color background = Color(0xFFF5F7FA);
  static const Color darkBackground = Color(0xFF1F2023);
  static const Color highlight = Color(0xFF06A8A8);

  static const Color logoColor = Color(0xFFB48324);
  static const Color cardColor = Color(0xFFF8F8F8);

  static const Color iconColor = Color(0xFF123456);
  static const Color iconDefault = Color(0xFF525B75);
  static const Color iconHover = Color(0xFF1A6B99);
  static const Color iconActive = Color(0xFF08699E);

  static const Color drawerItemColor = Color(0xFF3C5280);
  static const Color drawerActiveColor = Color(0xFF2774C3);
  static const Color mosquittoColor = Color(0xFF3C5078);

  static const Color outlineBorder = Color(0xFFAFB1B6);
  static const Color borderColor = Color(0xFFC0C2CA);
  static const Color strokeColor = Color(0xFF707070);

  static const Color kpiColor = Color(0xFF0FCB40);
  static const Color kpiEditColor = Color(0xFFB95409);
  static const Color kpiEditColor2 = Color(0xFFF36F21);

  static const Color textColor = Color(0xFF324F6A);
  static const Color textLevel0 = Color(0xFF515151);
  static const Color textLevel1 = Color(0xFF5E5E5E);
  static const Color textLevel2 = Color(0xFF838485);
  static const Color textLevel3 = Color(0xFFACADAE);

  static const Color dialogProcess = Color(0xD1D1D1F2);
  static const Color producedColor = Color(0xFF072944);
  static const Color textHintColor = Color(0xFFA9A9A9);
  static const Color borderTextColor = Color(0xFF4B647C);
  static const Color disabledBorderTextColor = Color(0xFF9e9e9e);
  static const Color disabledBorderColor = Color(0xFFcecece);
  static const Color listviewHighLight = Color(0x1AF1F1F1);
  static const Color listviewHeader = Color(0xFFE7E7E7);
  static const Color listviewText = Color(0xFF324F6A);
  static const Color listviewDivider = Color(0xFFCCD0DE);
  static const Color multiPackerTextColor = Color(0xffFB7B7B);

  static const Color sapColor = Color(0xFFECECEC);
  static const Color masterDataColor = Color(0xFFECECEC);
  static const Color autoGenerateColor = Color(0xFFD1F0FF);
  static const Color formLinkingColor = Color(0xFFD1D1D1);
  static const Color fxColor = Color(0xFFD8FF7B);
  static const Color fxOutColor = Color(0xFFB8FFE6);
  static const Color manualInputColor = Color(0x80E4FFFA);
  static const Color nullDataColor = Color(0xFFE6E6E6);

  static const Color errorColor = Color(0xFFCC0534);
  static const Color warningColor = Color(0xFFDF7D0E);
  static const Color infoColor = Color(0xFF0A4DB1);

  static const Color lightGrey = Color(0x80B0C4DE);
  static const Color steelBlue = Color(0xFFB0C4DE);
  static const Color blueColor1 = Color(0xFF1387C0);
  static const Color blueColor2 = Color(0xFF1B6AA5);
  static const Color blueColor3 = Color(0xFF3B9CBC);
  static const Color blueColor4 = Color(0xFF41AAC7);
  static const Color blueColor5 = Color(0xFF008BCE);
  static const Color blueColor6 = Color(0xFF008BE8);
  static const Color blueColor7 = Color(0xFF002F59);
  static const Color dodgerBlue = Color(0xFF1E90FF);
  static const Color headerBlue = Color(0xFF0099D8);

  static const Color frozenBackground = Color(0x80EEEEEE);
  static const Color selectedFrozen = Color(0xFFF3F3F3);
  static const Color headerFrozen = Color(0xFFE7E7E7);
  static const Color activeTextButtonColor = Color(0xFF245BDB);

  static const Color blueAccentChart = Color(0xff419CF1);
  static const Color greenChart = Color(0xff4EDCA3);
  static const Color pinkChart = Color(0xffFB8DA0);
  static const Color orangeChart = Color(0xffF4A438);
  static const Color purpleChart = Color(0xff8E86ED);
  static const Color lightBlueChart = Color(0xffC2D0DF);
  static const Color blueChart = Color(0xff0F61AE);

  static const Color tableHeaderColor = Color(0xFF324F6A);
  static const Color tableHeaderColor2 = Color(0xFF537BA0);
  static const Color checkboxFilledColor = Color(0xFF868686);
  static const Color checkboxActiveColor = Color(0xFF868686);
  static const Color checkboxInactiveColor = Color(0xFFE0E0E0);
  static const Color checkboxActiveCreateColor = Color(0xFFF36F21);
  static const Color successColor = Color(0xFF43AD62);
  static const Color systemColor = Color(0xFFF5F7FA);
  static const Color textFieldColor = Color(0xFF0078D4);
  static const Color confirmColor = Color(0xFF009D57);
  static const Color cancelColor = Color(0xFFD32F4B);
  static const Color backgroundTank = Color(0xFFF1F1F1);
  static const Color backgroundTankSelected = Color(0xFFCEF3FF);
  static const Color backgroundAnimatedDonut = Color(0xFF299956);
  static const Color preparedColor = Color(0xFF009D57);
  static const Color preparingColor = Color(0xFFF47937);
  static const Color waitingColor = Color(0xFF324F6A);
  static const Color finishedColor = Color(0xFF009D57);
  static const Color waitingMixingColor = Color(0xFF324F6A);
  static const Color mixingColor = Color(0xFFF47937);
  static const Color checkboxColor2 = Color(0xFF3874FF);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color dropdownFillColorSelectDestination = Color(0xFFB3F1FF);
  static const Color verticalDividerColor = Color(0xFFCCD0DE);
}

const double minScale = 0.75;
const double maxScale = 2.0;

const double strokeWidth = 0.5;
const double borderWidth = 0.75;

const double headerLevelHeight = 48.0;
const double headerFooterHeight = 48.0;

const double drawerMenuHeight = 48;
const double drawerMainCollapse = 55;
const double drawerMainExpanded = 220;

const double cardCornerRadius = 8.0;

const double headerFontSize = 16.0;

const double listviewHeightHeader = 50.0;
const double listviewHeightRow = 50.0;
const double listviewCellDivider = 0.5;
const double listviewCellFixedColumBold = 0.8;
const double listviewCellPadding = 5.0;

const double inspectionWidthProd = 80;
const double inspectionWidthQc = 110;
const double iconSize = 26.0;
