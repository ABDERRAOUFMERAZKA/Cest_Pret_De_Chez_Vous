import 'package:flutter/material.dart';

import '../styles.dart';

import '../src/home.dart';
import '../src/favorite.dart';
import '../src/search.dart';
import '../src/my_ad.dart';
import '../src/menu.dart';

class Tabs extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  // init list of tabsbar
  final List<Map<String, Object>> _listTabsbar = [
    {
      'title': 'Home',
      'body': Home(),
      'icon': Icons.home,
      'icon_name': 'Home',
    },
    {
      'title': 'Favorite',
      'body': Favorite(),
      'icon': Icons.favorite,
      'icon_name': 'Favorite',
    },
    {
      'title': 'Add',
      'body': Search(),
      'icon': Icons.add,
      'icon_name': 'Add',
    },
    {
      'title': 'MyAd',
      'body': MyAd(),
      'icon': Icons.stars,
      'icon_name': 'MyAd',
    },
    {
      'title': 'Menu',
      'body': Menu(),
      'icon': Icons.menu,
      'icon_name': 'Menu',
    },
  ];
  // init index of tabsbar
  int _indexTabsbar = 0;
  // select a tabs
  void _selectTabsbar(index) {
    setState(() {
      _indexTabsbar = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final AppBar appBar = AppBar(
      title:
          Text(_listTabsbar[_indexTabsbar]['title'], style: Styles.navBarTitle),
    );
    return Scaffold(
        appBar: appBar,
        body: Container(
          height:
              MediaQuery.of(context).size.height - appBar.preferredSize.height,
          child: _listTabsbar[_indexTabsbar]['body'],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _indexTabsbar,
          type: BottomNavigationBarType.fixed,
          onTap: _selectTabsbar,
          items: [
            for (final e in _listTabsbar)
              BottomNavigationBarItem(
                icon: Icon(e['icon']),
                title: Text(e['icon_name']),
              ),
          ],
        ));
  }
}
