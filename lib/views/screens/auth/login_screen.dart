import 'package:flower/views/screens/auth/signup_screen.dart';
import 'package:flower/views/screens/home_screen.dart';
import 'package:flutter/material.dart';

import '../../../constant/colors.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_text_field.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {

  late TextEditingController emailEditingController;
  late TextEditingController passwordEditingController;

  @override
  void initState() {
    emailEditingController = TextEditingController();
    passwordEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailEditingController.dispose();
    passwordEditingController.dispose();
    super.dispose();
  }

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
                       MyTextField(
                         validator: (v){
                           return null;
                         },
                         controller: emailEditingController,
                        textInputType: TextInputType.emailAddress,
                        hintText: 'Enter Your Email',

                      ),
                      const SizedBox(
                        height: 24,
                      ),
                       MyTextField(
                         validator: (v){
                           return null;
                         },
                         controller: passwordEditingController,
                        textInputType: TextInputType.text,
                        hintText: 'Enter Your Password',
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      MyButton(
                        onPressed: (){
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) =>  HomeScreen(),
                              ),);
                        },
                        title: 'Log In',
                        backgroundColor: green,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
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
                                  builder: (context) =>  SignUpScreen(),
                                ),
                              );
                            },
                            child: const Text(
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
