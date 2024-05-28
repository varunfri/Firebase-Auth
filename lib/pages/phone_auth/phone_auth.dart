import 'dart:math';

import 'package:firebase_app/components/textfield.dart';
import 'package:firebase_app/pages/phone_auth/otp_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//this file contains both phone_number verfication and otp_verification codes

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({super.key});

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  TextEditingController phonecontroller = TextEditingController();
  final countryCode = "+91";

  //progress indicator
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        backgroundColor: Colors.grey[400],
        title: const Text("Phone Auth"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 60,
              child: Icon(
                Icons.phone,
                color: Colors.blue,
                size: 60,
              ),
            ),
            MyTextfield(
              hide: false,
              keyboardType: TextInputType.phone,
              name: "Enter Mobile Number",
              controller: phonecontroller,
              icon: Icons.phone,
            ),
            // TextField(
            //   controller: phonecontroller,
            //   keyboardType: TextInputType.phone,
            //   decoration: InputDecoration(
            //     hintText: "Enter Phone",
            //     suffixIcon: const Icon(Icons.phone),
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(24),
            //     ),
            //   ),
            // ),
            const SizedBox(
              height: 25,
            ),
            ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.verifyPhoneNumber(
                    verificationCompleted: (PhoneAuthCredential credential) {},
                    verificationFailed: (FirebaseAuthException ex) {
                      log(ex.toString() as num);
                    },
                    codeSent: (String verificationId, int? resendtoken) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OtpScreen(
                            verificationId: verificationId,
                          ),
                        ),
                      );
                    },
                    codeAutoRetrievalTimeout: (String verficationId) {},
                    phoneNumber: countryCode + phonecontroller.text.toString(),
                  );

                  print("Sent OTP");
                },
                child: const Text(
                  "Get OTP",
                  style: TextStyle(color: Colors.black),
                ))
          ],
        ),
      ),
    );
  }
}
