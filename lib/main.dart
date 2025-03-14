import 'dart:io';

import 'package:cinema_hub/bloc/bloc/test_bloc.dart';
import 'package:cinema_hub/themes/theme_main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cinema_hub/app.dart';
import 'package:cinema_hub/constants/routes.dart';
import 'package:cinema_hub/helper/object_box.dart';
import 'package:cinema_hub/models/user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:uni_links/uni_links.dart';
import 'dart:async';

late ObjectBox objectBox;
GlobalKey<MyAppState> keyApp = GlobalKey<MyAppState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  objectBox = await ObjectBox.init();
  UserData.init();

  _hideStatusBar();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  StreamSubscription? _sub;
  String? userId;
  String? auditorium;
  bool? isScanWhileRunning;

  @override
  void initState() {
    super.initState();
    _initDeepLink();
  }

  void _initDeepLink() async {
    // Handle app launch from deep link
    Uri? initialUri = await getInitialUri();

    if (initialUri == null) return;

    print(1);
    _handleDeepLink(initialUri);

    // Listen for deep links while app is running
    _sub = uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        print(2);
        _handleDeepLink(uri, isScanWhileRunning: true);
      }
    });
  }

  void _handleDeepLink(Uri uri, {bool isScanWhileRunning = false}) {
    setState(() {
      userId = uri.queryParameters['user_id'];
      auditorium = uri.queryParameters['auditorium'];
      this.isScanWhileRunning = isScanWhileRunning;
    });

    // print("Deep link received: $uri");
    // print("User ID: $userId");
    // print("Auditorium: $auditorium");
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TestBloc>(
          create: (context) => TestBloc(),
        )
      ],
      child: ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, child) {
          final themeProvider = Provider.of<ThemeProvider>(context);

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: const App(),
            routes: {
              routeHome: (context) => const App(),
            },
            themeMode: themeProvider.themeMode,
            theme: Themes.getThemeLight(),
            darkTheme: Themes.getThemeDark(),
          );
        },
      ),
    );
  }
}

void _hideStatusBar() {
  SystemChrome.setEnabledSystemUIMode(
    Platform.isIOS ? SystemUiMode.immersive : SystemUiMode.immersive,
    overlays: [SystemUiOverlay.top],
  );
}
