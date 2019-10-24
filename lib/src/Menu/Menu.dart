import 'package:flutter/material.dart';
import '../Login/widget/Login.dart';

class Menu extends StatelessWidget {
  final bool _isUserConnected = false;
  @override
  Widget build(BuildContext context) {
    return ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              if(_isUserConnected)UserAccountsDrawerHeader(
                accountName: Text('UserName'),
                accountEmail: Text('userMail@gmail.com'),
                currentAccountPicture:
                Image.network('http://icons.iconarchive.com/icons/icons8/android/512/Users-User-icon.png'),
                decoration: BoxDecoration(color: Colors.deepOrange),
              ),
              if(_isUserConnected)ListTile(
                leading: Icon(Icons.history),
                title: Text('Historique'),
                onTap: () { /* ... */ },
              ),
              Divider(
                height: 2.0,
              ),
              ListTile(
                leading: Icon(Icons.help),
                title: Text('Help'),
                onTap: () { /* ... */ },
              ),
              Divider(
                height: 2.0,
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () { /* ... */ },
              ),
              Divider(
                height: 2.0,
              ),
              _isUserConnected ? ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Logout'),
                onTap: () { /* ... */ },
              ) : ListTile(
                leading: Icon(Icons.people),
                title: Text('Login'),
                onTap: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FirstRoute()),
                );},
              )
            ],
          );
  }
}