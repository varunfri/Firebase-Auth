import 'package:firebase_app/components/auth_tile.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        backgroundColor: Colors.grey[400],
        title: const Text("About"),
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(25),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 70,
                backgroundColor: Colors.transparent,
                child: Icon(
                  // Icons.alternate_email,
                  Icons.lock_outline_rounded,
                  size: 100,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Firebase Authentication App",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Providers used for authentication",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Authtile(
                    imagepath: "lib/images/google.png",
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Authtile(
                    imagepath: "lib/images/github.png",
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Authtile(
                    imagepath: "lib/images/facebook.png",
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Authtile(
                    imagepath: "lib/images/phone.png",
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Text("version 1.0.0")
            ],
          ),
        ),
      ),
    );
  }
}
