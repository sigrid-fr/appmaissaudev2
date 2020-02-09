import 'package:flutter/material.dart';
import 'pageinicial.dart';

class PageMaterial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Mais Saúde',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home:PageInicial()
    );
  }
}