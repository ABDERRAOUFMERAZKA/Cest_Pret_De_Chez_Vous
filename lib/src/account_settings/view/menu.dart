import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Menu extends StatelessWidget {
  void _testDataBase() {
    Firestore.instance
        .collection('books')
        .document()
        .setData({'title': 'title', 'author': 'author'});
  }

  Widget build(BuildContext context) {
    logOut() {
      FirebaseAuth.instance.signOut();
    }

    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text('UserName'),
          accountEmail: Text('userMail@gmail.com'),
          currentAccountPicture: Image.network(
              'http://icons.iconarchive.com/icons/icons8/android/512/Users-User-icon.png'),
          decoration: BoxDecoration(color: Colors.deepOrange),
        ),
        ListTile(
          leading: Icon(Icons.history),
          title: Text('Historique'),
          onTap: _testDataBase,
        ),
        Divider(
          height: 2.0,
        ),
        ListTile(
          leading: Icon(Icons.help),
          title: Text('Help'),
          onTap: () {/* ... */},
        ),
        Divider(
          height: 2.0,
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Settings'),
          onTap: () {/* ... */},
        ),
        Divider(
          height: 2.0,
        ),
        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text('Logout'),
          onTap: () => logOut(),
        )
      ],
    );
  }
}