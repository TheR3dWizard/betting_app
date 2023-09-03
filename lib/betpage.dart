import 'package:flutter/material.dart';
import 'utilities.dart';

class BetPage extends StatefulWidget {
  final List<dynamic> details;

  const BetPage({super.key, required this.details});

  @override
  State<BetPage> createState() => _BetpageState(details: details);
}

class _BetpageState extends State<BetPage> {
  List<dynamic> details;

  _BetpageState({required this.details});

  @override
  void initState() {
    super.initState();
    loadBetData().then(((value) {
      setState(() {
        details = value;
      });
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Example Title")),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 20, 0),
              child: Center(
                child: Text("Works",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: font())),
              ),
            )
          ],
        ));
  }
}
