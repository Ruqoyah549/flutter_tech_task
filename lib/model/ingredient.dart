class Ingredient {
  String title;
  String useBy;

  Ingredient({this.title, this.useBy});

  Ingredient.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    useBy = json['use-by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['use-by'] = this.useBy;
    return data;
  }
}
