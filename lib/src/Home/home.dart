import 'package:flutter/material.dart';

import '../../styles.dart';

class Home extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Home> {
  String category = 'Cat1';
  var keyWords = [];

  final keyWordsController = TextEditingController();

  @override
  void initState() {
    super.initState();

    keyWordsController.addListener(_onVerifierChanged);
  }

  void _onVerifierChanged() {
    setState(() {
      keyWords = keyWordsController.text.split(" ");
    });
  }

  void _search() {
    print(keyWords);
    print(category);
  }
  
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Categorie', style: Styles.mediumText),
          SizedBox(
            height: 15.0,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.0),
                border: Border.all(color: Colors.deepOrange)),
            child: DropdownButton<String>(
              isExpanded: true,
              items:  <String>['Cat1', 'Cat2', 'Cat3', 'Cat4'].map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value, ),
                );
              }).toList(),
              value: category,
              onChanged: (String value) {
                setState(() {
                  category = value;
                });
              },
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Text('Mots-Clefs', style: Styles.mediumText),
          SizedBox(
            height: 15.0,
          ),
          TextField(
            maxLines: 8,
            decoration: InputDecoration(hintText: "Tapez les mots clefs ici..", border: OutlineInputBorder(),
              labelText: 'Mots Clefs'),
            controller: keyWordsController,
            onEditingComplete: _search,
          ),
          SizedBox(
            height: 15.0,
          ),
          Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(30.0),
            color: Colors.deepOrange,
            child: MaterialButton(
              minWidth: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              onPressed: _search,
              child: Text('Search',
                  textAlign: TextAlign.center,
                  style: Styles.mediumText.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          )
      ],
    ));
  }
}
