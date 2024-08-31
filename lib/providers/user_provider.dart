import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  var db = FirebaseFirestore.instance;
  String userName = "";
  String userEmail = "";
  String userCountry = "";
  String userLastname = "";
  String userId = "";

  Future<void> getUserDetails() async {
    var authUser = FirebaseAuth.instance.currentUser;

    await db.collection("users").doc(authUser!.uid).get().then((dataSnapshot) {
      userName = dataSnapshot.data()?["name"] ?? " ";
      userLastname = dataSnapshot.data()?["lastname"] ?? " ";
      userEmail = dataSnapshot.data()?["email"] ?? " ";
      userCountry = dataSnapshot.data()?["country"] ?? " ";
      userId = dataSnapshot.data()?["id"] ?? " ";
      notifyListeners();
    });
  }
}
