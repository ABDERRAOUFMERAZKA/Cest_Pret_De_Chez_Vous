import 'package:firebase_auth/firebase_auth.dart'; // This import is only to use FirebaseUser class
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/login_view_model.dart';

class Menu extends StatelessWidget {
  Widget build(BuildContext context) {
    LoginViewModel viewModel = Provider.of<LoginViewModel>(context);
    FirebaseUser currentUser = viewModel.currentUser;

    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text('${currentUser.displayName}'),
          accountEmail: Text('${currentUser.email}'),
          currentAccountPicture: Image.network(
              'http://icons.iconarchive.com/icons/icons8/android/512/Users-User-icon.png'),
          decoration: BoxDecoration(color: Colors.deepOrange),
        ),
        ListTile(
          leading: Icon(Icons.history),
          title: Text('History'),
          onTap: () {/* ... */},
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
          onTap: viewModel.signOut,
        )
      ],
    );
  }
}
