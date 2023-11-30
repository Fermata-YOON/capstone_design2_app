import 'package:capstone_design2/providers/nutrition.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user.dart';
import '../providers/record.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pie_chart/pie_chart.dart';

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

    Map<String, double> pieChartData = {'탄수화물' : double.parse(nutrition.carboRate.toString()), '단백질' : double.parse(nutrition.proteinRate.toString()), '지방' : double.parse(nutrition.fatRate.toString())};

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
                  color: Colors.lightGreen,
                  border: Border.all(
                    color: Colors.lightGreen,
                    width: 0,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Column(

                  children: [
                    SizedBox(height: 5),
                    const Text("오늘의 섭취량", style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10,),
                    const Text("Kcal", style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold)),
                    LinearPercentIndicator(
                      barRadius: Radius.circular(50),
                      alignment: MainAxisAlignment.center,
                      percent: getPercent(record.todayKcal, nutrition.kcal),
                      lineHeight: 30,
                      center: Text(
                          '${record.todayKcal}/${nutrition.kcal}(${((record.todayKcal / nutrition.kcal) * 100).toStringAsFixed(2)}%)'),
                      //trailing: Text('${nutrition.kcal}'),
                      backgroundColor: Colors.green,
                      progressColor: Colors.white,
                      width: MediaQuery.of(context).size.width * 0.85,
                    ),
                    SizedBox(height: 5,),
                    const Text("탄수화물", style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold)),
                    LinearPercentIndicator(
                      barRadius: Radius.circular(50),
                      alignment: MainAxisAlignment.center,
                      percent: getPercent(
                          record.todayCarbohydrate, nutrition.carbohydrate),
                      lineHeight: 30,
                      center: Text(
                          '${record.todayCarbohydrate}/${nutrition.carbohydrate}(${((record.todayCarbohydrate / nutrition.carbohydrate) * 100).toStringAsFixed(2)}%)'),
                      //trailing: Text('${nutrition.carbohydrate}'),
                      backgroundColor: Colors.green,
                      progressColor: Colors.white,
                      width: MediaQuery.of(context).size.width * 0.85,

                    ),
                    SizedBox(height: 5),
                    const Text("단백질", style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold)),
                    LinearPercentIndicator(
                      barRadius: Radius.circular(50),
                      alignment: MainAxisAlignment.center,
                      percent: getPercent(record.todayProtein, nutrition.protein),
                      lineHeight: 30,
                      center: Text(
                          '${record.todayProtein}/${nutrition.protein}(${((record.todayProtein / nutrition.protein) * 100).toStringAsFixed(2)}%)'),
                      //trailing: Text('${nutrition.protein}'),
                      backgroundColor: Colors.green,
                      progressColor: Colors.white,
                      width: MediaQuery.of(context).size.width * 0.85,
                    ),
                    SizedBox(height: 5),
                    const Text("지방", style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold)),
                    LinearPercentIndicator(
                      barRadius: Radius.circular(50),
                      alignment: MainAxisAlignment.center,
                      percent: getPercent(record.todayFat, nutrition.fat),
                      lineHeight: 30,
                      center: Text(
                          '${record.todayFat}/${nutrition.fat}(${((record.todayFat / nutrition.fat) * 100).toStringAsFixed(2)}%)'),
                      //trailing: Text('${nutrition.fat}'),
                      backgroundColor: Colors.green,
                      progressColor: Colors.white,
                      width: MediaQuery.of(context).size.width * 0.85,
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              PieChart(
                dataMap: pieChartData,
                //animationDuration: false,
                chartLegendSpacing: 16,
                chartRadius: MediaQuery.of(context).size.width / 1.5,
                colorList: const [Colors.deepOrange, Colors.blueAccent, Colors.yellow],
                initialAngleInDegree: 0,
                chartType: ChartType.disc,
                ringStrokeWidth: 32,
                legendOptions: const LegendOptions(
                  showLegendsInRow: false,
                  legendPosition: LegendPosition.right,
                  showLegends: true,
                  legendShape: BoxShape.circle,
                  legendTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                chartValuesOptions: const ChartValuesOptions(
                  showChartValueBackground: true,
                  showChartValues: true,
                  showChartValuesInPercentage: false,
                  showChartValuesOutside: false,
                  decimalPlaces: 1,
                ),
              ), 
              SizedBox(height: 10,),    
              Expanded(
                  child: ListView.builder(
                      itemCount: record.list.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.green, width: 2),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Column(
                              children: [
                                Text('${record.list[index]['date']}',
                                    style: const TextStyle(fontSize: 19)),
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
