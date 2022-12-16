import 'package:firebase_core/firebase_core.dart';
import 'package:flower/provider/admin_mode.dart';
import 'package:flower/provider/cart_provider.dart';
import 'package:flower/shared_preferences/shared_preferences.dart';
import 'package:flower/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

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
        ChangeNotifierProvider<AdminMode>(
          create: (context) => AdminMode(),
        ),
      ],
      child:  ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context , child){
          return const MaterialApp(
            home: SplashScreen(),
            debugShowCheckedModeBanner: false,
          );
        },

      ),
    );
  }
}
