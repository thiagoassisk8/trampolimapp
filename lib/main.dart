import 'package:flutter/material.dart';
import 'package:trampolimApp/routes.dart';

void main() {
  runApp(new PokedeskApp());
}
// teste

class PokedeskApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.red,
          
        ),
        routes: Routes.get(),
        home: Routes.getHome());
  }
}
