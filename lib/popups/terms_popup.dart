import 'package:flutter/material.dart';

AlertDialog termsPopup(title, info, context) {
  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    foregroundColor: Color(0xff00eebc),
    backgroundColor: Colors.grey[300],
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)),
    ),
  );
  return AlertDialog(
      contentPadding: EdgeInsets.only(left: 25, right: 25),
      title: Center(
        child: Padding(
          padding:EdgeInsets.only(bottom: 15),
          child: Text(
            title,
            style: TextStyle(fontSize:18,fontWeight: FontWeight.bold ),

          ),),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      content: Container(
        child: SingleChildScrollView(
            child: Column(
                children: <Widget>[
                  Container(
                    child: Text(info) ,

                  ),
                ]
            )
        ),
      ),
      actions: <Widget>[
        Container(
          width:MediaQuery.of(context).size.width,
          child: Align(
            alignment: Alignment.center,
            child:
            Container(
              width: MediaQuery.of(context).size.width * 0.60,
              child: ElevatedButton(
                child: Text(
                  'CONTINUE',

                ),
                style: raisedButtonStyle,
                onPressed: () {
                  //saveIssue();
                  Navigator.of(context).pop();
                },
              ),
            ),

          ),
        ),
      ]
  );

}