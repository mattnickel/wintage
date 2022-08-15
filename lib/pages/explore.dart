import 'package:flutter/material.dart';
import 'package:wintage/row_widgets/product_row.dart';
import 'package:wintage/models/categories.dart';
import 'package:wintage/services/api_calls_v1.dart';
import 'package:http/http.dart' as http;


class Explore extends StatefulWidget{
  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore>{

  @override
  initState(){
    super.initState ();
  }

  @override
  Widget build(BuildContext context) {

    List<String> img = <String>['chairs1.png', 'chairs2.png', 'plants.png'];
    List<String> img2 = <String>['plants.png', 'wicker.png', 'chairs2.png'];
    List<String> img3 = <String>['clock.png', 'shelf.png', 'rattan.png'];
    return FutureBuilder<List<Category>>(
        future: getCategories(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData

                ? ListView.builder(
                padding: const EdgeInsets.only(top:40),
                itemCount: snapshot.data.length+1,
                itemBuilder: (context, index){
                  if (index < snapshot.data.length){
                    return ProductRow(category: snapshot.data[index].name);
                  }else{
                    return Container(
                        height:100
                    );
                  }
                }
            )
                : Container();
          }else{
            return Padding(
              padding: const EdgeInsets.only(top:20.0),
              child: ListView(
                children:<Widget>[
                  ProductRow(category:"Recommended Products", image:img),
                  ProductRow(category:"New Products", image:img2),
                  ProductRow(category:"On Sale Today", image:img3),

                ],
              ),
            );;
          }
        }
    );
  }

}