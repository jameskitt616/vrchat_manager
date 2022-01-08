import 'package:flutter/material.dart';

import 'temp/friend_requests.dart';
// import 'online_friends.dart';
// import 'settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    // OnlineFriendsPage(),
    FriendRequestsPage(),
    FriendRequestsPage(),
    FriendRequestsPage(),
    // SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Online Friends',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add),
            label: 'Friend Requests',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dehaze),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        // selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
