import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wintage/models/product.dart';

class ProductTiles extends StatefulWidget {

  List<Product> product;
  int index;

  ProductTiles({ required this.product, required this.index});

  @override
  _ProductTilesState createState() => _ProductTilesState();
}
class _ProductTilesState extends State<ProductTiles> {
  bool favorite = false;
  bool localFavorite = false;
  bool localFalse =  true;



  @override
  initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    final singleProduct= widget.product[widget.index];
    int price= singleProduct.price;

    switchFavorite(){
      if (favorite == true){
        favorite = false;
        print("off");
      }else {
        favorite = true;
        print("on");
      }
    }
    return Wrap(
      children: <Widget>[
        Container(
            margin: const EdgeInsets.all(10.0),
            height:200,
            width: 200,
            child: Stack(
              children: <Widget>[
                ClipRRect(
                    borderRadius: BorderRadius.circular(18.0),
                    child:
                    Image.network(singleProduct.primaryImage,
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                      color: Colors.black38,
                      colorBlendMode: BlendMode.darken,)
                ),
                Positioned(
                  bottom: 50,
                  left:10,
                  child: Text(
                      singleProduct.name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white)
                  ),
                ),
                Positioned(
                  bottom: 30,
                  left:10,
                  child: Text(
                     "\$" + price.toString(),
                      style: TextStyle(
                        color: Colors.white,
                      )
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: favorite

                  ? IconButton(
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      switchFavorite();
                      setState(() {
                      });
                    },
                    )
                      : IconButton(
                    icon: const Icon(
                      Icons.favorite_outline,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      switchFavorite();
                      setState(() {
                      });
                    },
                  )
                  ),

              ],
            )
        )
      ],
    );
  }
}