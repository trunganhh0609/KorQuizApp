import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

import '../Model/Question.dart';

class Controller extends GetxController {
  List<Q> questLst = <Q>[].obs;
  List<String> count = <String>[].obs;
  List<String> answerTxt = <String>[].obs;
  RxString background = ''.obs;
  List<String> lstBackgound = [
    'assets/image/img.png',
    'assets/image/img1.jpg',
    'assets/image/img2.png'
  ];
  RxInt timeSet = 0.obs;
  RxString name = ''.obs;
  RxString testType = ''.obs;
  AudioPlayer audioPlayer = AudioPlayer();
  var vol = 1.0;
  var mute = false;
}
