import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:quiz_app/Controller/Controller.dart';
import 'package:quiz_app/Network/GetData.dart';
import 'package:quiz_app/Screen/Category.dart';
import 'package:quiz_app/Screen/Quiz.dart';

import '../Model/Question.dart';

class StBackground extends StatefulWidget {
  @override
  _StBackgroundState createState() => _StBackgroundState();
}

class _StBackgroundState extends State<StBackground> {

  var controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: true,

        title: Text('Setting Background'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ...List.generate(
              controller.lstBackgound.length,
                  (index) => InkWell(
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.all(10),
                        width: 150,
                        height: 30,
                        color: Colors.cyan,
                        child: Center(child: Text("Back ground $index")),
                      ),
                    ),
                    onTap: (){
                      setState((){
                        controller.background.value = controller.lstBackgound[index];
                        print(controller.background.value);
                      });
                    },
                  )

          ),
          Expanded(
              child: Image.asset(controller.background.value, fit: BoxFit.cover,width: MediaQuery.of(context).size.width)),

        ],
      )
    );
  }
}
