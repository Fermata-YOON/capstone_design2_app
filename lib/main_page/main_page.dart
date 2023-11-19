// ignore_for_file: use_build_context_synchronously
import '../providers/nutrition.dart';
import 'package:flutter/material.dart';
import 'my_history.dart';
import 'my_report.dart';
import 'my_recommend.dart';
import 'package:provider/provider.dart';
import '../providers/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../my_server.dart';
import '../providers/food.dart';
import '../providers/history.dart';
import '../providers/recommend.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPage();
}

class _MainPage extends State<MainPage> {

  late User user;
  late Food food;
  late History history;
  late Nutrition nutrition;
  late Recommend recommend;

  int _selectedIndex = 1; //선택된 페이지의 인덱스 번호 초기화
  String title = "영양 분석"; //AppBar title 처음에는 Home

  final List<Widget> _widgetOptions = <Widget>[
    const MyRecommend(),
    const MyReport(),
    const MyHistory(),
  ]; // 연결할 페이지 지정

  final myServer = MyServer();

  void getHistory(String id) async {
    // ignore: unused_local_variable
    http.Response response = await http.get(Uri.parse("${myServer.getHistory}?id_give=$id"));
    String body = utf8.decode(response.bodyBytes);
    List<dynamic> list = jsonDecode(body);
    if(!mounted) return;
    history.setList = list;
    history.setLength = list.length;        
  }

  void getNutrition(String id) async {
    http.Response response = await http.get(Uri.parse("${myServer.getNutrition}?id_give=$id"));
    String body = utf8.decode(response.bodyBytes);
    List<dynamic> list = jsonDecode(body);
    if(mounted) return;
    nutrition.setData(list[0]['kcal'], list[0]['carbohydrate'], list[0]['protein'], list[0]['fat']);    
  }

  void getRecommend(String id) async {
    // ignore: unused_local_variable
    http.Response response = await http.get(Uri.parse("${myServer.getRecommend}?id_give=$id"));
    String body = utf8.decode(response.bodyBytes);
    List<dynamic> list = jsonDecode(body);
    if(!mounted) return;
    recommend.setList = list;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch(index) { //AppBar title 변경
        case 0: 
          getRecommend(user.id);
          title = "추천 음식";
        case 1: 
        //getNutrition(user.id);
        title = "영양 분석";

        case 2: 
        getHistory(user.id);
        title = "섭취 기록";
      }
    }); // 탭을 클릭했을 때 지정한 페이지로 이동
  }

  void _floatingActionButtonTapped() async{
    try {
      http.Response response = await http.get(Uri.parse(myServer.food));
      String body = utf8.decode(response.bodyBytes);
      List<dynamic> list = jsonDecode(body);
      Navigator.pushNamed(context, '/selectFood', arguments: list);
    } catch(e) {
      showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(                                             
              content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text("Error") 
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    ElevatedButton(
                      child: const Text('OK'),
                      onPressed: () {
                      Navigator.of(context).pop();
                            },
                          ),
                        ]
                      );
                    }
        );     
    }
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    food = Provider.of<Food>(context);
    history = Provider.of<History>(context);
    recommend = Provider.of<Recommend>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(title)
      ),
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          food.setId = user.id;
          _floatingActionButtonTapped();
        },
        child: const Icon(Icons.add)
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.recommend), label: "추천"),
          BottomNavigationBarItem(icon: Icon(Icons.leaderboard), label: "분석"),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: "기록"),
        ],
        currentIndex: _selectedIndex, //지정인덱스로 이동
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(user.name)
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
        )
      )
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override dispose() {
    super.dispose();
  }
}