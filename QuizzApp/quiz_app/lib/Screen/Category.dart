import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/Model/CategoryModel.dart';
import 'package:quiz_app/Network/GetData.dart';
import 'package:quiz_app/Screen/Home.dart';
import 'package:quiz_app/Widget/Background.dart';
import 'package:quiz_app/Widget/Setting.dart';

import '../Controller/Controller.dart';

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> with WidgetsBindingObserver {
  var controller = Get.put(Controller());
  final AudioPlayer audioPlayer = AudioPlayer();
  var vol = 1.0;
  var mute = false;
  var setting = Setting();
  Data data = Data();
  void initState() {
    super.initState();
    setAudio();
    WidgetsBinding.instance.addObserver(this);
    controller.background.value = controller.lstBackgound[0];
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      audioPlayer.pause();
      print("Paused");
    }
    if (state == AppLifecycleState.resumed) {
      audioPlayer.resume();
    }
  }

  void dispose() {
    super.dispose();
    print("fsdf");
    audioPlayer.stop();
  }

  Future setAudio() async {
    audioPlayer.setReleaseMode(ReleaseMode.loop);
    return await audioPlayer.play(AssetSource('sound/ukulele.mp3'));
  }

  gotoTest(String type) {
    switch (type) {
      case 'WORD TEST':
        {
          controller.testType.value = type;
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MyApp()));
        }
        break;
      case 'Kiểm tra từ vựng':
        {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MyApp()));
        }
        break;
      case 'WRITE TEST':
        {
          controller.testType.value = type;
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MyApp()));
        }
        break;
      case 'READ TEST':
        {}
        break;
      default:
        {
          print("This is default case");
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final _random = Random();
    List<String> lstCategory = ['Test1'.tr, 'Test2'.tr, 'Test3'.tr];
    List<CategoryModel>? tilteLst = <CategoryModel>[];
    return Scaffold(
      appBar: AppBar(
        title: Text('titleCategory'.tr),
        centerTitle: true,
        actions: [setting.setting(mute, audioPlayer, context)],
      ),
      body: FutureBuilder<List<CategoryModel>>(
          future: data.category(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              tilteLst = snapshot.data;
              return Stack(
                children: [
                  Background(),
                  Column(
                    children: [
                      Center(
                          child: Container(
                              margin: EdgeInsets.only(top: 20),
                              child: Text(
                                'hello'.tr + '${controller.name.value}',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ))),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top: 30, left: 10, right: 10),
                          child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 200,
                                      childAspectRatio: 3 / 2,
                                      crossAxisSpacing: 20,
                                      mainAxisSpacing: 20),
                              itemCount: tilteLst?.length,
                              itemBuilder: (BuildContext ctx, index) {
                                return InkWell(
                                  onTap: () {
                                    debugPrint(tilteLst![index].CATEGORYTITLE);
                                    gotoTest(tilteLst![index]
                                        .CATEGORYTITLE
                                        .toString());
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.cyan,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Text(
                                      tilteLst![index]
                                          .CATEGORYTITLE
                                          .toString()
                                          .toLowerCase(),
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
