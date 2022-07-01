import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/Screen/InfUser.dart';
import 'package:quiz_app/Screen/TypeName.dart';

import '../Controller/Controller.dart';

class More extends StatelessWidget {
  var controller = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(Icons.more_vert),
      itemBuilder: (context) => [
        PopupMenuItem(
            value: 'user', child: Text(controller.user.values.elementAt(1))),
        PopupMenuItem(value: 'logout', child: Text("logout".tr))
      ],
      onSelected: (String newValue){
        if (newValue == 'user') {
           Navigator.push(
              context, MaterialPageRoute(builder: (context) => InfUser()));
        }
        if (newValue == 'logout') {
          controller.user.clear();
          controller.background.value = controller.lstBackgound[0];
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => TypeName()));
        }
      },
    );
  }

}
