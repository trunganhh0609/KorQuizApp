import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:quiz_app/Controller/Controller.dart';
import 'package:quiz_app/Screen/Home.dart';

class Result extends StatelessWidget {
  var point;
  final Controller ctrl = Get.put(Controller());

  Result(this.point);

  makePage(BuildContext context) {
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
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          minimumSize: Size(
                              MediaQuery.of(context).size.width / 1.5, 55),
                          primary: (lstAnswer[index].aNSWERCORRECT == 1.0)
                              ? Colors.green
                              : Colors.redAccent),
                      child: Row(
                        children: [
                          Text(
                            lstAnswer[index].aNSWERTEXT.toString(),
                          ),
                          Visibility(
                              visible: (ctrl.answerTxt[i] ==
                                  lstAnswer[index].aNSWERTEXT.toString())
                                  ? true
                                  : false,
                              child: (ctrl.answerTxt[i] ==
                                  lstAnswer[index]
                                      .aNSWERTEXT
                                      .toString() &&
                                  lstAnswer[index].aNSWERCORRECT == 1.0)
                                  ? Icon(
                                Icons.check,
                                color: Colors.white,
                              )
                                  : Icon(Icons.close, color: Colors.white))
                        ],
                      ),
                    ),

                  ],
                ),
              )),
        ],
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar();
    final PageController pageController = PageController();
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text('Result Page'),
            centerTitle: true,
          ),
          body: Stack(
            children: [
              SvgPicture.asset("assets/image/bg.svg", fit: BoxFit.cover,width: MediaQuery.of(context).size.width),
              Column(
                children: [
                  Container(
                      alignment: Alignment.center,
                      height: (MediaQuery.of(context).size.height -
                          appBar.preferredSize.height) *
                          1 /
                          10,
                      child: Text("Điểm của bạn: $point",
                          style: TextStyle(fontSize: 30, color: Colors.green))),
                  Container(
                    height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height) *
                        6 /
                        10,
                    padding: EdgeInsets.only(top: 20),
                    child: PageView(
                        controller: pageController, children: makePage(context)),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height) *
                        2 /
                        10,
                    child: ElevatedButton(
                        onPressed: () {
                          ctrl.count.clear();
                          Navigator.of(context).pop();
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => MyApp()));
                        },
                        child: Text("Trở về home")),
                  )
                ],
              ),
            ],
          )),
    );
  }
}
