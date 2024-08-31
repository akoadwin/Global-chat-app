// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:global_chat_app/screens/dashboard.dart';
import 'package:global_chat_app/screens/splash_screen.dart';

class LoginController {
  static Future<void> loginAccount(
      {required String email,
      required BuildContext context,
      required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        return const SplashScreen();
      }), (route) {
        return false;
      });
    } catch (e) {
      SnackBar snackBar = SnackBar(
        backgroundColor: Colors.red.shade500,
        behavior: SnackBarBehavior.floating,
        content: Text(style: const TextStyle(fontSize: 15), e.toString()),
        showCloseIcon: true,
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
