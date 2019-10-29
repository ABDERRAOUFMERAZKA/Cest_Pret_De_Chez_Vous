import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../login_value.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    logOut() {
      Provider.of<LoginValue>(context, listen: false).updateIsLogged(false);
      Provider.of<LoginValue>(context, listen: false).updateClient(null);
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
          onTap: () => logOut(),
        )
      ],
    );
  }
}
