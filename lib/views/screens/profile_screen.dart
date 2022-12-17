import 'package:firebase_auth/firebase_auth.dart';
import 'package:flower/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared_preferences/shared_preferences.dart';
import 'auth/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final credential = FirebaseAuth.instance.currentUser;
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
            Center(
                child: Container(
              padding: const EdgeInsets.all(11),
              decoration: BoxDecoration(
                  color: green, borderRadius: BorderRadius.circular(11)),
              child: const Text(
                "Info from firebase Auth",
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
            )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 11.h,
                ),
                Text(
                  "Email: ${credential!.email} ",
                  style: const TextStyle(
                    fontSize: 17,
                  ),
                ),
                SizedBox(
                  height: 11.h,
                ),
                const Text(
                  "Created date:     ",
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                SizedBox(
                  height: 11.h,
                ),
                const Text(
                  "Last Signed In:     ",
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 55.h,
            ),
            Center(
                child: Container(
                    padding: const EdgeInsets.all(11),
                    decoration: BoxDecoration(
                        color: green, borderRadius: BorderRadius.circular(11)),
                    child: const Text(
                      "Info from firebase fireStore",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ))),
          ],
        ),
      ),
    );
  }
}
