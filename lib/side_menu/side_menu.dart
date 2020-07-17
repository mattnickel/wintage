import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  final _titleName = "home";
  Function _doSomething(){
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children:<Widget>[
          ListTile(
            leading: Icon(Icons.home),
            title: Text(_titleName),
            onTap: (){
              _doSomething();
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text(_titleName),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('home'),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('home'),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('home'),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('home'),
          ),
        ],
      ) ,
    );
  }
}