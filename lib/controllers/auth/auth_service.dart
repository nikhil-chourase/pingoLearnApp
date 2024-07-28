

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pingolearnapp/global.dart';
import 'package:pingolearnapp/model/user/user.dart' as model;
import 'package:pingolearnapp/view/auth/login_screen.dart';
import 'package:pingolearnapp/view/products/products_screen.dart';


class AuthService with ChangeNotifier {
 
  User? _user;

  AuthService() {
    firebaseAuth.authStateChanges().listen(_onAuthStateChanged);
  }

  User? get user => _user;

  bool isUserLoggedIn() {
    return _user != null;
  }

  Future<bool> registerUser(String username, String email, String password, BuildContext context) async {
    try {
     
      UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      model.User user = model.User(
        name: username,
        email: email,
        uid: cred.user!.uid,
      );

      await firestore
          .collection('users')
          .doc(cred.user!.uid)
          .set(user.toJson());

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {

        showSnackBar(context,'The password provided is too weak.');

      } else if (e.code == 'email-already-in-use') {

        showSnackBar(context,'The account already exists for that email.');

      } else if (e.code == 'invalid-email') {
        showSnackBar(context,'The email address is not valid.');
      } else {
        showSnackBar(context,'Error during registration: ${e.message}');

      }
      return false;
    } catch (e) {
      showSnackBar(context,'Error during registration: $e');

      return false;
    }
  }

  
  Future<bool> signInUser(String email, String password,BuildContext context) async {
    try {
     

      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return true;
    } on FirebaseAuthException catch (e) {

      if (e.code == 'user-not-found') {
        showSnackBar(context,'No user found for that email.');

      } else if (e.code == 'wrong-password') {
        showSnackBar(context,'Wrong password provided.');

      } else if (e.code == 'invalid-email') {
        showSnackBar(context,'The email address is not valid.');

      } else {
        showSnackBar(context,'Error during login: ${e.message}');
      }
      return false;

    } catch (e) {
      showSnackBar(context,'Error during login: $e');
      return false;

    }
  }

  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      print('Error during sign out: $e');
    }
  }
  void _onAuthStateChanged(User? user) {
    _user = user;
    notifyListeners();
  }


  Future<void> signUp(String name, String email, String password, BuildContext context) async {
    try {
      if (await registerUser(name, email, password, context)) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
        FocusScope.of(context).unfocus();
        showSnackBar(context,'User registered successfully');
        
      }
    } catch (e) {
      print(e);
    }
  }


   void login(String email,String password,BuildContext context) async{
    try{

      if(await signInUser(email, password,context)){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>  ProductScreen()));
      }
    }catch(e)
    {
      print(e);
    }
  }
}


void showSnackBar(BuildContext context, String text){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}

