import 'dart:convert';
import 'package:capstone_design2/my_server.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../providers/user.dart';
import '../providers/recommend.dart';

class SelectPreference extends StatefulWidget {
  const SelectPreference({super.key});

  @override
  State<SelectPreference> createState() => _SelectPreference();
}

class _SelectPreference extends State<SelectPreference> {

  late User user;
  late Recommend recommend;

  final myServer = MyServer();

  List<String> category = ['rice', 'meat', 'noodle', 'bread', 'allthing'];
  List<String> label = ['밥', '고기', '면', '빵', ''];

  void getRecommend(String id, String label) async {
    // ignore: unused_local_variable
    http.Response response = await http.get(Uri.parse("${myServer.getRecommend}?id_give=$id&label_give=$label"));
    String body = utf8.decode(response.bodyBytes);
    List<dynamic> list = jsonDecode(body);
    if(!mounted) return;
    recommend.setList = list;
    }

  void postPreference(int num, String id) async {
    user.setPreference(category[num]);
    try {
      await http.post(Uri.parse(myServer.postPreference), 
      body: {'id_give': id, 'category_give' : category[num]});
      if(!mounted) return;
      Navigator.pushNamed(context, '/main'); 
      getRecommend(user.id, category[num]);
    } catch(e) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('error')
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('ok'),
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

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("선호 음식 수정하기"),
        backgroundColor: Colors.lightGreen,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              height: 60,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.lightGreen)
                ),
                onPressed: () {
                  postPreference(0, user.id);
                  //getRecommend(user.id, category[0]);
                },
                child: const Text('밥', style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 300,
              height: 60,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.lightGreen)
                ),
                onPressed: () {
                  postPreference(1, user.id);
                },
                child: const Text('고기', style: TextStyle(fontSize: 20, color: Colors.white),),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 300,
              height: 60,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.lightGreen)
                ),
                onPressed: () {
                  postPreference(2, user.id);
                  //getRecommend(user.id, category[2]);
                },
                child: const Text('면', style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 300,
              height: 60,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.lightGreen)
                ),
                onPressed: () {
                  postPreference(3, user.id);
                  //getRecommend(user.id, category[3]);
                },
                child: const Text('빵', style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 300,
              height: 60,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.lightGreen)
                ),
                onPressed: () {
                  postPreference(4, user.id);
                  //getRecommend(user.id, category[4]);
                },
                child: const Text('상관없음', style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
            ),
          ],
        ),
      )
    );
  }
}
