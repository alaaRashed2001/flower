import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flower/firebase/user_fb_controller.dart';
import 'package:flower/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constant/colors.dart';
import '../../../helper/snackbar.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_text_field.dart';
import 'login_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  UserTypes userType = UserTypes.buyer;

  File? imgPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
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

                      // Container(
                      //   padding: const EdgeInsets.all(5),
                      //   decoration: const BoxDecoration(
                      //     shape: BoxShape.circle,
                      //     color: Colors.grey,
                      //   ),
                      //   child: Stack(
                      //     children: [
                      //       imgPath == null
                      //           ?  CircleAvatar(
                      //               backgroundColor: Colors.white,
                      //               radius: 71.w,
                      //               backgroundImage:
                      //                   const AssetImage("assets/images/avatar.png"),
                      //             )
                      //           : ClipOval(
                      //               child: Image.file(
                      //                 imgPath!,
                      //                 width: 145.w,
                      //                 height: 145.h,
                      //                 fit: BoxFit.cover,
                      //               ),
                      //             ),
                      //       Positioned(
                      //         right: 95,
                      //         bottom: -10,
                      //         child: IconButton(
                      //           onPressed: () {
                      //             ///
                      //           },
                      //           icon:  Icon(Icons.add_a_photo , size: 30.r,),
                      //           color: Colors.grey,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      SizedBox(height: 50.h),


                      /// Username
                      MyTextField(
                        controller: usernameEditingController,
                        textInputType: TextInputType.text,
                        hintText: AppLocalizations.of(context)!.username,
                      ),
                      SizedBox(height: 24.h),

                      /// Email
                      MyTextField(
                        controller: emailEditingController,
                        textInputType: TextInputType.emailAddress,
                        hintText:AppLocalizations.of(context)!.email ,
                      ),
                      SizedBox(height: 24.h),

                      /// Password
                      MyTextField(
                        obscure: true,
                        controller: passwordEditingController,
                        textInputType: TextInputType.text,
                        hintText: AppLocalizations.of(context)!.password,
                      ),
                      SizedBox(height: 20.h),

                      /// User Type
                      Row(
                        children: [
                          Row(
                            children: [
                              Radio(
                                value: UserTypes.buyer,
                                groupValue: userType,
                                onChanged: (value) {
                                  setState(() {
                                    userType = value!;
                                  });
                                },
                              ),
                               Text(AppLocalizations.of(context)!.buyer),
                            ],
                          ),
                          SizedBox(width: 40.w),
                          Row(
                            children: [
                              Radio(
                                value: UserTypes.seller,
                                groupValue: userType,
                                onChanged: (value) {
                                  setState(() {
                                    userType = value!;
                                  });
                                },
                              ),
                               Text(AppLocalizations.of(context)!.seller),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 40.h),
                      MyButton(
                        isLoading: isLoading,
                        onPressed: () async {
                          await performRegister();
                        },
                        title: AppLocalizations.of(context)!.register,
                        backgroundColor: green,
                      ),
                      SizedBox(
                        height: 20.h,
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
          MaterialPageRoute(builder: (context) => const LoginScreen()));
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

  Future<void> createNewUser() async {
    await UserFbController().createUser(getUser);
    showSnackBar(context,
        message: 'create account has been successfully', error: false);
    Navigator.of(context).pop();
  }

  UserModel get getUser {
    UserModel userModel = UserModel();
    userModel.uId = userCredential.user!.uid;
    userModel.username = usernameEditingController.text;
    userModel.email = emailEditingController.text;
    userModel.password = passwordEditingController.text;
    userModel.type = userType.name;
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
