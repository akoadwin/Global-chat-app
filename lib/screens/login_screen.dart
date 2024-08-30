// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:global_chat_app/controllers/login_controller.dart';
import 'package:global_chat_app/screens/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  var userForm = GlobalKey<FormState>();

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
                  height: 100,
                ),
                const Text(
                  "Welcome Back!",
                  style: TextStyle(fontSize: 25),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Log in",
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
                              LoginController.loginAccount(
                                  email: email.text,
                                  context: context,
                                  password: password.text);
                            }
                          },
                          child: Text("Login")),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text("Don't have an account?"),
                    InkWell(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (context) {
                            return const SignupScreen();
                          }), (route) {
                            return false;
                          });
                        },
                        child: const Text(
                          "Sign up here!",
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
