import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:global_chat_app/screens/profile_screen.dart';
import 'package:global_chat_app/screens/splash_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              ListTile(
                onTap: () async {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const ProfileScreen();
                  }));
                },
                leading: const Icon(Icons.people),
                title: const Text("Profile"),
              ),
              ListTile(
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context) {
                    return const SplashScreen();
                  }), (route) {
                    return false;
                  });
                },
                leading: const Icon(Icons.logout_sharp),
                title: const Text("Logout"),
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text("Global Chat"),
      ),
      body: Center(
        child: Column(
          children: [
            const Text("Welcome"),
            Text((user?.email ?? "Undefined User").toString()),
          ],
        ),
      ),
    );
  }
}
