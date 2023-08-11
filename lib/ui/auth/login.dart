import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/widgets/RoundButton.dart';

import 'SignUp.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text("Login"),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.text,
                        cursorColor: Colors.grey,
                        controller: emailController,
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors
                                    .grey), // Change the border color when focused
                          ),
                          hintText: "Email",
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.grey,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        cursorColor: Colors.grey,
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors
                                    .grey), // Change the border color when focused
                          ),
                          hintText: "Password",
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.grey,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter password';
                          }
                          return null;
                        },
                      )
                    ],
                  )),
              SizedBox(
                height: 40,
              ),
              RoundButton(
                "Login",
                () {
                  if (_formKey.currentState!.validate()) {}
                },
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account ?"),
                  TextButton(
                      onPressed: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUp())),
                          },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
