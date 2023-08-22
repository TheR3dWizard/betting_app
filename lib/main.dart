import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Consolas'),
            )),
        const LabelledTextField(label: "Username"),
        const LabelledTextField(label: "Password"),
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

class HomePage extends StatefulWidget {
  final EdgeInsets padding;
  const HomePage({super.key, required this.padding});

  @override
  State<HomePage> createState() => _HomePageState(padding: padding);
}

class _HomePageState extends State<HomePage> {
  EdgeInsets padding;
  _HomePageState({required this.padding});

  @override
  void initState() {
    super.initState();
    incremementPadding();
  }

  void incremementPadding() {
    Future.delayed(const Duration(microseconds: 1), () {
      setState(() {
        padding = const EdgeInsets.fromLTRB(10, 5, 10, 20);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Home Page"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AnimatedContainer(
              padding: padding,
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
              child: Container(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 20),
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
                            style:
                                TextStyle(fontSize: 20, fontFamily: 'Consolas'),
                          ),
                        ),
                        LabelledTextField(label: "Search")
                      ])),
            ),
            const AvailableBets(
              bets: [],
              padding: EdgeInsets.symmetric(vertical: 10),
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
      ),
    );
  }
}

class AvailableBets extends StatefulWidget {
  final List<dynamic> bets;
  final EdgeInsets padding;
  const AvailableBets({super.key, required this.bets, required this.padding});

  @override
  State<AvailableBets> createState() =>
      _AvailableBetsState(bets: bets, padding: padding);
}

class _AvailableBetsState extends State<AvailableBets> {
  EdgeInsets padding;
  List<dynamic> bets;
  _AvailableBetsState({required this.padding, required this.bets});

  void incremementPadding() {
    Future.delayed(const Duration(microseconds: 1), () {
      setState(() {
        padding = const EdgeInsets.fromLTRB(10, 5, 10, 20);
      });
    });
  }

  Future<List<dynamic>> _loadJson() async {
    final String response =
        await rootBundle.loadString('assets/jsons/bets.json');
    final jsonData = await json.decode(response)['bets'];
    // setState(() {
    //   List<dynamic> bets = jsonData['bets'];
    // });
    return jsonData;
  }

  @override
  void initState() {
    super.initState();

    _loadJson().then((value) {
      print("Future value: $value");
      setState(() {
        bets = value;
      });
    });

    //bets = loadJson();
    // Future<List<dynamic>> Bets = loadJson();
    // bets = await Bets;
    incremementPadding();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Container(
              alignment: Alignment.center,
              color: Colors.blue,
              height: 100,
              child: Text('Item: ${bets[index]}'),
            );
          },
          childCount: bets.length,
        ),
      )
    ]);
  }
}

class Bet extends StatefulWidget {
  final String name;
  final String pool;
  final String players;
  const Bet(
      {super.key,
      required this.name,
      required this.pool,
      required this.players});

  @override
  State<Bet> createState() =>
      _BetState(name: name, pool: pool, players: players);
}

class _BetState extends State<Bet> {
  String name;
  String pool;
  String players;

  _BetState({required this.name, required this.pool, required this.players});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 2),
        child: Container(
          width: 100,
          height: 50,
          decoration: const BoxDecoration(
            color: Color.fromARGB(134, 47, 84, 153),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                child: Text(name),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text(pool), Text(players)],
                ),
              )
            ],
          ),
        ));
  }
}
