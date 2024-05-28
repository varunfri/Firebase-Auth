import 'package:firebase_app/auth_service/auth_service.dart';
import 'package:firebase_app/components/auth_tile.dart';
import 'package:firebase_app/components/sign_button.dart';
import 'package:firebase_app/components/textfield.dart';
import 'package:firebase_app/pages/phone_auth/phone_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:fire_base/services/auth_service.dart';

class Registerpage extends StatefulWidget {
  final Function()? onTap;
  const Registerpage({super.key, required this.onTap});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  final username = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  void signup() async {
    print("Signup");
    //Show the circle animation
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.black,
            backgroundColor: Colors.white,
          ),
        );
      },
    );

    //Check the credentials and signup
    try {
      if (password.text == confirmPassword.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: username.text,
          password: password.text,
        );
      } else {
        errmsg("Enter correct password");
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      if (e.code == "invalid-email") {
        errmsg("Enter correct email");
      } else if (e.code == "missing-password") {
        errmsg("Enter the password");
      } else if (e.code == "weak-password") {
        errmsg("Password must more than 6 characters long.");
      } else if (e.code == "channel-error") {
        errmsg("Enter the details");
      } else if (e.code == "email-already-in-use") {
        errmsg("Email already exist!");
      } else {
        errmsg("Check credentials");
      }
    }
    Navigator.pop(context);
  }

  //function to show the error message
  void errmsg(String info) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(info),
      duration: const Duration(milliseconds: 500),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 50),
              const Icon(Icons.adobe, size: 70),
              const SizedBox(height: 10),
              const Text(
                "Let's create an account for you!",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 25),
              //Username TextField
              MyTextfield(
                  hide: false,
                  name: "Username",
                  controller: username,
                  icon: Icons.person),
              //Password Textfield
              const SizedBox(height: 20),
              MyTextfield(
                  hide: true,
                  name: "Password",
                  controller: password,
                  icon: Icons.lock_outline),
              //Confirm Password
              const SizedBox(height: 20),
              MyTextfield(
                  hide: true,
                  name: "Confirm password",
                  controller: confirmPassword,
                  icon: Icons.lock_outline),

              const SizedBox(height: 30),

              //signup Button
              Signbutton(
                name: "Sign up!",
                onTap: () {
                  signup();
                },
              ),
              const SizedBox(height: 20),
              const Text(
                "or continue with",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Authtile(
                      imagepath: "lib/images/google.png",
                      onTap: () {
                        Authservice().signWithGoogle();
                      }),
                  const SizedBox(width: 10),

                  //Signin using facebook
                  Authtile(
                    imagepath: "lib/images/facebook.png",
                    onTap: () {
                      Authservice().signWithFacebook();
                    },
                  ),
                  const SizedBox(width: 10),

                  //Signin With Github
                  Authtile(
                    imagepath: "lib/images/github.png",
                    onTap: () {
                      Authservice().signWithGithub();
                    },
                  ),
                  const SizedBox(width: 10),
                  Authtile(
                      imagepath: "lib/images/phone.png",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PhoneAuth(),
                          ),
                        );
                      })
                ],
              ),
              const SizedBox(height: 40),
              //Sign in option
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      "Sign in!",
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
