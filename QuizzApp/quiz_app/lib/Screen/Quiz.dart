import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/Controller/Controller.dart';
import 'package:quiz_app/Network/GetData.dart';
import 'package:quiz_app/Screen/PreResult.dart';
import 'package:quiz_app/Screen/Result.dart';

import '../Widget/Background.dart';
import 'Test.dart';

class Quiz extends StatefulWidget {
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  var ctrl = Get.put(Controller());
  var point = 0;
  Duration duration = Duration();
  Timer? timer;
  var time;
  var valProgress;
  var testTime;
  Data _data = Data();

  @override
  void initState() {
    super.initState();
    startTimer();
    print('point:$point');
    ctrl.count.clear();
    ctrl.answerTxt.clear();
    for (var i = 0; i < ctrl.questLst.length; i++) {
      ctrl.answerTxt.add("Null");
      ctrl.count.add("Null");
    }
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
    print("dispose");
  }

  void saveInfTest() {

    Duration timeDuration = Duration(seconds: testTime-time);
    String minute = pasreTime(timeDuration.inMinutes.remainder(60));
    String second = pasreTime(timeDuration.inSeconds.remainder(60));
    String hour = pasreTime(timeDuration.inHours.remainder(60));
    Map data = {
      'NAME': ctrl.name.value,
      'TYPE': ctrl.testType.value,
      'TEST_TIME': '$hour:$minute:$second',
      'NUM_QUEST': ctrl.questLst.length,
      'POINT': (10 * point / ctrl.questLst.length).toDouble()
    };
    print(data);
    _data.send(data);
  }

  void startTimer() {
    if (ctrl.timeSet.value == 0) {
      switch (ctrl.questLst.length) {
        case 10:
          {
            testTime = time = 60 * 5;
          }
          break;
        case 20:
          {
            testTime = time = 60 * 10;
          }
          break;
        case 50:
          {
            testTime = time = 60 * 25;
          }
          break;
        case 100:
          {
            testTime = time = 60 * 50;
          }
          break;
        case 200:
          {
            testTime = time = 60 * 100;
          }
          break;
        default:
          {
            print("This is default case");
          }
          break;
      }
    } else {
      testTime = time = 60 * ctrl.timeSet.value;
    }

    timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
  }

  addTime() {
    setState(() {
      time = time - 1;
      duration = Duration(seconds: time);
    });
    if (time == 0) {
      checkPoint();
      timer!.cancel();
      return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("time out".tr),
            actions: <Widget>[
              ElevatedButton(
                child: new Text("ok".tr),
                onPressed: () {
                  saveInfTest();
                  timer?.cancel();
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PreResult(point)));
                },
              ),
            ],
          );
        },
      );
    }
  }

  checkPoint() {
    point = 0;
    var lstQuest = ctrl.questLst;
    for (var i = 0; i < lstQuest.length; i++) {
      var lstAnswer = lstQuest[i].aNSWER;
      for (var j = 0; j < lstAnswer!.length; j++) {
        if (ctrl.count[i] == lstAnswer[j].aNSWERID.toString()) {
          if (lstAnswer[j].aNSWERCORRECT == 0.0) {
          } else {
            point++;
          }
        }
      }
    }

    if (time > 0) {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("title dialog".tr),
            actions: <Widget>[
              ElevatedButton(
                child: new Text("cancel".tr),
                onPressed: () {
                  setState(() {
                    Navigator.of(context).pop();
                  });
                },
              ),
              ElevatedButton(
                child: new Text("ok".tr),
                onPressed: () {
                  saveInfTest();
                  timer?.cancel();
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PreResult(point)));
                },
              ),
            ],
          );
        },
      );
    }
  }

  makePage() {
    var lstQuest = ctrl.questLst;
    List<Widget> list = <Widget>[];
    for (var i = 0; i < lstQuest.length; i++) {
      var lstAnswer = lstQuest[i].aNSWER;
      ctrl.count.add(lstQuest[i].qUESTIONID.toString());

      list.add(Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(left: 20, bottom: 20),
            child: Text(
              'question'.tr + '${i + 1}/' + lstQuest.length.toString(),
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          Container(
              margin: EdgeInsets.all(20),
              child: Text(
                lstQuest[i].qUESTIONTEXT.toString(),
                style: TextStyle(fontSize: 25, color: Colors.white),
              )),
          ...List.generate(
              lstAnswer!.length,
              (index) => Container(
                    margin: EdgeInsets.all(2),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          ctrl.count[i] = lstAnswer[index].aNSWERID.toString();
                          ctrl.answerTxt[i] =
                              lstAnswer[index].aNSWERTEXT.toString();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          minimumSize: Size(
                              MediaQuery.of(context).size.width / 1.25, 55),
                          primary: (ctrl.count[i] ==
                                  lstAnswer[index].aNSWERID.toString())
                              ? Colors.cyan
                              : Colors.white60),
                      child: Text(
                        lstAnswer[index].aNSWERTEXT.toString(),
                        style: TextStyle(
                            color: (ctrl.count[i] ==
                                    lstAnswer[index].aNSWERID.toString())
                                ? Colors.white
                                : Colors.black),
                      ),
                    ),
                  )),
        ],
      ));
    }
    return list;
  }

  String pasreTime(int n) {
    return n.toString().padLeft(2, '0');
  }

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    var appBar = AppBar();

    String minute = pasreTime(duration.inMinutes.remainder(60));
    String second = pasreTime(duration.inSeconds.remainder(60));
    String hour = pasreTime(duration.inHours.remainder(60));
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
        centerTitle: true,
      ),
      body: Stack(children: [
        Background(),
        Column(
          children: [
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height) *
                  0.8 /
                  10,
              child: Align(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$hour:$minute:$second',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      width: MediaQuery.of(context).size.width * 7 / 10,
                      height: 10,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: LinearProgressIndicator(
                          value: double.parse(time.toString()) / testTime,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.lightGreen),
                          backgroundColor: Colors.black45,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height) *
                  6.5 /
                  10,
              padding: EdgeInsets.only(top: 20),
              child: PageView(controller: controller, children: makePage()),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      controller.previousPage(
                          duration: Duration(milliseconds: 400),
                          curve: Curves.ease);
                    },
                    child: Text("previous".tr)),
                Container(
                  width: MediaQuery.of(context).size.width / 5,
                ),
                ElevatedButton(
                    onPressed: () {
                      controller.nextPage(
                          duration: Duration(milliseconds: 400),
                          curve: Curves.ease);
                    },
                    child: Text("next".tr))
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 25),
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height) *
                  0.5 /
                  10,
              child: ElevatedButton(
                  child: Text("submit".tr),
                  onPressed: () {
                    checkPoint();
                  }),
            ),
          ],
        ),
      ]),
    );
  }
}
