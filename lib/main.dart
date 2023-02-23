import 'package:flutter/material.dart';
import 'package:midterm_homestayraya/view/screens/splashscreen.dart';
import 'package:provider/provider.dart';
import 'view/themes/theme_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ThemeModel(),
        child: Consumer(builder: (context, ThemeModel themeNotifier, child) {
          // ThemeData(
          //   textTheme: GoogleFonts.ubuntuTextTheme(
          //       Theme.of(context).textTheme.apply()),
          //   primarySwatch: Colors.indigo,
          // );
          return MaterialApp(
              theme:
                  themeNotifier.isDark ? ThemeData.dark() : ThemeData.light(),

              // darkTheme: ThemeData.dark(),
              // themeMode: ThemeMode.system,
              title: 'Homestay Raya',
              home: const SplashScreen());
        }));
  }
}
