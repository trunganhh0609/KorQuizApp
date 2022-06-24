import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:quiz_app/Controller/Controller.dart';
import 'package:quiz_app/Network/GetData.dart';
import 'package:quiz_app/Screen/Category.dart';
import 'package:quiz_app/Screen/Quiz.dart';
import 'package:quiz_app/Widget/Setting.dart';

import '../Model/Question.dart';
import '../Widget/Background.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var data = Data();
  var count = 'null';
  Future<List<Q>> quest = Future(() => []);
  var controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: true,

        title: Text('Test1'.tr),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Q>>(
        future: quest,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            controller.questLst = snapshot.data!;
            for (var i = 0; i < controller.questLst.length; i++) {
              controller.questLst[i].aNSWER!.shuffle();
            }
            return Stack(
              children: [
                Background(),
                Container(
                  padding: EdgeInsets.only(top: 100.0),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text(
                        'count quest'.tr,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 30, bottom: 30),
                        child: GroupButton(
                          buttons: ['10', '20', '50', '100', '200'],
                          onSelected: (val, i, selected) {
                            setState(() {
                              count = val.toString();
                              var temp = int.tryParse(count);
                              quest = data.getTest(temp!);
                              print(count);
                            });
                          },
                          options: GroupButtonOptions(
                            borderRadius: BorderRadius.circular(10.0),
                            unselectedColor: Colors.white60,
                          ),
                        ),
                      ),
                      Text(
                        'time'.tr,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 30, bottom: 30),
                        child: GroupButton(
                          buttons: ['5', '10', '20', '50', '100'],
                          onSelected: (val, i, selected) {
                            setState(() {
                              controller.timeSet.value =
                                  int.parse(val.toString());
                            });
                          },
                          options: GroupButtonOptions(
                            borderRadius: BorderRadius.circular(10.0),
                            unselectedColor: Colors.white60,
                          ),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: (count == 'null')
                              ? null
                              : () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Quiz()));
                                },
                          child: Text(
                            'go'.tr,
                            style: TextStyle(color: Colors.white),
                          )),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
