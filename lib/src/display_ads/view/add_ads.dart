import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:cest_pret_de_chez_vous/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/tag.dart';
import 'package:provider/provider.dart';

import '../view_model/display_ads_view_model.dart';

class Add extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<Add> {
  String category = '--';
  String description = '';
  String title = '';
  var keyWords = [];
  File _imageFile;
  List picturesName = new List();
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

  onImageButtonPressed(ImageSource source) async {
    try {
      _imageFile = await ImagePicker.pickImage(source: source);
      setState(() {
        picturesName.add(_imageFile);
      });
    } catch (e) {
      return e.toString();
    }
  }

  removePicture(item) {
    setState(() {
      picturesName.remove(item);
    });
  }

  void _add() {
    print(keyWords);
    print(category);
    print(description);
    print(title);
    print(picturesName);
  }

  Widget build(BuildContext context) {
    var provider = Provider.of<DisplayAdsViewModel>(context);
    var dropDownItems = provider.categories;
    final descriptionField = TextFormField(
      obscureText: false,
      maxLines: 5,
      onChanged: (input) => description = input,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Description",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final titleField = TextFormField(
      obscureText: false,
      onChanged: (input) => title = input,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Title",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Title', style: Styles.mediumText),
          SizedBox(
            height: 15.0,
          ),
          titleField,
          SizedBox(
            height: 15.0,
          ),
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
          Text('Description', style: Styles.mediumText),
          SizedBox(
            height: 15.0,
          ),
          descriptionField,
          SizedBox(
            height: 15.0,
          ),
          Text('Add pictures', style: Styles.mediumText),
          if (picturesName != null)
            for (var item in picturesName)
              Flexible(
                child: Row(
                  children: <Widget>[
                    Image.file(item, width: 200, height: 200),
                    InkWell(
                      child: Icon(Icons.delete),
                      onTap: () => removePicture(item),
                    ),
                  ],
                ),
              ),
          SizedBox(
            height: 15.0,
          ),
          FloatingActionButton(
            onPressed: () => onImageButtonPressed(ImageSource.gallery),
            heroTag: 'image0',
            tooltip: 'Pick Image from gallery',
            child: const Icon(Icons.add_a_photo),
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
              onPressed: _add,
              child: Text('Add',
                  textAlign: TextAlign.center,
                  style: Styles.mediumText.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          )
        ],
      ),
    );
  }
}
