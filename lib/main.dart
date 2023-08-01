import 'package:flutter/material.dart';
// import 'package:todo_app/ui/auth/login.dart';
// import 'package:todo_app/screens/todo_list.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo_app/ui/auth/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Splash(),
    );
  }
}
