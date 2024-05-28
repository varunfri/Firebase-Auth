//the file created to provide the auto signin/signup service using Google/Apple credentials

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authservice {
  static String? img;
  signWithFacebook() async {
    //initialize facebook account
    final LoginResult result = await FacebookAuth.instance.login();

    if (result.status == LoginStatus.success) {
      //Get a Facebook Access Token
      final AccessToken accessToken = result.accessToken!;

      //create a new credentials
      final OAuthCredential credential =
          FacebookAuthProvider.credential(accessToken.tokenString);

      //get userdata
      final userData = await FacebookAuth.instance.getUserData();
      final userImg = userData["picture"];

      if (userImg is Map<dynamic, dynamic>) {
        final pic = userImg["data"];
        img = pic["url"];
      } else {
        print("Not Map");
      }

      //Signin with Firebase
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }
    // Navigator.pop(context);
  }

  //creating  fumction for google signin
  signWithGoogle() async {
    //initialize the accounts
    final GoogleSignInAccount? guser = await GoogleSignIn().signIn();
    //begin interactive signin process
    final GoogleSignInAuthentication gauth = await guser!.authentication;
    //creating the new credentials for the user
    final credential = GoogleAuthProvider.credential(
      accessToken: gauth.accessToken,
      idToken: gauth.idToken,
    );

    //finally create and signin to google account
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  signWithGithub() async {
    try {
      GithubAuthProvider githubAuthProvider = GithubAuthProvider();

      return await FirebaseAuth.instance.signInWithProvider(githubAuthProvider);
    } on FirebaseAuthException catch (e) {
      print("Error is ${e.code}");
      if (e.code == "account-exists-with-different-credential") {
        print("Error in account");
      }
      return (e.code);
    }
  }
}
