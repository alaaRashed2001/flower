import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final Function() onPressed;
  final bool isLoading;
  const MyButton({
    Key? key,
    required this.title,
    required this.backgroundColor, required this.onPressed,  this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        padding: MaterialStateProperty.all(
          const EdgeInsets.all(12),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      child:  isLoading ? const CircularProgressIndicator(color: Colors.white,) : Text(
      title,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.white
        ),
      ),
    );
  }
}
