import 'package:bitnob_tech_task/services/api_services.dart';
import 'package:flutter/material.dart';

class RecipeScreen extends StatefulWidget {
  final ingredientList;

  RecipeScreen(this.ingredientList);
  @override
  _RecipeScreenState createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  bool _isLoading = false;

  String ingredients;

  var recipe = [];

  _getRecipe() async {
    setState(() {
      _isLoading = true;
    });
    ingredients = widget.ingredientList.reduce((value, element) {
      return value + "," + element;
    });
    print(ingredients);
    await ApiServices().getRecipe(ingredients).then((response) {
      recipe = response;
      print("Recipe List = $recipe");
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void initState() {
    _getRecipe();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recipe"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Selected Ingredients from Fridge are: ",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "$ingredients",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 30),
                  Expanded(
                    child: ListView.builder(
                      itemCount: recipe.length,
                      itemBuilder: (context, index) {
                        print(recipe[index].ingredients);
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              recipe[index].title,
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Flexible(
                              child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: recipe[index].ingredients.length,
                                itemBuilder: (context, item) {
                                  return Text(
                                    recipe[index].ingredients[item],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 30),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
