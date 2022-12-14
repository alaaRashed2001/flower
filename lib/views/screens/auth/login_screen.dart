import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flower/provider/admin_mode.dart';
import 'package:flower/views/screens/auth/register_screen.dart';
import 'package:flower/views/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constant/colors.dart';
import '../../../helper/snackbar.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_text_field.dart';
import 'login_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SnackBarHelper {
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

  bool isLoading = false;
  bool isAdmin = false;
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
                        validator: (value) {
                          return value != null &&
                                  !EmailValidator.validate(value)
                              ? "Enter a valid email"
                              : null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: emailEditingController,
                        textInputType: TextInputType.emailAddress,
                        hintText: 'Enter Your Email',
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      MyTextField(
                        controller: passwordEditingController,
                        validator: (value) {
                          return value!.length < 6
                              ? "Enter at least 6 characters"
                              : null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textInputType: TextInputType.text,
                        hintText: 'Enter Your Password',
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      MyButton(
                        isLoading: isLoading,
                        onPressed: () async {
                          await performLogin();
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
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const RegisterScreen(),
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
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 10,
                        ),
                        child: Row(
                          children:  [
                            Expanded(
                                child: InkWell(
                                  onTap: (){
                                    Provider.of<AdminMode>(context , listen: false).changeisAdmin(true);
                                  },
                                  child: Text(
                                    'i\'m as admin',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Provider.of<AdminMode>(context).isAdmin ? Colors.transparent : Colors.black
                                    ),
                                  ),
                                )),
                            Expanded(
                                child: InkWell(
                                  onTap: (){
                                    Provider.of<AdminMode>(context , listen: false).changeisAdmin(false);
                                  },
                                  child: Text(
                                    'i\'m as user',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color:  Provider.of<AdminMode>(context).isAdmin ? Colors.black : Colors.transparent
                                    ),
                                  ),
                                )),
                          ],
                        ),
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

  Future<void> performLogin() async {
    if (checkData()) {
      await login();
    }
  }

  late final UserCredential userCredential;
  Future<void> login() async {
    setState(() {
      isLoading = true;
    });
    try {
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailEditingController.text,
        password: passwordEditingController.text,
      );
      setState(() {
        isLoading = false;
      });
      showSnackBar(context,
          message: 'i have successfully logged in', error: false);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()));
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      if (e.code == 'user-not-found') {
        showSnackBar(context,
            message: 'No user found for that email.', error: true);
      } else if (e.code == 'wrong-password') {
        showSnackBar(context,
            message: 'Wrong password provided for that user.', error: true);
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, message: e.toString(), error: true);
    }
    setState(() {
      isLoading = false;
    });
    showSnackBar(context, message: 'LogIn has been successfully', error: false);
  }

  bool checkData() {
    if (emailEditingController.text.isEmpty) {
      showSnackBar(context,
          message: 'The email address must be not empty.', error: true);
      return false;
    } else if (passwordEditingController.text.isEmpty) {
      showSnackBar(context,
          message: 'The password must be not empty.', error: true);
      return false;
    }
    return true;
  }
}
