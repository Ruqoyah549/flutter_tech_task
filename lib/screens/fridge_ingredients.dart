import 'package:bitnob_tech_task/screens/recipe_screen.dart';
import 'package:bitnob_tech_task/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

class FridgeIngredients extends StatefulWidget {
  @override
  _FridgeIngredientsState createState() => _FridgeIngredientsState();
}

class _FridgeIngredientsState extends State<FridgeIngredients> {
  bool _isLoading = false;

  var ingredient = [];
  var _selectedIngredients = [];
  var _items;

  _getFridgeIngredient() async {
    setState(() {
      _isLoading = true;
    });
    await ApiServices().getFridgeIngredient().then((response) {
      ingredient = response;
      _items = ingredient
          .map((item) => MultiSelectItem(item.title, item.title))
          .toList();
      setState(() {
        _isLoading = false;
      });
    });
  }

  void _showMultiSelect(BuildContext context) async {
    await showModalBottomSheet(
      isScrollControlled: true, // required for min/max child size
      context: context,
      builder: (ctx) {
        return MultiSelectBottomSheet(
          title: Text(
            "Select Ingredients",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
          onConfirm: (val) {
            _selectedIngredients = val;
            print("Final Selected Ingredient = $val");
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => RecipeScreen(val)));
          },
          initialChildSize: 0.7,
          items: _items,
          initialValue: _selectedIngredients,
          maxChildSize: 0.8,
          minChildSize: 0.7,
        );
      },
    );
  }

  @override
  void initState() {
    _getFridgeIngredient();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Fridge Ingredients"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RaisedButton(
                      onPressed: () {
                        _showMultiSelect(context);
                      },
                      child: Text("Open Fridge"),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
