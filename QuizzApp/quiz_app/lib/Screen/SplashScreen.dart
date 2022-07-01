import 'package:flutter/material.dart';

import 'package:quiz_app/Screen/TypeName.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    gotoHomePage();
  }

  gotoHomePage() async {
    await Future.delayed(Duration(seconds: 3), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => TypeName()));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Home App',
        theme: ThemeData(
          primaryColor: Colors.lightBlueAccent,
        ),
        home: Scaffold(
            body: Stack(
              children: [
                Image.asset('assets/image/img.png', fit: BoxFit.cover,width: MediaQuery.of(context).size.width),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("KorQuiz",style: TextStyle(fontSize: 40,color: Colors.white,fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ],
            )));
  }
}
