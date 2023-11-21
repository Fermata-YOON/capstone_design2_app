import 'package:capstone_design2/providers/nutrition.dart';
import 'package:flutter/material.dart';

//import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/user.dart';
import '../providers/record.dart';
import 'package:percent_indicator/percent_indicator.dart';
//import 'package:http/http.dart' as http;

class MyReport extends StatefulWidget {
  const MyReport({super.key});

  @override
  State<MyReport> createState() => _MyReport();
}

class _MyReport extends State<MyReport> {
  late User user;
  late Nutrition nutrition;
  late Record record;

  DateTime now = DateTime.now();

  getPercent(v1, v2) {
    if (v1 / v2 <= 1) {
      return v1 / v2;
    } else {
      return 1.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    nutrition = Provider.of<Nutrition>(context);
    record = Provider.of<Record>(context);

    //Map<String, Object> args = ModalRoute.of(context)?.settings.arguments as Map<String, Object>;
    //String args = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
        body: Container(
          margin:  EdgeInsets.all(4),
          padding:  EdgeInsets.all(4),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  border: Border.all(
                    //color: Colors.green,
                    width: 0,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Column(
                  children: [
                    const Text("오늘의 섭취량", style: TextStyle(fontSize: 20, color: Colors.white)),
                    const Text("Kcal", style: TextStyle(fontSize: 15)),
                    LinearPercentIndicator(
                      alignment: MainAxisAlignment.center,
                      percent: getPercent(record.todayKcal, nutrition.kcal),
                      lineHeight: 20,
                      center: Text(
                          '${record.todayKcal}(${((record.todayKcal / nutrition.kcal) * 100).toStringAsFixed(2)}%)'),
                      trailing: Text('${nutrition.kcal}'),
                      backgroundColor: Colors.grey,
                      progressColor: Colors.lightGreen,
                      width: MediaQuery.of(context).size.width * 0.85,
                    ),
                    const Text("탄수화물", style: TextStyle(fontSize: 15)),
                    LinearPercentIndicator(
                      alignment: MainAxisAlignment.center,
                      percent: getPercent(
                          record.todayCarbohydrate, nutrition.carbohydrate),
                      lineHeight: 20,
                      center: Text(
                          '${record.todayCarbohydrate}(${((record.todayCarbohydrate / nutrition.carbohydrate) * 100).toStringAsFixed(2)}%)'),
                      trailing: Text('${nutrition.carbohydrate}'),
                      backgroundColor: Colors.grey,
                      progressColor: Colors.lightGreen,
                      width: MediaQuery.of(context).size.width * 0.85,
                    ),
                    const Text("단백질", style: TextStyle(fontSize: 15)),
                    LinearPercentIndicator(
                      alignment: MainAxisAlignment.center,
                      percent: getPercent(record.todayProtein, nutrition.protein),
                      lineHeight: 20,
                      center: Text(
                          '${record.todayProtein}(${((record.todayProtein / nutrition.protein) * 100).toStringAsFixed(2)}%)'),
                      trailing: Text('${nutrition.protein}'),
                      backgroundColor: Colors.grey,
                      progressColor: Colors.lightGreen,
                      width: MediaQuery.of(context).size.width * 0.85,
                    ),
                    const Text("지방", style: TextStyle(fontSize: 15)),
                    LinearPercentIndicator(
                      alignment: MainAxisAlignment.center,
                      percent: getPercent(record.todayFat, nutrition.fat),
                      lineHeight: 20,
                      center: Text(
                          '${record.todayFat}(${((record.todayFat / nutrition.fat) * 100).toStringAsFixed(2)}%)'),
                      trailing: Text('${nutrition.fat}'),
                      backgroundColor: Colors.grey,
                      progressColor: Colors.lightGreen,
                      width: MediaQuery.of(context).size.width * 0.85,
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: record.list.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                            child: Column(
                              children: [
                                Text('${record.list[index]['date']}',
                                    style: const TextStyle(fontSize: 20)),
                                Text('총 섭취 칼로리: ${record.list[index]['kcal']}'),
                                Text('총 섭취 탄수화물:${record.list[index]['carbohydrate']}'),
                                Text('총 섭취 단백질: ${record.list[index]['protein']}'),
                                Text('총 섭취 지방: ${record.list[index]['fat']}'),
                              ],
                            ));
                      }))
            ],
          ),
        ));
  }
}
