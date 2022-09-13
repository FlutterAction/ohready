import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secure_hops/Provider/MyProvider.dart';
import 'package:secure_hops/Screens/Home%20Page/Empty%20Home/EmptyHome.dart';
import 'package:secure_hops/Screens/Onboarding/OnBoarding.dart';
import 'package:secure_hops/Components/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:secure_hops/Screens/Home%20Page/home.dart';
import 'app_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MyProvider provider = MyProvider();
  await provider.getFirstTime();
  await provider.getLoginResponse();
  await provider.fetchLocale();
  GestureBinding.instance!.resamplingEnabled = true;
  runApp(MyApp(
    provider: provider,
  ));
}

class MyApp extends StatefulWidget {
  final MyProvider? provider;

  MyApp({this.provider});
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyProvider>(
      create: (_) => widget.provider!,
      child: Consumer<MyProvider>(builder: (context, provider, child) {
        return MaterialApp(
          locale: provider.appLocale,
          debugShowCheckedModeBanner: false,
          title: 'Oh Ready',
          theme: ThemeData(
            
            fontFamily: "PopinRegular",
            primarySwatch: primaryColor,
          ),
          home: getHomePage(provider),
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('en', ''),
            Locale('es', ''),
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            // Check if the current device locale is supported
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale!.languageCode &&
                  supportedLocale.countryCode == locale.countryCode) {
                return supportedLocale;
              }
            }
            // If the locale of the device is not supported, use the first one
            // from the list (English, in this case).
            return supportedLocales.first;
          },
        );
      }),
    );
  }

  Widget getHomePage(MyProvider provider) {
    print(provider.isFirstTime);
    if (provider.loginResponse != null) {
      print(1);
      return MyHomePage();
    }
    if (provider.isFirstTime == true) {
      print(2);
      return AppHomePage();
    } else
      print(3);
    return Onbording();
  }
}
