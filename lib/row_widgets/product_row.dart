import 'package:flutter/material.dart';
import 'package:wintage/widgets/product_tiles.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import '../services/api_calls_v1.dart';
import '../models/product.dart';

class ProductRow extends StatelessWidget {
  String category;
  List<String> image;
  int index;

  ProductRow({ this.category, this.image, this.index});
  @override
  Widget build(BuildContext context) {
    return
      FutureBuilder<List<Product>>(
        future: fetchProducts(http.Client(), category, context),
    builder: (context, snapshot) {

    if(snapshot.connectionState == ConnectionState.done) {

    if(snapshot.hasError)print(snapshot.error);

    return snapshot.hasData
      ? Wrap(
          children: <Widget>[
            Row(children: [
              Container(
                margin: EdgeInsets.only(left: 20.0, bottom:10.0),
                child: Text(
                    category,
                    style: TextStyle(
                      fontSize: 18,
                    )
                ),
              ),
              Spacer(),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(bottom:3.0),
                  child: Icon(
                    Icons.chevron_right,

                  ),
                ),
              ),
            ],),
            Container(
                margin: EdgeInsets.only(left: 10.0, bottom:30.0),
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data == null ? 0 : snapshot.data.length,
                  itemBuilder: (context, index) {
                    return ProductTiles(
                      product: snapshot.data,
                      index: index,
                    );
                  },
                )
            )
          ]
      )
        : Center(child: Text("No products found"));
  }
    else
      return
        Wrap(
            children: <Widget>[
              Row(children: [
                Container(
                  margin: EdgeInsets.only(left: 20.0, bottom:10.0),
                  child: Text(
                      category,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      )
                  ),
                ),
                Spacer(),
                Container(
                  margin: EdgeInsets.only(right: 10.0),
                  child: Icon(
                    Icons.chevron_right,
                    color: Color(0xFF00ebcc),
                  ),
                ),
              ],),
              Container(
                  margin: EdgeInsets.only(left: 10.0, bottom:30.0),
                  height: 200,
                  width: 330,
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Container(
                            margin: const EdgeInsets.all(10.0),
                            height: 365,
                            width: 300,
                            child: Stack(
                                children: <Widget>[
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(18.0),
                                      child: Shimmer.fromColors(
                                          baseColor: Colors.black54,
                                          highlightColor: Colors.black45,
                                          child: Container(
                                              color: Colors.black54
                                          )
                                      )
                                  )
                                ]
                            )
                        )

                      ]
                  )
              )
            ]
        );
    },
      );
  }
}