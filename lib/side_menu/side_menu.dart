import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  final _titleName = "home";
  final _username = "Profile";
  Function _doSomething(){
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children:<Widget>[
          ListTile(
            leading: Icon(Icons.portrait_rounded),
            title: Text("Profile"),
            onTap: (){
              _doSomething();
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.circle_notifications),
            title: Text("Notifications"),
          ),
          ListTile(
            leading: Icon(Icons.hail),
            title: Text('Payment Info'),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
          ),

        ],
      ) ,
    );
  }
}