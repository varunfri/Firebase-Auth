// ignore_for_file: must_be_immutable

import 'dart:developer';
import 'package:firebase_app/components/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  OtpScreen({super.key, required this.verificationId});
  String verificationId;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController otpcontroller = TextEditingController();

  // circle progress indicator
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
          title: const Text("OTP"),
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
                    Icons.lock_outline_rounded,
                    color: Colors.blue,
                    size: 60,
                  ),
                  
                ),
                MyTextfield(
                  hide: true,
                  name: "Enter OTP",
                  controller: otpcontroller,
                  icon: Icons.lock,
                ),
                // TextField(
                //   controller: otpcontroller,
                //   decoration: InputDecoration(

                //     // contentPadding: const EdgeInsets.only(left: 20, right: 20),
                //     hintText: "Enter OTP",
                //     suffixIcon: const Icon(Icons.lock),
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(20),
                //     ),
                //   ),
                // ),
                //Verify OTP
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      PhoneAuthCredential credential =
                          PhoneAuthProvider.credential(
                        verificationId: widget.verificationId,
                        smsCode: otpcontroller.text.toString(),
                      );

                      await FirebaseAuth.instance
                          .signInWithCredential(credential);
                      Navigator.pop(context);
                      //      .then(
                      //   (value) {
                      //     Navigator.pushReplacement(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) => Home(),
                      //       ),
                      //     );
                      //   },
                      // );
                    } catch (e) {
                      log(e.toString());
                    }
                  },
                  child: const Text(
                    "Verify OTP",
                    style: TextStyle(color: Colors.black),
                  ),
                )
              ],
            )));
  }
}
