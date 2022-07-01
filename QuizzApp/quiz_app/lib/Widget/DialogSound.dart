import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/Controller/Controller.dart';


class SoundSlider extends StatefulWidget {
  @override
  _SoundSliderState createState() => _SoundSliderState();
}

class _SoundSliderState extends State<SoundSlider> {
var controller = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Setting volume',style: TextStyle(fontSize: 20),),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.volume_off,color: Colors.black45,),
            Slider(
              value: controller.vol,
              min: 0,
              max: 1,
              divisions: 100,
              label: (controller.vol*100).round().toString(),
              onChanged: (value) {
                setState(() {
                  controller.vol = value;
                  controller.audioPlayer.setVolume(controller.vol);
                  print(controller.vol);
                });
              },
            ),
            Icon(Icons.volume_up,color: Colors.black45,)
          ],
        ),
      ],
    );
  }
}

