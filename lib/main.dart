import "package:firebase_app/pages/auth_page.dart";
import "package:flutter/material.dart";
import "package:firebase_core/firebase_core.dart";
import "firebase_options.dart";

// need to initialize the firebase in main using async and await

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      // home: Authpage(),
      home: Authpage(),
      // home: PhoneAuth(),
    );
  }
}
