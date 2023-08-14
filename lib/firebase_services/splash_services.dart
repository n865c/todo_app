import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/screens/todo_list.dart';
import 'package:todo_app/ui/auth/login.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      Timer(
          const Duration(seconds: 3),
          () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => Mytodo())));
    } else {
      Timer(
          const Duration(seconds: 3),
          () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => Login())));
    }
  }
}
