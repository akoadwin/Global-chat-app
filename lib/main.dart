import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:global_chat_app/firebase_options.dart';
import 'package:global_chat_app/providers/user_provider.dart';
import 'package:global_chat_app/screens/splash_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ChangeNotifierProvider(
      create: (context) {
        return UserProvider();
      },
      child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: "Poppins", colorScheme: const ColorScheme.light()),
      home: const SplashScreen(),
    );
  }
}
