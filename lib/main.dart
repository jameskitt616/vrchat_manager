import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VRChat Manager',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: Home(),
    );
  }
}

// class User {
//   final int id;
//   final int userId;
//   final String title;
//   final String body;
//
//   User({
//     required this.id,
//     required this.userId,
//     required this.title,
//     required this.body,
//   });
// }

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
// //Applying get request.
//
//   Future<List<User>> getRequest() async {
//     //replace your restFull API here.
//     String url = 'https://jsonplaceholder.typicode.com/posts';
//     final response = await http.get(Uri.parse(url));
//
//     var responseData = json.decode(response.body);
//
//     //Creating a list to store input data;
//     List<User> users = [];
//     for (var singleUser in responseData) {
//       User user = User(
//           id: singleUser["id"],
//           userId: singleUser["userId"],
//           title: singleUser["title"],
//           body: singleUser["body"]);
//
//       //Adding user to the list.
//       users.add(user);
//     }
//     return users;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Home'),
//           leading: Icon(
//             Icons.get_app,
//           ),
//         ),
//         body: Container(
//           padding: EdgeInsets.all(10),
//           child: FutureBuilder(
//             future: getRequest(),
//             builder: (BuildContext ctx, AsyncSnapshot snapshot) {
//               if (snapshot.data == null) {
//                 return Container(
//                   child: Center(
//                     child: CircularProgressIndicator(),
//                   ),
//                 );
//               } else {
//                 return ListView.builder(
//                   itemCount: snapshot.data.length,
//                   itemBuilder: (ctx, index) => ListTile(
//                     title: Text(snapshot.data[index].title),
//                     subtitle: Text(snapshot.data[index].body),
//                     contentPadding: EdgeInsets.only(bottom: 10),
//                   ),
//                 );
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }


class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String url = 'https://randomuser.me/api/?results=20';
  List data = [];
  bool _isDataLoading = true;

  Future<List> _getUsers() async{

    var response = await http.get(Uri.parse(url),
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
            ? const Center(
            child: CircularProgressIndicator()
        )
            : ListView.builder(
            itemCount: data.length,
            itemBuilder: (BuildContext context, index){
              return ListTile(
                title: Text(data[index]['name']['first']+" "+data[index]['name']['last']),
                subtitle: Text(data[index]['email']),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(data[index]['picture']['thumbnail']),
                ),
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context)=> DetailPage(data[index])));
                },
              );
            }
        )
    );
  }
}

class DetailPage extends StatelessWidget {
  final data;
  DetailPage(this.data);
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
                backgroundImage: NetworkImage(
                    data['picture']['thumbnail']),
              ),
            ),
            const Divider(
              height: 40.0,
              color: Colors.grey,
            ),
            const Text(
              'NAME',
              style: TextStyle(
                  letterSpacing: 2.0
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              data['name']['title'] +" "+ data['name']['first'] + " "+ data['name']['last'],
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
              style: TextStyle(
                  letterSpacing: 2.0
              ),
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
              style: TextStyle(
                  letterSpacing: 2.0
              ),
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
              style: TextStyle(
                  letterSpacing: 2.0
              ),
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
