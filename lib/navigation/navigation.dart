import 'package:flutter/material.dart';

import '../src/display_ads/view/add_ads.dart';
import '../src/display_ads/view/favorites.dart';
import '../src/display_ads/view/home.dart';
import '../src/display_ads/view/my_ads.dart';
import '../src/display_ads/view/search.dart';
import '../src/menu/menu.dart';

import '../styles.dart';

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
      'title': 'Favorites',
      'body': Favorites(),
      'icon': Icons.favorite,
      'icon_name': 'Favorites',
    },
    {
      'title': 'Add',
      'body': Add(),
      'icon': Icons.add,
      'icon_name': 'Add',
    },
    {
      'title': 'My Ads',
      'body': MyAd(),
      'icon': Icons.stars,
      'icon_name': 'My Ads',
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
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Search()),
            );
          },
        ),
      ],
    );
    return Scaffold(
      backgroundColor: Color.fromRGBO(230, 230, 230, 1),
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
      ),
    );
  }
}
