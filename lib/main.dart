import 'package:event_planning/preference.dart';
import 'package:event_planning/providers/app%20language%20provider.dart';
import 'package:event_planning/providers/event%20list%20provider.dart';
import 'package:event_planning/providers/user%20provider.dart';
import 'package:event_planning/ui/auth/login/login%20screen.dart';
import 'package:event_planning/ui/auth/register/register%20screen.dart';
import 'package:event_planning/ui/home%20screen/home%20screen.dart';
import 'package:event_planning/ui/home%20screen/tabs/home/open%20event/event%20details.dart';
import 'package:event_planning/utils/app%20theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'providers/app theme provider.dart';
import 'ui/home screen/tabs/home/add event/add event.dart';
import 'ui/home screen/tabs/home/open event/edit event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await FirebaseFirestore.instance.disableNetwork();      //offline

  final isDarkMode = await SharedPreferenceClass.getTheme();
  final language = await SharedPreferenceClass.getLanguage();
  final themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => AppLanguageProvider(language)),
        ChangeNotifierProvider(
            create: (context) => AppThemeProvider(themeMode)),
        ChangeNotifierProvider(create: (context) => EventListProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: MyApp(
        language: language,
        themeMode: themeMode,
      )));
}

class MyApp extends StatelessWidget {
  String language;
  ThemeMode themeMode;

  MyApp({required this.language, required this.themeMode});

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LoginScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        AddEvent.routeName: (context) => AddEvent(),
        EventDetails.routeName: (context) => EventDetails(),
        EditEvent.routeName: (context) => EditEvent(),
      },
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.appTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(languageProvider.appLanguage),
    );
  }
}
