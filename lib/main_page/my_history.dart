import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user.dart';
import '../../providers/history.dart';

class MyHistory extends StatefulWidget {
  const MyHistory ({Key? key}) : super(key: key);

  @override
  State<MyHistory> createState() => _MyHistory();
}

class _MyHistory extends State<MyHistory> {

  late History history;
  late User user;

  @override
  Widget build(BuildContext context) {

    history = Provider.of<History>(context);
    user = Provider.of<User>(context);
    //getHistory(user.id);

    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: ListView.builder(
        itemCount: history.length,
        itemBuilder: (BuildContext context, int index) {
          if(history.length == 0) {
            return const Text("기록이 없습니다.");
          } else {
            return Card(
            child: ListTile(
              title: 
                Text(history.foodName[index]),
              subtitle: 
              Text("${history.foodDate[index]}   섭취량: ${history.foodAmount[index]}인분 총${history.foodTotal[index]}g"),
              //isThreeLine: true,
            ),
          );
          }
        }
      )
    );
  }
}