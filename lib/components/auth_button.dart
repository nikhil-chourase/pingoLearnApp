import 'package:flutter/material.dart';
import 'package:pingolearnapp/global.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({super.key, required this.onPressed, required this.text, required this.size});

  final VoidCallback onPressed;
  final String text;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
                    onPressed: onPressed,
                    child:  Text(text),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      fixedSize: Size(size.width/2, size.height/15),
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      textStyle: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder( // Rectangle shape
                      borderRadius: BorderRadius.circular(10),
                    ),
                    ),
                  );
  }
}