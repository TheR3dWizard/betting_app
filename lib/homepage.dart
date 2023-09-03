import 'package:flutter/material.dart';
import 'utilities.dart';
import 'searchpage.dart';

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

  final SearchText = TextEditingController();

  void searchMenu() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const SearchPage(
                searchTerms: [],
              )),
    );
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
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 1.0, horizontal: 10),
                          child: Text(
                            "Search for a bet",
                            style: TextStyle(fontSize: 20, fontFamily: font()),
                          ),
                        ),
                        OutlinedButton(
                          onPressed: () {
                            searchMenu();
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                                color: Color.fromARGB(255, 133, 168, 185),
                                width: 2),
                          ),
                          child: LabelledTextField.offOn(
                              label: "Search", enabled: false),
                        ),
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

  @override
  void initState() {
    super.initState();

    loadBets().then((value) {
      //print("Future value: $value");
      setState(() {
        bets = value;
      });
    });

    incremementPadding();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(255, 34, 104, 143),
        ),

        //color: Colors.blue,
        height: 490,
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 20),
        //duration: const Duration(milliseconds: 500),
        child: CustomScrollView(slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Bet(
                    name: bets[index]["name"],
                    pool: bets[index]["pool"],
                    players: bets[index]["players"]);
              },
              childCount: bets.length,
            ),
          )
        ]),
      ),
    );
  }
}
