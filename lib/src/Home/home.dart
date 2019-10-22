import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                leading: Icon(Icons.notifications_active),
                title: Text('Aléatoire annonce'),
                subtitle: Text('Annonce by UserName. publiée le 10/10/19.'),
              ),
              ButtonTheme( // make buttons use the appropriate styles for cards
                child: ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      child: const Text('VOIR DETAILS'),
                      onPressed: () { /* ... */ },
                    ),
                    FlatButton(
                      child: const Text('Ajouter Au favoris'),
                      onPressed: () { /* ... */ },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}