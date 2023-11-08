class MyServer {
  static const url = "http://43.201.30.89:5000/capstone2";
  String get login => '$url/get_login';
  String get checkAvailable => '$url/get_available';
  String get join => '$url/post_join';
  String get food => '$url/get_food';
  String get postHistory => '$url/post_history';
  String get getHistory => '$url/get_history';
  String get getNutrition => '$url/get_nutrition';
}