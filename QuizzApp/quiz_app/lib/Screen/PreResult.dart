import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:quiz_app/Controller/Controller.dart';
import 'package:quiz_app/Screen/Home.dart';

import 'Result.dart';

class PreResult extends StatelessWidget {
  var point;
  final Controller ctrl = Get.put(Controller());

  PreResult(this.point);


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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      alignment: Alignment.center,
                      height: (MediaQuery.of(context).size.height -
                          appBar.preferredSize.height) *
                          1 /
                          10,
                      child: Text("Điểm của bạn: ${point * 10 / ctrl.questLst.length}",
                          style: TextStyle(fontSize: 30, color: Colors.green))),
                  Text('${point.round()} / ${ctrl.questLst.length}',style: TextStyle(fontSize: 50,color: Colors.white)),
                  ElevatedButton(
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                            builder: (context) =>
                            Result()));
                      },
                      child: Text('Xem lại bài test'))
                ],
              ),
            ],
          )),
    );
  }
}
