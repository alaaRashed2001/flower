import 'package:flower/views/screens/auth/signup_screen.dart';
import 'package:flutter/material.dart';

import '../../../constant/colors.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_text_field.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.jpg',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 60,
                      ),
                      MyTextField(
                        textInputType: TextInputType.emailAddress,
                        hintText: 'Enter Your Email',
                        isPassword: false,
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      MyTextField(
                        textInputType: TextInputType.text,
                        hintText: 'Enter Your Password',
                        isPassword: true,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      MyButton(
                        title: 'Log In',
                        backgroundColor: green,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account ? -',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const SignUpScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'Register',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
