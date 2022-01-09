import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:repainter/class/MainState.dart';

import 'constant.dart';
import 'pages/mainpage.dart';
import 'pages/start.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put<Logger>(Logger(
    printer: PrettyPrinter(),
  ));
  Get.put<MainState>(MainState());
  await GetStorage().initStorage;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: lightTheme(),
      darkTheme: darkTheme(),
      themeMode: ThemeMode.system,
      locale: locale,
      supportedLocales: const [
        locale,
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      title: 'Repainter',
      initialRoute: '/start',
      getPages: [
        GetPage<GetPage>(
          name: '/main',
          page: () =>  MainPage(),
        ),
        GetPage<GetPage>(
          name: '/start',
          page: () => StartPage(),
        )
      ],
    );
  }
}
