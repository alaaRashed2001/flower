import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flower/firebase/user_fb_controller.dart';
import 'package:flower/provider/admin_mode.dart';
import 'package:flower/shared_preferences/shared_preferences.dart';
import 'package:flower/views/screens/auth/register_screen.dart';
import 'package:flower/views/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constant/colors.dart';
import '../../../helper/snackbar.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_text_field.dart';

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
                              Navigator.of(context).push(
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
    // showSnackBar(context, message: 'LogIn has been successfully', error: false);
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
