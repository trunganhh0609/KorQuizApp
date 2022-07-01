import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/Model/CategoryModel.dart';
import 'package:quiz_app/Network/GetData.dart';
import 'package:quiz_app/Screen/Home.dart';
import 'package:quiz_app/Widget/Background.dart';
import 'package:quiz_app/Widget/More.dart';
import 'package:quiz_app/Widget/Setting.dart';

import '../Controller/Controller.dart';

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> with WidgetsBindingObserver {
  var controller = Get.put(Controller());
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
      controller.audioPlayer.pause();
      print("Paused");
    }
    if (state == AppLifecycleState.resumed) {
      controller.audioPlayer.resume();
    }
  }

  void dispose() {
    super.dispose();
    print("fsdf");
  }

  Future setAudio() async {
    controller.audioPlayer.setReleaseMode(ReleaseMode.loop);
    return await controller.audioPlayer.play(AssetSource('sound/ukulele.mp3'));
  }

  gotoTest(String type) {
    controller.testType.value = type;
    controller.timeSet.value = 0;
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyApp()));

  }

  @override
  Widget build(BuildContext context) {
    List<CategoryModel>? tilteLst = <CategoryModel>[];
    return Scaffold(
      appBar: AppBar(
        title: Text('titleCategory'.tr),
        centerTitle: true,
        actions: [
          Setting(),
          More()
        ],
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
                              margin: const EdgeInsets.only(top: 20),
                              child: Text(
                                '${'hello'.tr}${controller.user.values.elementAt(1)}',
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ))),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(top: 30, left: 10, right: 10),
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
                                        .toString().toLowerCase());
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
                                          .toLowerCase().tr,
                                      style: const TextStyle(
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
              return Center(child: const CircularProgressIndicator());
            }
          }),
    );
  }
}
