import 'package:firebase_auth/firebase_auth.dart';
import 'package:flower/firebase/user_fb_controller.dart';
import 'package:flower/shared_preferences/shared_preferences.dart';
import 'package:flower/views/screens/auth/register_screen.dart';
import 'package:flower/views/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constant/colors.dart';
import '../../../helper/snackbar.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_text_field.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
            child: Opacity(
              opacity: 0.5,
              child: Image.asset(
                'assets/images/background.jpg',
                fit: BoxFit.cover,
              ),
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
                        height: 60.h,
                      ),
                      MyTextField(
                        controller: emailEditingController,
                        textInputType: TextInputType.emailAddress,
                        hintText: 'Enter Your Email',
                      ),
                       SizedBox(
                        height: 24.h,
                      ),
                      MyTextField(
                        obscure: true,
                        controller: passwordEditingController,
                        textInputType: TextInputType.text,
                        hintText: 'Enter Your Password',
                      ),
                       SizedBox(
                        height: 40.h,
                      ),
                      MyButton(
                        isLoading: isLoading,
                        onPressed: () async {
                          await performLogin();
                        },
                        title: 'Log In',
                        backgroundColor: green,
                      ),
                       SizedBox(
                        height: 20.h,
                      ),
                      TextButton(
                          onPressed: (){
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const ForgotPasswordScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Forgot password',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                      ),
                      SizedBox(
                        height: 20.h,
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
                          TextButton(
                            onPressed: (){
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const RegisterScreen(),
                                ),
                              );
                            },
                            child: Text(
                              '-Register',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),

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
      /// Get User Data
      await getUserData(userCredential.user!.uid);

      setState(() {
        isLoading = false;
      });

      showSnackBar(context,
          message: 'i have successfully logged in', error: false);
      await SharedPreferencesController().setLoggedIn();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) =>  HomeScreen()));
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
  }

  Future<void> getUserData(String uId) async {
    /// Get user model from Firestore
    var data = await UserFbController().readUser(uId);

    if(data != null) {
      /// Save user data in Shared Preferences
      await SharedPreferencesController().setEmail(email: data.email);
      await SharedPreferencesController().setUserType(type: data.type);
      await SharedPreferencesController().setUId(id: uId);

    }
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
