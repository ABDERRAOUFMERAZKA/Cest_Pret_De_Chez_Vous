import 'package:cest_pret_de_chez_vous/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/tag.dart';

import '../view_model/display_ads_view_model.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String category = '--';
  var keywords = [];
  final keywordsController = TextEditingController();

  @override
  void initState() {
    super.initState();

    keywordsController.addListener(_onVerifierChanged);
  }

  void _onVerifierChanged() {
    setState(() {
      keywords = keywordsController.text.split(" ");
    });
  }

  void _search() {
    print(keywords);
    print(category);
  }

  Widget build(BuildContext context) {
    print("context: ${context.toString()}");
    var dropDownItems = [category, "books"];
    final AppBar appBar = AppBar(
      title: Text('Search', style: Styles.navBarTitle),
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Category', style: Styles.mediumText),
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
                  items: dropDownItems.map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(
                        value,
                      ),
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
              Text('Keywords', style: Styles.mediumText),
              Text('(maximum 3)', style: Styles.textDefault),
              SizedBox(
                height: 15.0,
              ),
              Tags(
                textField: TagsTextField(
                    autofocus: true,
                    width: 250,
                    textStyle: Styles.textDefault,
                    onSubmitted: (var str) {
                      if (keywords.length < 3) {
                        setState(() {
                          keywords.add(str);
                        });
                      }
                    }),
                direction: Axis.vertical,
                itemCount: keywords.length,
                itemBuilder: (int index) {
                  final item = keywords[index];
                  return ItemTags(
                    singleItem: true,
                    color: Colors.orangeAccent,
                    textColor: Colors.white,
                    index: index, // required
                    key: Key(index.toString()),
                    title: item,
                    removeButton: ItemTagsRemoveButton(),
                    onRemoved: () {
                      setState(() {
                        keywords.removeAt(index);
                      });
                    },
                    textStyle: TextStyle(
                      fontSize: 14,
                    ),
                  );
                },
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
          )),
    );
  }
}
