import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constant/colors.dart';
import '../../../helper/snackbar.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_text_field.dart';
import 'login_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> with SnackBarHelper{
  late TextEditingController emailEditingController;
  bool isLoading = false;
  @override
  void initState() {
    emailEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
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
                      SizedBox(height: 60.h),
                      const Text(
                        'Enter your email to reset your password',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20.h),

                      /// Email
                      MyTextField(
                        controller: emailEditingController,
                        textInputType: TextInputType.emailAddress,
                        hintText: 'Enter Your Email',
                      ),

                      SizedBox(height: 40.h),
                      MyButton(
                        isLoading: isLoading,
                        onPressed: () async{
                          await performResetPassword();
                        },
                        title: 'Reset Password',
                        backgroundColor: green,
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

  Future<void> performResetPassword() async {
    if (checkData()) {
      await resetPassword();
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    }
  }

  Future<void> resetPassword() async{
    setState(() {
      isLoading = true;
    });
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailEditingController.text);
      showSnackBar(context, message: 'Done , check your email', error: false);
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
     showSnackBar(context, message: e.toString(), error: true);
    }catch (e) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, message: e.toString(), error: true);
    }
    setState(() {
      isLoading = false;
    });


  }

  bool checkData() {
    if (emailEditingController.text.isEmpty) {
      showSnackBar(context,
          message: 'The email address must be not empty.', error: true);
      return false;
    }
    return true;
  }
}
