import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';

class History with ChangeNotifier {

  late List<String> _foodName = List.empty(growable: true);
  late List<double> _foodAmount = List.empty(growable: true);
  late List<double> _foodTotal = List.empty(growable: true);
  late List<String> _foodDate = List.empty(growable: true);

  late String _msg;
  late int _length;

  List get foodName => _foodName;
  List get foodAmount => _foodAmount;
  List get foodTotal => _foodTotal;
  List get foodDate => _foodDate;
  String get msg => _msg;
  int get length => _length;

  set setList(List value) {
    _foodName = List.filled(value.length, "");
    _foodAmount = List.filled(value.length, 0);
    _foodTotal = List.filled(value.length, 0);
    _foodDate = List.filled(value.length, "");
     
    for(int i=0; i<value.length; i++) {
      _foodName[i] = value[i]['name'];
      _foodAmount[i] = value[i]['amount'];
      _foodTotal[i] = value[i]['total'];
     _foodDate[i] = value[i]['date'];
    } 

    notifyListeners();
  }

  set setMsg(value) {
    _msg = value;

    notifyListeners();
  }

  set setLength(int value) {
    _length = value;

    notifyListeners();
  }
}