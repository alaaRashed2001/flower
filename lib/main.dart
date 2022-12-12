import 'package:firebase_core/firebase_core.dart';
import 'package:flower/provider/cart_provider.dart';
import 'package:flower/views/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
return  ChangeNotifierProvider(
create: (context) => CartProvider(),
  child:   const MaterialApp(
    home: LogInScreen(),
    debugShowCheckedModeBanner: false,
  ),
);
  }

}