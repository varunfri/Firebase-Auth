import 'package:firebase_app/pages/home.dart';
// import 'package:firebase_app/pages/login.dart';
import 'package:firebase_app/pages/login_or_register/login_or_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authpage extends StatelessWidget {
  const Authpage({super.key});

  //this page checks for userstate, whether signin or not,
  //If user signed in view homepage else login page
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Home();
        } else {
          return const LoginOrRegister();
        }
      },
    );
  }
}
