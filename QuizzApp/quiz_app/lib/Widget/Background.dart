import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/Controller.dart';

class Background extends StatelessWidget{
  var controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Image.asset(controller.background.value, fit: BoxFit.cover,height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width));
  }
}