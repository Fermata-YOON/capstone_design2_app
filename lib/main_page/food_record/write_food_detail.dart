import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../providers/food.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../../my_server.dart';

class WriteFoodDetail extends StatefulWidget {
  const WriteFoodDetail({Key? key}) : super(key: key);

  @override
  State<WriteFoodDetail> createState() => _WriteFoodDetail();
}

class _WriteFoodDetail extends State<WriteFoodDetail> {

  final myServer = MyServer();

  @override
  Widget build(BuildContext context) {  

    var food = Provider.of<Food>(context);
    String foodName = ModalRoute.of(context)?.settings.arguments as String;

    addHistory() async {
    try {
      // ignore: unused_local_variable
      http.Response response = await http.post(Uri.parse(myServer.postHistory), 
      body: {'id_give': food.id, 'code_give': food.code, 'date_give': DateFormat('yyyy-MM-dd').format(food.date), 'amount_give': food.amount.toString(), 'total_give': food.total.toString()});
        if(!mounted) return;
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(                                             
            content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("기록 완료")
                    ],
                  ),
                ),
                actions: <Widget>[
                  ElevatedButton(
                    child: const Text('OK'), 
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false); 
                    },
                  ),
                ]
            );}          
        );  
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

    TextEditingController amountController = TextEditingController(text: food.amount.toString());
    //double inputAmount = 1;

    Future datePicker() async{
      DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(), 
        firstDate: DateTime(DateTime.now().year-1), 
        lastDate: DateTime(DateTime.now().year+1));
      if (picked != null) {
        food.setDate = picked;  
      }
    }

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("세부 정보 입력")
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  foodName, 
                  style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                Text("1인분: ${food.gram}g", style: const TextStyle(fontSize: 15)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("먹은 날짜: ", style: TextStyle(fontSize: 20)),
                    TextButton(
                      onPressed: datePicker,
                      child: 
                      Text(DateFormat('yyyy-MM-dd').format(food.date), style: const TextStyle(fontSize: 20)),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 70,
                      height: 25,
                      child: Text("섭취량: ", style: TextStyle(fontSize: 20),)
                    ),
                    SizedBox(
                      width: 35,
                      height: 25,
                      child: TextField(
                        controller: amountController,
                        //decoration: 
                          //InputDecoration(hintText: userAmount),
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      )
                    ),
                    const SizedBox(
                      width: 35,
                      height: 25,
                      child: Text("인분", style: TextStyle(fontSize: 20))
                    ),
                    IconButton(
                      icon: const Icon(Icons.calculate),
                      onPressed: () {
                        food.setAmount = double.parse(amountController.text);
                      }),
                    ],
                  ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("총 섭취량: ${food.gram*food.amount}g", style: const TextStyle(fontSize: 20)),                      
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      food.setAmount = double.parse(amountController.text);
                      if(food.amount > 0 ) {
                        showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(                                             
                          content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text("확인: 총 ${food.amount}인분, ${food.amount*food.gram}g")
                            ],
                          ),
                          ),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('취소', style: TextStyle(color: Colors.red),), 
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                ElevatedButton(
                                  child: const Text('확인'), 
                                  onPressed: () {
                                    addHistory();
                                  },
                                ),
                              ]
                          );
                        }
                      ); 
                      } else {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(                                             
                            content: const SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Text("섭취량을 정확히 입력해주세요")
                              ],
                            ),
                            ),
                                actions: <Widget>[
                                  ElevatedButton(
                                    child: const Text('확인'), 
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ]
                            );
                          }
                        );
                      }     
                    }, 
                    child: const Text("기록하기", style: TextStyle(fontSize: 20),)))
              ]                
            ),
          )
        )
      )
    );
    
  }
}