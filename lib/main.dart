import 'package:flutter/material.dart';
import 'package:trampolimApp/routes.dart';
import 'package:trampolimApp/theme.dart';

void main() {
  runApp(new PokedeskApp());
}

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
