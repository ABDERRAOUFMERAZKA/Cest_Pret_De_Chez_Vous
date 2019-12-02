import 'package:cest_pret_de_chez_vous/styles.dart';
import 'package:cest_pret_de_chez_vous/utils/enum_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/tag.dart';

import '../../../category.dart';

class FilterPopUp {
  static Future<Map<String, dynamic>> showFilterPopup(
      BuildContext context) async {
    return await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => _FilterDialog(),
    );
  }
}

class _FilterDialog extends StatefulWidget {
  @override
  _FilterDialogState createState() => _FilterDialogState();
}

class _FilterDialogState extends State<_FilterDialog> {
  Category category;
  List<String> keyWords = [];
  String orderBy = "first";

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

  Widget build(BuildContext context) {
    List<Category> categoryDropDownItems = [null, ...Category.values];

    return AlertDialog(
      title: Text(
        "Filter ads by:",
        style: Styles.headerLarge,
      ),
      content: Scrollbar(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Category', style: Styles.mediumText),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                    border: Border.all(color: Colors.deepOrange)),
                child: DropdownButton<Category>(
                  isExpanded: true,
                  items: categoryDropDownItems.map((Category category) {
                    return new DropdownMenuItem<Category>(
                      value: category,
                      child: new Text(
                        EnumToString.parseCamelCase(category) ?? '--',
                      ),
                    );
                  }).toList(),
                  value: category,
                  onChanged: (Category value) {
                    setState(() {
                      category = value;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(children: <Widget>[
                Text('Keywords', style: Styles.mediumText),
                Text('(maximum 3)', style: Styles.textDefault),
              ]),
              Tags(
                itemCount: keyWords.length,
                itemBuilder: (int index) {
                  final item = keyWords[index];
                  return ItemTags(
                    singleItem: true,
                    color: Colors.white,
                    textColor: Colors.black,
                    index: index, // required
                    key: Key(index.toString()),
                    title: item,
                    removeButton: ItemTagsRemoveButton(),
                    onRemoved: () {
                      setState(() {
                        keyWords.removeAt(index);
                      });
                    },
                    textStyle: TextStyle(
                      fontSize: 14,
                    ),
                  );
                },
                textField: TagsTextField(
                  autofocus: false,
                  width: 250,
                  textStyle: Styles.textDefault,
                  onSubmitted: (var str) {
                    if (keyWords.length < 3) {
                      setState(() {
                        keyWords.add(str);
                      });
                    }
                  },
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  FlatButton(
                    color: Colors.deepOrange,
                    textColor: Colors.white,
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    color: Colors.deepOrange,
                    textColor: Colors.white,
                    child: Text('Ok'),
                    onPressed: () {
                      Navigator.of(context).pop({
                        "category": category,
                        "keyWords": keyWords,
                        "orderBy": orderBy,
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
