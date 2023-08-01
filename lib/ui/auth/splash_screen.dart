import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(children: [
        SizedBox(
          height: 300,
        ),
        Image.asset(
          "assets/icons/todo-icon.jpg",
          scale: 4,
        ),
        Text("Welcome and Make ToDo list...",style: TextStyle(
          
        ),)
      ]),
    );
  }
}
