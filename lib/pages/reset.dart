import 'package:firebase_app/components/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();

    showMsg(String info) {
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(info),
          duration: const Duration(milliseconds: 1500),
        ),
      );
    }

    Future sendLink(TextEditingController controller) async {
      if (emailController.text == "") {
        showMsg("Enter correct email");
      } else {
        try {
          await FirebaseAuth.instance
              .sendPasswordResetEmail(email: controller.text.trim());
          showMsg("Reset password link sent to email");
          //pop(context)
          //Navigator.pop(context);
        } on FirebaseAuthException catch (e) {
          print(e.code);
          if (e.code == "invalid-email") {
            showMsg("Check entered email");
          }
        }
      }
    }

    return Scaffold(
        backgroundColor: Colors.grey[400],
        appBar: AppBar(
          backgroundColor: Colors.grey[400],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                "Receive an email to reset password",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              MyTextfield(
                hide: false,
                name: "Enter Email",
                controller: emailController,
                icon: Icons.mail_sharp,
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  sendLink(emailController);
                },
                child: const Text(
                  "Reset Password",
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          ),
        ));
  }
}
