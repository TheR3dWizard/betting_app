import 'package:flutter/material.dart';
import 'utilities.dart';
import 'homepage.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              "Sign in",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: font()),
            )),
        LabelledTextField(label: "Username"),
        LabelledTextField(label: "Password"),
        ElevatedButton(
            child: const Text('Login'),
            onPressed: () {
              //Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const HomePage(
                          padding: EdgeInsets.all(0),
                        )),
              );
            }),
      ],
    )));
  }
}
