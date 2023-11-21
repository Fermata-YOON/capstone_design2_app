import 'package:capstone_design2/providers/nutrition.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user.dart';

//import 'package:http/http.dart' as http;
import 'calendar.dart';
import 'package:table_calendar/table_calendar.dart';

import 'my_history.dart';

class SelectCategory extends StatefulWidget {
  const SelectCategory({super.key});

  @override
  State<SelectCategory> createState() => _SelectCategory();
}

class _SelectCategory extends State<SelectCategory> {
  late User user;
  late Nutrition nutrition;

  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    nutrition = Provider.of<Nutrition>(context);

    //Map<String, Object> args = ModalRoute.of(context)?.settings.arguments as Map<String, Object>;
    //String args = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
        body: Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            child: Column(children: [
              DecoratedBox(
                decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color.fromRGBO(229, 229, 229, 1.0),width: 1,),
                    ) ),
                child: TextButton(
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.fromLTRB(10,20,10,24),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.show_chart, size: 30, color: Colors.red,),
                      SizedBox(width: 20,),
                      Text('영양 통계', style: TextStyle(fontSize: 16, color: Colors.black)),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => TableEventsExample()));
                  },
                ),


              ),
              DecoratedBox(
                decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color.fromRGBO(229, 229, 229, 1.0),width: 1,),
                    ) ),
                child: TextButton(
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.fromLTRB(10,20,10,24),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.format_list_bulleted, size: 30, color: Colors.purple,),
                      SizedBox(width: 20,),
                      Text('섭취 기록', style: TextStyle(fontSize: 16, color: Colors.black)),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => MyHistory()));
                  },
                ),


              ),
            ])));
  }
}
