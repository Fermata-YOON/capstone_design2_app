//import 'dart:collection';
import 'package:flutter/material.dart';
//import 'package:table_calendar/table_calendar.dart';
//import 'package:intl/intl.dart';
class Event {
  late String title;

  Event(this.title);

  @override
  String toString() => title;
}

class History with ChangeNotifier {

  late List<String> _foodName = List.empty(growable: true);
  late List<double> _foodAmount = List.empty(growable: true);
  late List<double> _foodTotal = List.empty(growable: true);
  late List<String> _foodDate = List.empty(growable: true);

  final Map<DateTime, List<Event>> _events = {};

  late int _length;

  List get foodName => _foodName;
  List get foodAmount => _foodAmount;
  List get foodTotal => _foodTotal;
  List get foodDate => _foodDate;
  int get length => _length;

  Map<DateTime, List<Event>> get events => _events;


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
    setEvents();
    notifyListeners();
  }

  set setLength(int value) {
    _length = value;

    notifyListeners();
  }
   
  setEvents() {
    _events.clear();
     for(int i=0; i<_foodDate.length; i++) {
      List date = _foodDate[i].split('-');
      if (_events[DateTime.utc(int.parse(date[0]), int.parse(date[1]), int.parse(date[2]))] == null) {
        _events.addAll({        
          DateTime.utc(int.parse(date[0]), int.parse(date[1]), int.parse(date[2])) : [Event(_foodName[i])]
        });
      } else {
        _events[DateTime.utc(int.parse(date[0]), int.parse(date[1]), int.parse(date[2]))]?.add(Event(_foodName[i]));
      }
     }
    notifyListeners();
  }
 }