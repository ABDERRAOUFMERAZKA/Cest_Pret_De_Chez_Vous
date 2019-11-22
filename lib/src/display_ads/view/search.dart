import 'package:cest_pret_de_chez_vous/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/tag.dart';
import 'package:provider/provider.dart';

import '../view_model/display_ads_view_model.dart';

class Search extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Search> {
  String category = '--';
  bool isFullKeyWords = false;
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
    var provider = Provider.of<DisplayAdsViewModel>(context);
    provider.getCategories();
    var dropDownItems = provider.categories;
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
                      if (keyWords.length == 2) {
                        setState(() {
                          isFullKeyWords = true;
                        });
                      }
                      if (keyWords.length < 3) {
                        setState(() {
                          keyWords.add(str);
                        });
                      }
                    }),
                direction: Axis.vertical,
                itemCount: keyWords.length,
                itemBuilder: (int index) {
                  final item = keyWords[index];
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
                        keyWords.removeAt(index);
                        isFullKeyWords = false;
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
