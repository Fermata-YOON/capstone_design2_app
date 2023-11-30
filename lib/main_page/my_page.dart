//import 'package:capstone_design2/main_page/select_category.dart';
import 'package:capstone_design2/providers/nutrition.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user.dart';

//import 'package:http/http.dart' as http;
//import 'calendar.dart';
//import 'package:table_calendar/table_calendar.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPage();
}

class _MyPage extends State<MyPage> {
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
                ListTile(
                  title: Text(user.name),
                ),
                ListTile(
                  title: Text(user.id),
                ),
                ListTile(
                  title: Text("${user.age}세"),
                ),
                ListTile(
                  title: Text(user.viewSex),
                ),
                ListTile(
                  title: Text(user.viewType),
                ),
              ]


            )));
  }
}