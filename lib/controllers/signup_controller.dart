// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:global_chat_app/screens/dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:global_chat_app/screens/splash_screen.dart';

class SignupController {
  static Future<void> createAccount(
      {required String email,
      required String name,
      required String lastname,
      required String country,
      required BuildContext context,
      required String password}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      var userId = FirebaseAuth.instance.currentUser!.uid;
      var db = FirebaseFirestore.instance;

      Map<String, dynamic> data = {
        "name": name,
        "lastname": lastname,
        "email": email,
        "country": country,
        "id": userId.toString()
      };
      try {
        await db.collection("users").doc(userId.toString()).set(data);
      } catch (e) {
        print(e);
      }
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
