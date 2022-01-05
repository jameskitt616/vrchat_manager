import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'detailed_page.dart';
import 'package:vrchat_dart_generated/vrchat_dart_generated.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {










  String url = 'https://randomuser.me/api/?results=20';
  List data = [];
  bool _isDataLoading = true;

  Future<List> _getUsers() async {

    var response = await http.get(
      Uri.parse(url),
      headers: {"Accept": 'application/json'},
    );

    setState(() {
      var listData = json.decode(response.body);
      data = listData['results'];

      _isDataLoading = false;
    });
    return data;
  }

  @override
  void initState() {
    super.initState();

    _getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: _isDataLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, index) {
                  return ListTile(
                    title: Text(data[index]['name']['first'] +
                        " " +
                        data[index]['name']['last']),
                    subtitle: Text(data[index]['email']),
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(data[index]['picture']['thumbnail']),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  DetailPage(data[index])));
                    },
                  );
                }));
  }
}
