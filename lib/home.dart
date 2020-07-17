import 'package:flutter/material.dart';
import 'package:wintage/search.dart';

import './side_menu/side_menu.dart';


class MyHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('images/wintage_logo.png', fit: BoxFit.cover),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(),
              );
            },
          ),
        ],
      ),
      drawer: SideMenu(),
      body: Center(),
    );
  }


}