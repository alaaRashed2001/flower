import 'package:flutter/material.dart';

import '../../../constant/colors.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_text_field.dart';
import 'login_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

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
                      const SizedBox(
                        height: 60,
                      ),
                      const MyTextField(
                        textInputType: TextInputType.text,
                        hintText: 'Enter Your Username',
                        isPassword: false,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      const MyTextField(
                        textInputType: TextInputType.emailAddress,
                        hintText: 'Enter Your Email',
                        isPassword: false,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      const MyTextField(
                        textInputType: TextInputType.text,
                        hintText: 'Enter Your Password',
                        isPassword: true,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const MyButton(
                        title: 'SignUp',
                        backgroundColor: green,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account ? -',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => const LogInScreen(),
                                  ),);
                            },
                            child: const Text(
                              'SignIn',
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
