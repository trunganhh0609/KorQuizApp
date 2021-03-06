import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/Controller/Controller.dart';
import 'package:quiz_app/Network/GetData.dart';
import 'package:quiz_app/Screen/Category.dart';

import '../Widget/Background.dart';

class TypeName extends StatefulWidget {
  @override
  _TypeNameState createState() => _TypeNameState();
}

class _TypeNameState extends State<TypeName> {
  var controller = Get.put(Controller());
  TextEditingController nameEditingController = TextEditingController();
  Data _data = Data();

  infUser(Map id) async{
    controller.user = await _data.getUser(id);
  }

  @override
  Widget build(BuildContext context) {
    controller.background.value = controller.lstBackgound[0];
    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/image/img.png', fit: BoxFit.cover,width: MediaQuery.of(context).size.width),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    margin: EdgeInsets.symmetric(vertical: 50),
                    child: Text('type name'.tr,
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            color: Colors.white))),
                TextField(
                  style: TextStyle(color: Colors.white),
                  controller: nameEditingController,
                  onChanged: (name) {
                    setState(() {
                      controller.name.value = name;
                    });
                  },
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.0),
                          borderRadius: BorderRadius.circular(30)),
                      labelText: "label text".tr,
                      labelStyle: TextStyle(color: Colors.white)),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: ElevatedButton(
                    child: Text('submit'),
                    onPressed: () {

                      Map id = {
                        'USER_ID': int.parse(controller.name.value),
                      };
                      infUser(id);
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Category()));

                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
