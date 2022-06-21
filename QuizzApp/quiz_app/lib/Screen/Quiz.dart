import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:quiz_app/Controller/Controller.dart';
import 'package:quiz_app/Screen/Result.dart';

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
  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    startTimer();
    print('point:$point');
    ctrl.count.clear();
    ctrl.answerTxt.clear();
    for (var i = 0; i < ctrl.questLst.length; i++) {
      ctrl.answerTxt.add("Null");
      ctrl.count.add("Null");
    }

    super.initState();
  }

  void startTimer() {
    switch (ctrl.questLst.length) {
      case 10:
        {
          valProgress = time = 60 * 5;
        }
        break;
      case 20:
        {
          valProgress = time = 60 * 20;
        }
        break;
      case 50:
        {
          valProgress = time = 60 * 50;
        }
        break;
      case 100:
        {
          valProgress = time = 60 * 100;
        }
        break;
      case 200:
        {
          valProgress = time = 60 * 200;
        }
        break;
      default:
        {
          print("This is default case");
        }
        break;
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
            title: const Text("Đã hết thời gian làm bài"),
            actions: <Widget>[
              ElevatedButton(
                child: new Text("OK"),
                onPressed: () {
                  var count = 0;
                  Navigator.popUntil(context, (route) {
                    return count++ == 2;
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Result(point * 10 / ctrl.questLst.length)));
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

    print(point.toString());
    if (time > 0) {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Bạn có chắc chắn muốn nộp bài?"),
            actions: <Widget>[
              ElevatedButton(
                child: new Text("Cancel"),
                onPressed: () {
                  setState(() {
                    Navigator.of(context).pop();
                  });
                },
              ),
              ElevatedButton(
                child: new Text("OK"),
                onPressed: () {
                  var count = 0;
                  Navigator.popUntil(context, (route) {
                    return count++ == 2;
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Result(point * 10 / ctrl.questLst.length)));
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
              'Câu hỏi ${i + 1}/' + lstQuest.length.toString(),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          Container(
              margin: EdgeInsets.all(20),
              child: Text(
                lstQuest[i].qUESTIONTEXT.toString(),
                style: TextStyle(fontSize: 25,color: Colors.white),
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

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    var appBar = AppBar();

    String pasreTime(int n) {
      return n.toString().padLeft(2, '0');
    }

    String minute = pasreTime(duration.inMinutes.remainder(60));
    String second = pasreTime(duration.inSeconds.remainder(60));
    String hour = pasreTime(duration.inHours.remainder(60));
    return Scaffold(

      appBar: AppBar(
        title: Text('Quiz'),
        centerTitle: true,
      ),
      body: Stack(
        children:[
          SvgPicture.asset("assets/image/bg.svg", fit: BoxFit.cover,width: MediaQuery.of(context).size.width),
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
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      width: MediaQuery.of(context).size.width * 7 / 10,
                      height: 10,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: LinearProgressIndicator(
                          value: double.parse(time.toString()) / valProgress,
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
                  7.5 /
                  10,
              padding: EdgeInsets.only(top: 20),
              child: PageView(controller: controller, children: makePage()),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              height: (MediaQuery.of(context).size.height -
                  appBar.preferredSize.height) *
                  0.5 /
                  10,
              child: ElevatedButton(
                  child: Text("Nộp bài"),
                  onPressed: () {
                    checkPoint();
                  }),
            )
          ],
        ),

        ]
      ),
    );
  }
}
