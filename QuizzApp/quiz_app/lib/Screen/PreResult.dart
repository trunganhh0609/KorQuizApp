import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/Controller/Controller.dart';

import '../Widget/Background.dart';
import 'Result.dart';

class PreResult extends StatelessWidget {
  var point;
  final Controller ctrl = Get.put(Controller());

  PreResult(this.point);


  @override
  Widget build(BuildContext context) {
    var appBar = AppBar();
    final PageController pageController = PageController();
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text('titleResult'.tr),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Background(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    alignment: Alignment.center,
                    height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height) *
                        1 /
                        10,
                    child: Text("your point".tr +"${point * 10 / ctrl.questLst.length}",
                        style: TextStyle(fontSize: 30, color: Colors.green))),
                Text('${point.round()} / ${ctrl.questLst.length}',style: TextStyle(fontSize: 50,color: Colors.white)),
                ElevatedButton(
                    onPressed: (){
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                          builder: (context) =>
                          Result()));
                    },
                    child: Text('review'.tr))
              ],
            ),
          ],
        ));
  }
}
