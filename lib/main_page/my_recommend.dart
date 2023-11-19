import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user.dart';
import '../../providers/history.dart';
import '../../providers/recommend.dart';
import '../my_server.dart';

class MyRecommend extends StatefulWidget {
  const MyRecommend({Key? key}) : super(key: key);

  @override
  State<MyRecommend> createState() => _MyHistory();
}

class _MyHistory extends State<MyRecommend> {

  late History history;
  late User user;
  late Recommend recommend;

  MyServer myServer = MyServer();

  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {

    history = Provider.of<History>(context);
    user = Provider.of<User>(context);
    recommend = Provider.of<Recommend>(context);

    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
            itemCount: recommend.name.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: Column(
                  children: [
                    Text('${recommend.detail[index]}', style: const TextStyle(fontSize: 30),),
                    Text('${recommend.name[index]}', style: const TextStyle(fontSize: 20),),
                    Text('${recommend.category[index]}'),
                  ],
                )
              );
            }
            )
          )
        ],)
    );
  }
}