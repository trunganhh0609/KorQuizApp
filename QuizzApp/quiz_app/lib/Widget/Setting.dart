import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Screen/SettingBackground.dart';

class Setting {
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

  Widget setting(bool mute, AudioPlayer audioPlayer, BuildContext context) {
    return PopupMenuButton(
      icon: Icon(Icons.settings),
      itemBuilder: (context) => [
        PopupMenuItem(
            value: 'sound',
            child: Row(
              children: [
                Text("sound".tr),
                Container(
                  child: (mute == false)
                      ? Icon(
                          Icons.volume_up,
                          color: Colors.black45,
                        )
                      : Icon(
                          Icons.volume_off,
                          color: Colors.black45,
                        ),
                )
              ],
            )),
        PopupMenuItem(value: 'background', child: Text('background'.tr)),
        PopupMenuItem(value: 'language', child: Text("language".tr))
      ],
      onSelected: (String newValue) {
        if (newValue == 'sound') {
          if (mute == false) {
            audioPlayer.setVolume(0);
            mute = true;
          } else {
            mute = false;
            audioPlayer.setVolume(1);
          }
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
