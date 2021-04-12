import 'package:bitnob_tech_task/screens/fridge_ingredients.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lunch Recipes',
      theme: ThemeData(
        primaryColor: Colors.amber,
        accentColor: Colors.amber,
      ),
      home: FridgeIngredients(),
    );
  }
}
