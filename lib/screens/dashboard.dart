import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:global_chat_app/providers/user_provider.dart';
import 'package:global_chat_app/screens/profile_screen.dart';
import 'package:global_chat_app/screens/splash_screen.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var user = FirebaseAuth.instance.currentUser;
  var db = FirebaseFirestore.instance;

  var scaffoldKey = GlobalKey<ScaffoldState>();

  List<Map<String, dynamic>> chatRoomsList = [];
  void getChatRooms() {
    db.collection("chatrooms").get().then((dataSnapshot) {
      for (var singleChatRoomData in dataSnapshot.docs) {
        chatRoomsList.add(singleChatRoomData.data());
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    getChatRooms();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
        key: scaffoldKey,
        drawer: Drawer(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                ListTile(
                  onTap: () async {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const ProfileScreen();
                    }));
                  },
                  leading: CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.greenAccent,
                    foregroundColor: Colors.black,
                    child: Text(
                      style: const TextStyle(fontSize: 20),
                      '${userProvider.userName[0]}${userProvider.userLastname[0]}',
                    ),
                  ),
                  title: Text(
                    '${userProvider.userName} ${userProvider.userLastname}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(userProvider.userEmail),
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
          centerTitle: true,
          leading: InkWell(
              onTap: () {
                scaffoldKey.currentState!.openDrawer();
              },
              child: const Icon(size: 30, Icons.sort)),
        ),
        body: ListView.builder(
            itemCount: chatRoomsList.length,
            itemBuilder: (BuildContext context, int index) {
              String chatroomName = chatRoomsList[index]["chatroom_name"] ?? "";
              String chatRoomDesc = chatRoomsList[index]["desc"] ?? "";
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.greenAccent,
                  foregroundColor: Colors.black,
                  child: Text(chatroomName[0]),
                ),
                title: Text(chatroomName),
                subtitle: Text(chatRoomDesc),
              );
            }));
  }
}
