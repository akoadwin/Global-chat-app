import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:global_chat_app/providers/user_provider.dart';
import 'package:global_chat_app/screens/dashboard.dart';
import 'package:global_chat_app/screens/login_screen.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    var user = FirebaseAuth.instance.currentUser;

    Future.delayed(const Duration(seconds: 2), () {
      if (user != null) {
        openDashboard();
      } else {
        openLogin();
      }
    });
  }

  Future<void> openDashboard() async {
    await Provider.of<UserProvider>(context, listen: false).getUserDetails();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const DashboardScreen();
    }));
  }

  void openLogin() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const LoginScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(child: Image.asset("assets/images/logo.png")),
      ),
    );
  }
}
