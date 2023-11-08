import 'package:capstone_design2/providers/nutrition.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user.dart';
//import 'package:http/http.dart' as http;

class MyReport extends StatefulWidget {
  const MyReport({super.key});

  @override
  State<MyReport> createState() => _MyReport();
}

class _MyReport extends State<MyReport> {

  late User user;
  late Nutrition nutrition;

  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    nutrition = Provider.of<Nutrition>(context);

    //Map<String, Object> args = ModalRoute.of(context)?.settings.arguments as Map<String, Object>;
    //String args = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Card(
            child: ListTile(
              title: 
                Text('권장 섭취 칼로리: ${nutrition.kcal}'),
            )),
            Card(
            child: ListTile(
              title: 
                Text('권장 섭취 탄수화물: ${nutrition.carbohydrate}'),
            )),
            Card(
            child: ListTile(
              title: 
                Text('권장 섭취 단백질: ${nutrition.protein}'),
            )),
            Card(
            child: ListTile(
              title: 
                Text('권장 섭취 지방: ${nutrition.fat}'),
            ))
          ],
          ))
    );
  }
}