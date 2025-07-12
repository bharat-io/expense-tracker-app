import 'package:trackmint/data/model/category_model.dart';

class AppConstant {
  static const TOKEN_KEY = "token_key";

  static List<CategoryModel> categoryList = [
    CategoryModel(
        categoryId: 1,
        categoryName: "Coffee",
        cagtegoryImage: "assets/icons/coffee.png"),
    CategoryModel(
        categoryId: 2,
        categoryName: "FastFood",
        cagtegoryImage: "assets/icons/fast-food.png"),
    CategoryModel(
        categoryId: 3,
        categoryName: "Recharge",
        cagtegoryImage: "assets/icons/smartphone.png"),
    CategoryModel(
        categoryId: 4,
        categoryName: "Snacks",
        cagtegoryImage: "assets/icons/snack.png"),
    CategoryModel(
        categoryId: 5,
        categoryName: "Travel",
        cagtegoryImage: "assets/icons/travel.png"),
    CategoryModel(
        categoryId: 6,
        categoryName: "Petrol",
        cagtegoryImage: "assets/icons/vehicles.png"),
    CategoryModel(
        categoryId: 7,
        categoryName: "Groceries",
        cagtegoryImage: "assets/icons/shopping-bag.png"),
  ];
}
