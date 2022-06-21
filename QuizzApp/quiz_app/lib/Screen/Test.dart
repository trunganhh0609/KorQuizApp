import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:quiz_app/Controller/Controller.dart';
import 'package:quiz_app/Screen/Home.dart';

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand( // -> 01
        child: SvgPicture.asset("assets/image/bg.svg", fit: BoxFit.fill),    // -> 02
            ),
    );
  }
}