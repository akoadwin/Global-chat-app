import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:global_chat_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var db = FirebaseFirestore.instance;

  var editForm = GlobalKey<FormState>();

  TextEditingController nameText = TextEditingController();
  TextEditingController lastnameText = TextEditingController();
  TextEditingController emailText = TextEditingController();

  void updateData() {
    try {
      Map<String, dynamic> toUpdateData = {
        "name": nameText.text,
        "lastname": lastnameText.text,
        "email": emailText.text,
      };

      db
          .collection("users")
          .doc(Provider.of<UserProvider>(context, listen: false).userId)
          .update(toUpdateData);

      Provider.of<UserProvider>(context, listen: false).getUserDetails();
    } catch (e) {
      print(e);
    }
  }

  void getOldData() {
    nameText.text = Provider.of<UserProvider>(context, listen: false).userName;
    lastnameText.text =
        Provider.of<UserProvider>(context, listen: false).userLastname;
    emailText.text =
        Provider.of<UserProvider>(context, listen: false).userEmail;
  }

  @override
  void initState() {
    getOldData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Profile'),
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
        child: Center(
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.greenAccent,
                foregroundColor: Colors.black,
                minRadius: 45,
                child: Text(
                  '${userProvider.userName[0]}${userProvider.userLastname[0]}',
                  style: const TextStyle(fontSize: 40),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              InkWell(
                  onTap: () {
                    getOldData();
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          return Form(
                            key: editForm,
                            child: AlertDialog(
                              content: SizedBox(
                                height: 200,
                                child: SingleChildScrollView(
                                  child: Column(children: [
                                    TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Name is required";
                                        }
                                        return null;
                                      },
                                      controller: nameText,
                                      decoration: InputDecoration(
                                          border: UnderlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          label: const Text("Name")),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Last name is required";
                                        }
                                        return null;
                                      },
                                      controller: lastnameText,
                                      decoration: InputDecoration(
                                          border: UnderlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          label: const Text("Last name")),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Email is required";
                                        }
                                        return null;
                                      },
                                      controller: emailText,
                                      decoration: InputDecoration(
                                          border: UnderlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          label: const Text("Email")),
                                    ),
                                  ]),
                                ),
                              ),
                              actions: [
                                InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      "Close",
                                      style: TextStyle(color: Colors.red),
                                    )),
                                const SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                    onTap: () {
                                      if (editForm.currentState!.validate()) {
                                        updateData();
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: const Text(
                                      "Save",
                                    ))
                              ],
                              title: const Center(
                                  child: Text("Change profile info")),
                            ),
                          );
                        });
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(size: 20, Icons.edit),
                      Text(" Edit Profile"),
                    ],
                  )),
              const SizedBox(
                height: 15,
              ),
              Text(
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 20),
                  '${userProvider.userName} ${userProvider.userLastname}'),
              Text(userProvider.userEmail),
            ],
          ),
        ),
      ),
    );
  }
}
