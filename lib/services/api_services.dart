import 'dart:convert';

import 'package:bitnob_tech_task/model/ingredient.dart';
import 'package:bitnob_tech_task/model/recipe.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  final baseUrl =
      "https://lb7u7svcm5.execute-api.ap-southeast-1.amazonaws.com/dev";

  final headers = {
    "Content-type": "application/json",
    "Accept": "application/json"
  };

  // get fridge ingredient
  getFridgeIngredient() async {
    var fullUrl = baseUrl + '/ingredients';

    http.Response response = await http.get(fullUrl, headers: headers);

    if (response.statusCode == 200) {
      var data = json.decode(response.body); // decode json
      var ingredients =
          data.map((job) => new Ingredient.fromJson(job)).toList();
      return ingredients;
    } else {
      return [];
    }
  }

  // get recipe
  getRecipe(var ingredientList) async {
    var fullUrl = baseUrl + '/recipes?ingredients=$ingredientList';

    http.Response response = await http.get(fullUrl, headers: headers);

    if (response.statusCode == 200) {
      var data = json.decode(response.body); // decode json
      var recipe = data.map((job) => new Recipe.fromJson(job)).toList();
      return recipe;
    } else {
      return [];
    }
  }
}
