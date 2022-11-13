import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './side_menu/side_menu.dart';
import 'models/navbar_selected_model.dart';

class Framework extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NavbarTabSelectedModel>(
      create: (context) => NavbarTabSelectedModel(),
      child: Consumer<NavbarTabSelectedModel>(
        builder: (context, model, child) =>
            SafeArea(
                child: Scaffold(
                  appBar: AppBar(
                    title: Image.asset('assets/images/wintage_logo.png', fit: BoxFit.cover),
                    backgroundColor: const Color(0xffD3A898),
                  ),
                  drawer: SideMenu(),
                  bottomNavigationBar: Material(
                    color : const Color(0xffD3A898),
                    child:
                      BottomNavigationBar(
                        onTap: (int _index){
                          model.currentTab = _index;
                        },
                        items: const <BottomNavigationBarItem>[
                          BottomNavigationBarItem(
                              icon: Icon(Icons.home),
                              label: 'Home',
                          ),
                          BottomNavigationBarItem(
                               icon: Icon(Icons.shopping_bag ),
                              label: 'Shop',
                          ),
                          BottomNavigationBarItem(
                              icon: Icon(Icons.favorite),
                              label: 'Favorites',
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.message),
                            label: 'Message',
                          ),
                        ],
                        fixedColor: Colors.white,
                        backgroundColor: const Color(0xffD3A898),
                        unselectedItemColor: Colors.grey[800],
                        currentIndex: (model.currentTab),
                        type: BottomNavigationBarType.fixed ,
                      ),
                  ),
                  body: model.currentScreen,
                  extendBody: true,
                )
            ),
      ),
    );
  }
}