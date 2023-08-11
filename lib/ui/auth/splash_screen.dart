import 'package:flutter/material.dart';
import 'package:todo_app/firebase_services/splash_services.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  SplashServices splashServices = SplashServices();
  @override
  void initState() {
    super.initState();
    splashServices.isLogin(context);
  }

  Widget build(BuildContext context) {
    return Material(
      child: Column(children: [
        SizedBox(
          height: 350,
        ),
        Image.asset(
          "assets/icons/todo-icon.jpg",
          scale: 4,
        ),
        Text(
          "Welcome and Make ToDo list...",
          style: TextStyle(
            fontSize: 20,
          ),
        )
      ]),
    );
  }
}
