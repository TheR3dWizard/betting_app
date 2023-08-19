import 'package:flutter/material.dart';
//import 'dart:ui';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Betting App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              "Sign in",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            )),
        const LabelledTextField(label: "Username"),
        const LabelledTextField(label: "Password"),
        ElevatedButton(
            child: const Text('Login'),
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            }),
      ],
    )));
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Home Page"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 20),
              child: Container(
                  padding: const EdgeInsets.fromLTRB(5, 20, 5, 20),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 133, 168, 185),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 1.0, horizontal: 10),
                          child: Text(
                            "Search for a bet",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        LabelledTextField(label: "Search")
                      ])),
            )
          ],
        ));
  }
}

class LabelledTextField extends StatelessWidget {
  final String label;
  const LabelledTextField({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15),
        child: TextField(
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              gapPadding: 5.0,
            ),
            labelText: label,
          ),
        ));
  }
}
