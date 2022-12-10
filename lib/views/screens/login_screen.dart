import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/my_text_field.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: const [
              SizedBox(
                height: 60,
              ),
              MyTextField(
                textInputType: TextInputType.emailAddress,
                hintText: 'Enter Your Email',
                isPassword: false,
              ),
              SizedBox(
                height: 24,
              ),
              MyTextField(
                textInputType: TextInputType.text,
                hintText: 'Enter Your Password',
                isPassword: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
