import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';

class User with ChangeNotifier {
  late String _id;
  late String _pw;
  late String _name;
  late String _type;
  late String _sex;
  late int _act;
  late int _age;
  late int _height;
  late int _weight;

  String get id => _id;
  String get pw => _pw;
  String get name => _name;
  String get sex => _sex;
  String get type => _type;
  int get act => _act;
  int get age => _age;
  int get height => _height;
  int get weight => _weight;
  
  String get viewSex {
    if(_sex == "M") {
      return "남";
    } else {
      return "여자";
    }
  }

  String get viewType {
    if(_type == "N") {
      return "일반인";
    } if(_type == "H") {
      return "운동인";
    } else {
      return "다이어터";
    }
  }

  String convertHash(String password) {
    const uniqueKey = 'CapDi2';
    final bytes = utf8.encode(password+uniqueKey);
    final hash = sha256.convert(bytes);
    return hash.toString();
  }


  writeAccount(String id, String pw) {
    _id = id;
    _pw = convertHash(pw);
    notifyListeners();
  }

  writeUser(String name, String sex, String type, int age, int height, int weight, int act) {
    _name = name;
    _type = type;
    _sex = sex;
    _age = age;
    _height = height;
    _weight = weight;
    _act = act;
    notifyListeners();
  }

  setUser(String id, String name, String sex, String type, int age, int height, int weight, int act) {
    _id = id;
    _name = name;
    _sex = sex;
    _type = type;
    _age = age;
    _height = height;
    _weight = weight;
    _act = act;
    notifyListeners();
  }
} 