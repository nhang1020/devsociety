import 'package:devsociety/provider/LocaleProvider.dart';
import 'package:devsociety/provider/ThemeProvider.dart';
import 'package:devsociety/views/screens/splash/splash_screen.dart';
import 'package:devsociety/views/utils/variable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async{
  
  runApp(ChangeNotifierProvider(
    create: (context) => LocaleProvider(),
    builder: (context, child) => MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => ThemeProvider(true, 0),
        builder: (context, child) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          final languageProvider = Provider.of<LocaleProvider>(context);
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            darkTheme: ThemeData(
              useMaterial3: true,
              scaffoldBackgroundColor: Color(0xff1A172C),
              canvasColor: Color(0xff1A172C),
              colorScheme: ColorScheme.dark(
                primary: myColor,
              ),
              shadowColor: Colors.black38,
            ),
            themeMode: themeProvider.themeMode,
            locale: Locale(languageProvider.locale),
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              Locale('en'),
              Locale('vi'),
            ],
            theme: ThemeData(
              colorScheme: ColorScheme.light(primary: myColor),
              useMaterial3: true,
              shadowColor: Colors.black12,
            ),
            home: SplashScreen(),
          );
        },
      );
}
