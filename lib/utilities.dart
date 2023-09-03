import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LabelledTextField extends StatelessWidget {
  final String label;
  TextEditingController? controller;
  bool? enabled;
  //final Function(String) subFunction;
  LabelledTextField({
    super.key,
    required this.label,
    //required this.subFunction
  });

  LabelledTextField.readable({
    super.key,
    required this.label,
    required this.controller,
  });

  LabelledTextField.offOn({
    super.key,
    required this.label,
    required this.enabled,
  });

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
        controller: controller,
        enabled: enabled,
        //onSubmitted: subFunction,
      ),
    );
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
  //TODO add on pressed function

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 2),
        child: Container(
          width: 100,
          height: 50,
          decoration: const BoxDecoration(
            color: Color.fromARGB(160, 103, 155, 180),
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

// Custom Functions

//Function to load bet objects from json

Future<List<dynamic>> loadBets() async {
  final String response = await rootBundle.loadString('assets/jsons/bets.json');
  final jsonData = await json.decode(response)['bets'];
  return jsonData;
}

Future<List<String>> loadSearchTerms() async {
  final String response = await rootBundle
      .loadString('assets/jsons/bets.json'); //change to api or different json
  final jsonData = await json.decode(response)['bets'];
  List<String> searchTerms = [];
  for (var bet in jsonData) {
    searchTerms.add(bet['name']);
  }
  return searchTerms;
}

Future<List<dynamic>> loadBetData() async {
  final String response =
      await rootBundle.loadString('assets/jsons/betdetails.json');
  final jsonFile = await json.decode(response);
  List<dynamic> jsonData = [jsonFile['id']];
  jsonData.add(jsonFile['title']);
  jsonData.add(jsonFile['name']);
  jsonData.add(jsonFile['date']);
  jsonData.add(jsonFile['pool']);
  jsonData.add(jsonFile['playersnum']);
  for (var option in jsonFile['options']) {
    jsonData.add([option['name'], option['votes'], option['money']]);
  }
  jsonData.add(jsonFile['optionsnum']);
  return jsonData;
}

String font() {
  return 'Poppins';
}
