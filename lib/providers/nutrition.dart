import 'package:flutter/material.dart';

class Nutrition with ChangeNotifier {
  late int _kcal;
  late int _carbohydrate;
  late int _protein;
  late int _fat;

  int get kcal => _kcal;
  int get carbohydrate => _carbohydrate;
  int get protein => _protein;
  int get fat => _fat;

  setData(int kcal, int carbohydrate, int protein, int fat) {
    _kcal = kcal;
    _carbohydrate = carbohydrate;
    _protein = protein;
    _fat = fat;
    notifyListeners();
  }
} 