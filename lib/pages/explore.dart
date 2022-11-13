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
  late Future<List<Category>> _categories;

  @override
  initState(){
    super.initState ();
     _categories= getCategories(http.Client());
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<List<Category>>(
        future: _categories,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? ListView.builder(
                padding: const EdgeInsets.only(top:40),
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index){
                  if (index < snapshot.data!.length+1){
                    return ProductRow(category: snapshot.data![index].name);
                  }else{
                    return Container(
                        height:100
                    );
                  }
                }
            )
                : Container();
          }else{
            return Center(
              child:Text("Nothing to see here")
            );
          }
        }
    );
  }

}