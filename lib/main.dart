import 'package:flutter/material.dart';
import 'package:testing/second.dart';
import 'package:testing/first.dart';


void main() {
  runApp(MaterialApp(
    theme:ThemeData(
      primarySwatch: Colors.cyan
    ),

    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/':(context)=>First(),
      '/second':(context)=>Second(),
    },
  ));
}

