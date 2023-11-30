import 'package:flutter/material.dart';

class Nutrition with ChangeNotifier {
  late int _kcal;
  late int _carbohydrate;
  late int _protein;
  late int _fat;

  late int _carboRate;
  late int _proteinRate;
  late int _fatRate;

  int get kcal => _kcal;
  int get carbohydrate => _carbohydrate;
  int get protein => _protein;
  int get fat => _fat;

  int get carboRate => _carboRate;
  int get proteinRate => _proteinRate;
  int get fatRate => _fatRate;

  setData(int kcal, int carbohydrate, int protein, int fat) {
    _kcal = kcal;
    _carbohydrate = carbohydrate;
    _protein = protein;
    _fat = fat;
    notifyListeners();
  }

  setRate(int carboRate, int proteinRate, int fatRate) {
    _carboRate = carboRate;
    _proteinRate = proteinRate;
    _fatRate = fatRate;

    notifyListeners();
  }
} 