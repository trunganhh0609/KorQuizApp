import 'package:flutter/material.dart';
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
          Expanded(
              flex: 6,
              child: Container(
                margin: EdgeInsets.only(bottom: 20),
                  child: Image.asset(controller.background.value, fit: BoxFit.cover,width: MediaQuery.of(context).size.width))),
          Expanded(
            flex: 1,
            child: GridView.builder(
                    gridDelegate:
                    const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 150,
                        childAspectRatio: 3 / 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 20),
                    itemCount: controller.lstBackgound.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return InkWell(
                        child: Image.asset(controller.lstBackgound[index],fit: BoxFit.cover,),
                        onTap: (){
                          setState((){
                            controller.background.value = controller.lstBackgound[index];
                            print(controller.background.value);
                          });
                        },
                      );
                    }),
          ),
        ],
      ),




    );
  }
}
