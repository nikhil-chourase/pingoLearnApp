
import 'package:flutter/material.dart';
import 'package:pingolearnapp/global.dart';

class GestureButton extends StatelessWidget {
  const GestureButton({super.key, required this.onTap, required this.msg, required this.auth});

  final VoidCallback onTap;
  final String msg;
  final String auth;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
                    onTap: onTap,
                    child: Text.rich(
                              TextSpan(
                                text: msg,
                                style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w600),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: auth,
                                    style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold,fontSize: 14),
                                  ),
                                  
                                ],
                              ),
                            ),
                  );
  }
}