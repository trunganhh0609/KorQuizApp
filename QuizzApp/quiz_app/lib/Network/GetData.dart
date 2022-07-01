import 'dart:convert';

import 'package:http/http.dart';

import '../Model/CategoryModel.dart';
import '../Model/Question.dart';
import 'package:http/http.dart' as http;

import '../Model/ResultTest.dart';

class Data {
  final String url = 'http://10.0.2.2:8080/KorQ/test';
  final String urlList = 'http://10.0.2.2:8080/KorQ/test/randomTest';
  final String urlSendInfTest =
      'http://10.0.2.2:8080/KorQ/test/insertResultTest';
  final String urlGetCategory = 'http://10.0.2.2:8080/KorQ/test/category';

  Future<List<CategoryModel>> category() async {
    final Response response = await http.post(
      Uri.parse(urlGetCategory),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      final parsed = json
          .decode(utf8.decode(response.bodyBytes))
          .cast<Map<String, dynamic>>();
      var list = parsed
          .map<CategoryModel>((json) => CategoryModel.fromJson(json))
          .toList();
      return list;
    } else {
      throw Exception('Failed');
    }
  }

  Future<List<Test>> getResultCurrent(Map id) async {
    final Response response = await http.post(
      Uri.parse('$url/resultCurrent'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
        body: jsonEncode(id)
    );
    if (response.statusCode == 200) {
      final parsed = json
          .decode(utf8.decode(response.bodyBytes))
          .cast<Map<String, dynamic>>();
      var list = parsed
          .map<Test>((json) => Test.fromJson(json))
          .toList();
      return list;
    } else {
      throw Exception('Failed');
    }
  }

  Future<Map<String,dynamic>> getUser(Map id) async {
    final Response response = await http.post(
      Uri.parse('$url/getUser'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(id)
    );
    if (response.statusCode == 200) {
      final res = json
          .decode(utf8.decode(response.bodyBytes));
      // var list = parsed
      //     .map<CategoryModel>((json) => CategoryModel.fromJson(json))
      //     .toList();
      return res;
    } else {
      throw Exception('Failed');
    }
  }


  Future send(Map data) async {
    final Response response = await http.post(
      Uri.parse(urlSendInfTest),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      print("ok");
    } else {
      throw Exception('Failed to post cases');
    }
  }


  Future<List<Q>> getTest(int max, String testType) async {
    Map data = {
      'TEST_TYPE': testType,
      'TEST_TOTAL_QUESTION': max,
    };

    final Response response = await http.post(
      Uri.parse(urlList),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      final parsed = json
          .decode(utf8.decode(response.bodyBytes))
          .cast<Map<String, dynamic>>();
      var list = parsed.map<Q>((json) => Q.fromJson(json)).toList();
      return list;
    } else {
      throw Exception('Failed to post cases');
    }
  }
}
