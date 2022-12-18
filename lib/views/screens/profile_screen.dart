import 'package:firebase_auth/firebase_auth.dart';
import 'package:flower/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:io';
import '../../shared_preferences/shared_preferences.dart';
import 'auth/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final credential = FirebaseAuth.instance.currentUser;
  File? imgPath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton.icon(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              await SharedPreferencesController().logout();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
            label: const Text(
              "logout",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          )
        ],
        backgroundColor: green,
        title: const Text("Profile Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 11.h,
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                ),
                child: Stack(
                  children: [
                    imgPath == null
                        ? CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 71.w,
                            backgroundImage:
                                const AssetImage("assets/images/avatar.png"),
                          )
                        : ClipOval(
                            child: Image.file(
                              imgPath!,
                              width: 145.w,
                              height: 145.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                    Positioned(
                      right: 95,
                      bottom: -10,
                      child: IconButton(
                        onPressed: () {
                          ///
                        },
                        icon: Icon(
                          Icons.add_a_photo,
                          size: 30.r,
                        ),
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 50.h),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "username:    ",
                    style: TextStyle(
                      fontSize: 17.sp,
                    ),
                  ),
                ),
                Icon(Icons.edit),
              ],
            ),
            SizedBox(
              height: 11.h,
            ),
            Text(
              "Email: ${credential!.email} ",
              style: TextStyle(
                fontSize: 17.sp,
              ),
            ),
            SizedBox(
              height: 11.h,
            ),
            Text(
              "Created date:  ${credential!.metadata.creationTime}   ",
              style: TextStyle(
                fontSize: 17.sp,
              ),
            ),
            SizedBox(
              height: 11.h,
            ),
            Text(
              "Last Signed In: ${credential!.metadata.lastSignInTime}    ",
              style: TextStyle(
                fontSize: 17.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
