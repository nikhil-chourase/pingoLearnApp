
import 'package:flutter/material.dart';
import 'package:pingolearnapp/controllers/auth/auth_service.dart';
import 'package:pingolearnapp/global.dart';
import 'package:pingolearnapp/view/auth/sign_up_screen.dart';
import 'package:provider/provider.dart';


class LoginScreen extends StatelessWidget {

  LoginScreen({super.key});

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);

     final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text(
          'e-Shop',
        style: TextStyle(
          color: primaryColor,
          fontWeight: FontWeight.bold,
        ),),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: size.width/15),
          child: Form(
            key: _formKey,
            child: Column(
                children: [
                  SizedBox(height: size.height/3.5,),
            
                  TextFormField(
                    controller: _emailController,
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Email',
                    ),
                     validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                    style: const TextStyle(color: Colors.black),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                            
                    controller: _passwordController,
                    obscureText: true,
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Password',
                    ),
                     validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                                    
                    style: const TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: size.height/4),
                  ElevatedButton(
                    onPressed: () async{
                      // Implement login logic here

                      if (_formKey.currentState!.validate()) {
                        authService.login(
                          _emailController.text,
                          _passwordController.text,
                          context,
                        );
                       
                      }
                    },
                    child:  Text('Login'),
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
                  ),
            
                  SizedBox(height: size.height/100),
                  GestureDetector(
                    onTap: () =>  Navigator.of(context).pushReplacement(MaterialPageRoute(builder : (context) => SignUpScreen())),
                    child: Text.rich(
                              TextSpan(
                                text: 'New here? ',
                                style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w600),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Signup',
                                    style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold,fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                  ),
                ],
              ),
          ),
        ),
      ),
    );
  }
}