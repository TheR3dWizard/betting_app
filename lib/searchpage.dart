import 'dart:convert';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'utilities.dart';

class SearchMenu extends SearchDelegate {
// Demo list to show querying

  final List<String> terms;

  List<String> searchTerms = ["Nothing Loaded"];

  SearchMenu(this.terms) {
    searchTerms = terms;
  }

// first overwrite to
// clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

// second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

// third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

// last overwrite to show the
// querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }
}

class SearchPage extends StatefulWidget {
  final List<String> searchTerms;
  const SearchPage({super.key, required this.searchTerms});
  @override
  State<SearchPage> createState() => _SearchPageState(searchTerms: searchTerms);
}

//TODO Show recent searches

class _SearchPageState extends State<SearchPage> {
  List<String> searchTerms;
  _SearchPageState({required this.searchTerms});

  @override
  void initState() {
    super.initState();

    loadSearchTerms().then((value) {
      //print("Future value: $value");
      setState(() {
        searchTerms = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Page'),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: SearchMenu(searchTerms));
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: const Center(
        child: Text('Search Page'),
      ),
    );
  }
}
