// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:global_chat_app/controllers/signup_controller.dart';
import 'package:global_chat_app/screens/login_screen.dart';
import 'package:global_chat_app/widgets/loading_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController lastname = TextEditingController();

  var userForm = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: userForm,
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 60,
                ),
                const Text(
                  "Welcome To Global Chat App",
                  style: TextStyle(fontSize: 25),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.asset("assets/images/logo.png")),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Name is required";
                    }
                    return null;
                  },
                  controller: name,
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      label: const Text("Name")),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Last name is required";
                    }
                    return null;
                  },
                  controller: lastname,
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      label: const Text("Last Name")),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Country is required";
                    }
                    return null;
                  },
                  controller: country,
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      label: const Text("Country")),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email is required";
                    }
                    return null;
                  },
                  controller: email,
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      label: const Text("Email")),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password is required";
                    }
                    return null;
                  },
                  controller: password,
                  enableSuggestions: false,
                  autocorrect: false,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      label: const Text("Password")),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          style: const ButtonStyle(
                              foregroundColor:
                                  WidgetStatePropertyAll(Colors.black),
                              backgroundColor:
                                  WidgetStatePropertyAll(Colors.greenAccent)),
                          onPressed: () async {
                            if (userForm.currentState!.validate()) {
                              isLoading = true;
                              setState(() {});
                              await SignupController.createAccount(
                                  email: email.text,
                                  lastname: lastname.text,
                                  context: context,
                                  country: country.text,
                                  name: name.text,
                                  password: password.text);

                              isLoading = false;
                              setState(() {});
                            }
                          },
                          child: isLoading
                              ? const LoadingWidget()
                              : const Text("Create Account")),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text("Already have an account?"),
                    InkWell(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (context) {
                            return const LoginScreen();
                          }), (route) {
                            return false;
                          });
                        },
                        child: const Text(
                          "Login here",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
