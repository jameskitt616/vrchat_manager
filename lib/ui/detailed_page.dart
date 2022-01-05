import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final data;

  const DetailPage(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data['name']['first']),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: CircleAvatar(
                radius: 40.0,
                backgroundColor: Colors.pink,
                backgroundImage: NetworkImage(data['picture']['thumbnail']),
              ),
            ),
            const Divider(
              height: 40.0,
              color: Colors.grey,
            ),
            const Text(
              'NAME',
              style: TextStyle(letterSpacing: 2.0),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              data['name']['title'] +
                  " " +
                  data['name']['first'] +
                  " " +
                  data['name']['last'],
              style: const TextStyle(
                color: Colors.black,
                letterSpacing: 2.0,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(
              height: 30.0,
              color: Colors.grey,
            ),
            const Text(
              'USERNAME',
              style: TextStyle(letterSpacing: 2.0),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              data['login']['username'],
              style: const TextStyle(
                color: Colors.black,
                letterSpacing: 2.0,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(
              height: 30.0,
              color: Colors.grey,
            ),
            const Text(
              'EMAIL',
              style: TextStyle(letterSpacing: 2.0),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              data['email'],
              style: const TextStyle(
                color: Colors.black,
                letterSpacing: 2.0,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(
              height: 30.0,
              color: Colors.grey,
            ),
            const Text(
              'PHONE',
              style: TextStyle(letterSpacing: 2.0),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              data['phone'],
              style: const TextStyle(
                color: Colors.black,
                letterSpacing: 2.0,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(
              height: 30.0,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
