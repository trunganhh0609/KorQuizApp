import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/Screen/Category.dart';
import 'package:quiz_app/Screen/Home.dart';
import 'package:quiz_app/Screen/Quiz.dart';
import 'package:quiz_app/Screen/Result.dart';
import 'package:quiz_app/Translate/translation.dart';

import 'Screen/SplashScreen.dart';

void main() => runApp(GetMaterialApp(
  translations: TranslationApp(),
  locale: Get.deviceLocale,
  initialRoute: '/',
  routes: {
    // When navigating to the "/" route, build the HomeScreen widget.
    '/': (context) => SplashScreen(),
    'category': (context) => Category(),
    // When navigating to the "/second" route, build the SecondScreen widget.
    'wordtest': (context) => MyApp(),
    'result' : (context) => Result(),
    'quiz' : (context) => Quiz()
  },
    ));
