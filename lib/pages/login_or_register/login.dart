import 'package:firebase_app/auth_service/auth_service.dart';
import 'package:firebase_app/components/component.dart';
import 'package:firebase_app/pages/phone_auth/phone_auth.dart';
import 'package:firebase_app/pages/reset.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  final Function()? onTap;
  const Login({super.key, required this.onTap});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final username = TextEditingController();
  final password = TextEditingController();

//function for signin
  void signin() async {
    //CircleProgressIndicator
    progress();
    //check the credentials to signin
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: username.text,
        password: password.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-email") {
        errmsg("Enter correct Email");
      } else if (e.code == "missing-password") {
        errmsg("Enter password");
      } else if (e.code == "invalid-credential") {
        errmsg("Check the entered details");
      } else if (e.code == "channel-error") {
        errmsg("Enter email and password");
      } else {
        errmsg("Wrong Credentials");
      }
    }
    Navigator.pop(context);
  }

  void progress() {
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
  }

  void errmsg(String info) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(info),
        duration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),

                //Main Logo
                const Icon(Icons.adobe, size: 70),
                const SizedBox(height: 10),

                //Tagline
                const Text("Welcom back, you've missed something",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 30),

                //Username
                MyTextfield(
                  hide: false,
                  name: "Username",
                  icon: Icons.person,
                  controller: username,
                ),

                const SizedBox(height: 20),

                //Password
                MyTextfield(
                  hide: true,
                  name: "Password",
                  controller: password,
                  icon: Icons.lock_outline,
                ),
                const SizedBox(height: 5),

                //Forgot password
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ResetPassword(),
                        ),
                      ),
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                //Signin Button
                Signbutton(
                  name: "Sign in!",
                  onTap: signin,
                ),
                const SizedBox(height: 15),
                // or continue with text
                const Text(
                  "or continue with",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 25),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Authtile(
                      onTap: () {
                        Authservice().signWithGoogle();
                      },
                      imagepath: "lib/images/google.png",
                    ),
                    const SizedBox(width: 10),

                    //Signin using Github
                    Authtile(
                      onTap: () {
                        Authservice().signWithGithub();
                      },
                      imagepath: "lib/images/github.png",
                    ),
                    const SizedBox(width: 10),

                    //Signin using Facebook
                    Authtile(
                      onTap: () {
                        Authservice().signWithFacebook();
                        // print("Facebook Signin");
                      },
                      imagepath: "lib/images/facebook.png",
                    ),
                    const SizedBox(width: 10),

                    // Signin with Phone
                    Authtile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PhoneAuth(),
                          ),
                        );
                      },
                      imagepath: "lib/images/phone.png",
                    ),
                  ],
                ),
                const SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("New User?", style: TextStyle(fontSize: 16)),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "Register Now!",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
