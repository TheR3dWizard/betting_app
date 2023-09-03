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
        appBar: AppBar(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 20, 0),
              child: Center(
                child: Text(details[1],
                    style: TextStyle(fontSize: 30, fontFamily: font())),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 20, 20, 0),
                    child: Center(
                      child: Text(details[2],
                          style: TextStyle(fontSize: 30, fontFamily: font())),
                    ),
                  ),
                  ListView(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 12),
                    children: [Container()], //TODO just fix this
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
