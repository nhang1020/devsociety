import 'package:devsociety/firebase_options.dart';
import 'package:devsociety/provider/LocaleProvider.dart';
import 'package:devsociety/provider/PostProvider.dart';
import 'package:devsociety/provider/ThemeProvider.dart';
import 'package:devsociety/provider/UserProvider.dart';
import 'package:devsociety/views/screens/splash/splash_screen.dart';
import 'package:devsociety/views/utils/variable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ChangeNotifierProvider(
    create: (context) => LocaleProvider(),
    builder: (context, child) => ChangeNotifierProvider(
      create: (context) => UserProvider(),
      builder: (context, child) => ChangeNotifierProvider(
        create: (context) => PostProvider(),
        builder: (context, child) => MyApp(),
      ),
    ),
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
              cardTheme: CardTheme(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 0,
              ),
            ),
            theme: ThemeData(
              colorScheme: ColorScheme.light(primary: myColor),
              useMaterial3: true,
              shadowColor: Colors.black12,
              cardTheme: CardTheme(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 0,
              ),
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
            home: SplashScreen(),
          );
        },
      );
}
