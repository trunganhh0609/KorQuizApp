import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/Screen/TypeName.dart';
import 'package:quiz_app/Widget/DialogSound.dart';

import '../Controller/Controller.dart';
import '../Screen/SettingBackground.dart';

class Setting extends StatelessWidget{
  var controller = Get.put(Controller());
  final location = [
    {'name': 'English', 'location': Locale('en', 'US')},
    {'name': 'Tiếng Việt', 'location': Locale('vi', 'VN')}
  ];

  updatelocation(Locale locale, BuildContext context) {
    Navigator.of(context).pop();
    Get.updateLocale(locale);
  }

  showDialogLanguage(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              content: Container(
                width: 300,
                child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            updatelocation(
                                location[index]['location'] as Locale, context);
                          },
                          child: Text(location[index]['name'].toString()),
                        ),
                    separatorBuilder: (context, index) =>
                        Divider(color: Colors.black),
                    itemCount: 2),
              ),
            ));
  }
  showDialogSound(BuildContext context){

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: Container(
            height: MediaQuery.of(context).size.height/8,
            child: (
              SoundSlider()
            )
        )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(Icons.settings),
      itemBuilder: (context) => [
        PopupMenuItem(value: 'sound', child: Text("sound".tr)),
        PopupMenuItem(value: 'background', child: Text('background'.tr)),
        PopupMenuItem(value: 'language', child: Text("language".tr)),
      ],
      onSelected: (String newValue) {
        if (newValue == 'sound') {
          showDialogSound(context);
        }
        if (newValue == 'background') {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => StBackground()));
        }
        if (newValue == 'language') {
          showDialogLanguage(context);
        }
      },
    );
  }
}
