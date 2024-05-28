import 'package:firebase_app/pages/about/about.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final user = FirebaseAuth.instance.currentUser;

  // final image = ImageProvider;
  ImageProvider? image;
  String? providerId, provider, email, phone;
  String? name;
  @override
  initState() {
    super.initState();
    info();
    info_1();
    provider = user!.providerData[0].displayName;
    phone = user!.providerData[0].phoneNumber;
    email = user!.providerData[0].email;
  }

  info() {
    if (user!.photoURL == null) {
      image = const AssetImage("lib/images/profile.png");
    } else {
      image = NetworkImage("${user!.photoURL}");
    }
  }

  info_1() {
    providerId =
        "Logged in with ${user!.providerData[0].providerId.toUpperCase()}";

    if (user!.displayName == null) {
      name = user!.email == null
          ? "${user!.email}"
          : "${user!.providerData[0].email}";
    } else {
      name = "${user!.displayName}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        backgroundColor: Colors.grey[400],
        title: const Text("Home"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AboutPage(),
                ),
              );
            },
            icon: const Icon(Icons.info),
            tooltip: "About",
          ),
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              GoogleSignIn().signOut();
            },
            icon: const Icon(Icons.logout),
            tooltip: "Logout",
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              //Show user photo if has, else give random pic
              CircleAvatar(
                radius: 50,
                backgroundImage: image,
              ),
              const SizedBox(height: 20),

              //Show the provider name used for login
              Text(
                "$providerId",
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              //Logged in user-name
              Text(
                name == "null" ? "Unknown" : "$name",
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              //user login mail
              Text(
                email == null ? "$phone" : "$email",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
