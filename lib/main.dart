import 'package:firebase_core/firebase_core.dart';
import 'package:flower/provider/cart_provider.dart';
import 'package:flower/provider/lang_provider.dart';
import 'package:flower/shared_preferences/shared_preferences.dart';
import 'package:flower/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SharedPreferencesController().initSharedPreferences();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CartProvider>(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider<LangProviders>(
          create: (context) => LangProviders(),
        )
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) {
          return MaterialApp(
            home: const SplashScreen(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: const [
              Locale('ar'),
              Locale('en'),
            ],
            locale: Locale(Provider.of<LangProviders>(context).lang_),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
