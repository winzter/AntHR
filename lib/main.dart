import 'package:flutter/foundation.dart';
import 'package:anthr/injection.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/features/splash/splash.page.dart';
import 'injection_container.dart' as di;
import 'package:intl/date_symbol_data_local.dart';

Future main() async {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('assets/google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  WidgetsFlutterBinding.ensureInitialized();
  Intl.defaultLocale = 'th';
  await initializeDateFormatting();
  await di.init();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) => runApp(const Injection(router: MyApp())));
  }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'AntHR',
      debugShowCheckedModeBanner: false,
      home: const SplashPage(),
      theme:ThemeData(
        useMaterial3: false,
        fontFamily: 'kanit',
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        dialogTheme: const DialogTheme(
            backgroundColor: Colors.white
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        tabBarTheme: const TabBarTheme(
            dividerColor: Colors.transparent
        ),
      ),
    );
  }
}