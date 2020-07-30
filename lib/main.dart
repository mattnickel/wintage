import 'package:flutter/material.dart';
import 'framework.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: const Color(0xffD3A898),
        accentColor: const Color(0xffE0D5CB),

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Framework(),
    );
  }
}

