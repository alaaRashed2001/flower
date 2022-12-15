import 'package:flower/shared_preferences/shared_preferences.dart';
import 'package:flower/views/screens/auth/login_screen.dart';
import 'package:flower/views/screens/home_screen.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> init() async {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => SharedPreferencesController().checkLoggedIn
            ?  HomeScreen()
            : const LoginScreen(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [


          Positioned.fill(
            child: Image.asset(
              'assets/images/splash.png',
              fit: BoxFit.cover,
            ),
          ),

          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'welcome for my flower',
                    style: TextStyle(
                        color:Color(0xFF001702),
                        fontSize: 34,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 24,),
                  Text(
                    'Flowers grow back, even after they are stepped on. So will I',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color:  Color(0xFF0a470e), fontSize: 24, fontWeight: FontWeight.bold,

                    ),
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
