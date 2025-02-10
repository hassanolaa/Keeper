import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
// signup firebase function with email and password and and check if it is correct
  static Future<String> signUp(
      String username, String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      // add user to firestore
      FirebaseFirestore.instance
          .collection("users")
          .doc(userCredential.user!.uid)
          .set({
        "username": username,
        "email": email,
        "uid": userCredential.user!.uid,
      });
      return "SignUp success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      } else if (e.code == 'invalid-email') {
        return 'The email address is badly formatted.';
      }
    } catch (e) {
      print(e);
      return e.toString();
    }
    return "null";
  }

  // signIn firebase function with email and password and and check if it is correct
  static Future<String> signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      return "SignIn success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email. check your email and password';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
    } catch (e) {
      print(e);
      return e.toString();
    }
    return "No user found for that email.";
  }

  // forget password with email
  static Future<String> forgetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      return "Forget password success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      }
    } catch (e) {
      print(e);
      return e.toString();
    }
    return "null";
  }

  // signOut firebase function
  static Future<String> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();

      return "SignOut success";
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  // signIn with google

  static Future<String> signInWithGoogle() async {
    if (kIsWeb) {
      GithubAuthProvider githubProvider = GithubAuthProvider();
      try {
        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithPopup(githubProvider);
        if (userCredential.user != null) {
          return "SignIn success";
        } else {
          return "SignIn failed";
        }
      } catch (e) {
        //return e.toString();
        return "Sorry Google signIn is not available for the web application";
      }
    } else {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      print(googleUser!.email.replaceAll('@gmail.com', ''));

      // Once signed in, return the UserCredential

      // if the user not has a document in firestore create one
      final userdata= await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();
       if (!userdata.exists) {
         FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).set({
        "username": googleUser.email.replaceAll('@gmail.com', ''),
        "email": googleUser.email,
        "uid": FirebaseAuth.instance.currentUser!.uid,
        });

       }
      


      return "SignIn success";
    }
  }
}
