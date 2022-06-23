import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:quiz_app/Screen/Home.dart';
import 'package:quiz_app/Screen/SettingBackground.dart';
import 'package:quiz_app/Widget/Background.dart';

import '../Controller/Controller.dart';

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> with WidgetsBindingObserver{
  var controller = Get.put(Controller());
  final AudioPlayer audioPlayer = AudioPlayer();
  var vol = 1.0;
  var mute = false;
  final location = [
  {'name':'English', 'location':Locale('en','US')},
  {'name':'Tiếng Việt','location':Locale('vi','VN')}
  ];
  void initState(){
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    controller.background.value = controller.lstBackgound[0];
    setAudio();

  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if(state == AppLifecycleState.paused){
      audioPlayer.pause();
      print("Paused");
    }
    if(state == AppLifecycleState.resumed){
      audioPlayer.resume();
    }
  }
  void dispose(){
    super.dispose();
    print("fsdf");
    audioPlayer.stop();
  }

  Future setAudio() async{
    audioPlayer.setReleaseMode(ReleaseMode.loop);
    audioPlayer.setSource(AssetSource('sound/ukulele.mp3'));
    return await audioPlayer.resume();
  }
  showDialogLanguage(BuildContext context){
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: Container(
            width: 300,
            child: ListView.separated(
              shrinkWrap: true,
                itemBuilder:(context,index)
                =>InkWell(
                  onTap: (){
                    updatelocation(location[index]['location'] as Locale, context);
                  },
                  child: Text(location[index]['name'].toString()),
                ),
                separatorBuilder: (context, index) => Divider(color: Colors.black),
                itemCount: 2),
          ),
        )
    );
  }
  updatelocation(Locale locale, BuildContext context){
    Navigator.of(context).pop();
    Get.updateLocale(locale);
  }
  gotoTest(String type) {
    switch (type) {
      case 'Word Test':
        {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MyApp()));
        }
        break;
      case 'Write Test':
        {}
        break;
      case 'Read Test':
        {}
        break;
      default:
        {
          print("This is default case");
        }
        break;
    }
  }
  controlMute(){

  }
  @override
  Widget build(BuildContext context) {
    final _random = Random();
    List<String> lstCategory = ['Word Test', 'Write Test', 'Read Test'];
    return Scaffold(
      appBar: AppBar(
        title: Text('titleCategory'.tr),
        centerTitle: true,
        actions: [
          PopupMenuButton(
              icon: Icon(Icons.settings),
              itemBuilder: (context) => [
                    PopupMenuItem(
                        value: 'sound',
                        child: Row(
                          children: [
                            Text("Sound"),
                            Container(
                              child: (mute == false)? Icon(Icons.volume_up,color: Colors.black45,): Icon(Icons.volume_off,color: Colors.black45,),)
                          ],
                        )
                    ),
                    const PopupMenuItem(
                        value: 'background',
                        child: Text("Background")
                    ),
                    const PopupMenuItem(
                        value: 'language',
                        child: Text("Language")
                    )
                  ],
            onSelected: (String newValue){
                  if(newValue == 'sound'){
                    if(mute == false){

                      audioPlayer.setVolume(0);
                      mute = true;
                    }else{
                      mute=false;
                      audioPlayer.setVolume(1);
                    }

                  }
                  if(newValue == 'background'){
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => StBackground()));
                  }
                  if(newValue == 'language'){
                    showDialogLanguage(context);
                  }
            },
          )
        ],
      ),
      body: Stack(
        children: [
          Background(),
          Container(
            margin: EdgeInsets.only(top: 30, left: 10, right: 10),
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemCount: lstCategory.length,
                itemBuilder: (BuildContext ctx, index) {
                  return InkWell(
                    onTap: () {
                      debugPrint(lstCategory[index]);
                      gotoTest(lstCategory[index]);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        lstCategory[index],
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.cyan,
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
