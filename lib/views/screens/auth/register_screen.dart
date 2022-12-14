import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flower/firebase/user_fb_controller.dart';
import 'package:flower/model/user_model.dart';
import 'package:flutter/material.dart';

import '../../../constant/colors.dart';
import '../../../helper/snackbar.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_text_field.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with SnackBarHelper {
  late TextEditingController usernameEditingController;
  late TextEditingController emailEditingController;
  late TextEditingController passwordEditingController;

  @override
  void initState() {
    usernameEditingController = TextEditingController();
    emailEditingController = TextEditingController();
    passwordEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    usernameEditingController.dispose();
    emailEditingController.dispose();
    passwordEditingController.dispose();
    super.dispose();
  }

  bool isLoading = false;
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
                        validator: (v) {
                          return null;
                        },
                        controller: usernameEditingController,
                        textInputType: TextInputType.text,
                        hintText: 'Enter Your Username',

                      ),
                      const SizedBox(
                        height: 24,
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
                          await performRegister();
                        },
                        title: 'Register',
                        backgroundColor: green,
                      ),
                      const SizedBox(
                        height: 20,
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

  Future<void> performRegister() async {
    if (checkData()) {
      await register();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context)=>  LoginScreen()
          )
      );
    }
  }

  late final UserCredential userCredential;
  Future<void> register() async {
    setState(() {
      isLoading = true;
    });
    try {
      userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailEditingController.text,
        password: passwordEditingController.text,
      );
      setState(() {
        isLoading = false;
      });
      await createNewUser();
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      if (e.code == 'weak-password') {
        showSnackBar(context,
            message: 'The password provided is too weak.', error: true);
      } else if (e.code == 'email-already-in-use') {
        showSnackBar(context,
            message: 'The account already exists for that email.', error: true);
      } else {
        showSnackBar(context,
            message: 'Error , Please try again late', error: true);
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

  Future<void> createNewUser()async{
    await UserFbController().createUser(getUser());
    showSnackBar(context,
        message: 'create account has been successfully',
        error: false
    );
    Navigator.of(context).pop();
  }
  UserModel getUser(){
    UserModel userModel = UserModel();
    userModel.uId = userCredential.user!.uid;
    userModel.username = usernameEditingController.text;
    userModel.email = emailEditingController.text;
    userModel.password = passwordEditingController.text;
    return userModel;
  }
  bool checkData() {
    if (usernameEditingController.text.isEmpty) {
      showSnackBar(context,
          message: 'The username must be not empty.', error: true);
      return false;
    } else if (emailEditingController.text.isEmpty) {
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
