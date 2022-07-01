import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/Controller/Controller.dart';
import 'package:quiz_app/Network/GetData.dart';

import '../Model/ResultTest.dart';
import '../Widget/Background.dart';

class InfUser extends StatefulWidget {
  @override
  _InfUserState createState() => _InfUserState();
}

class _InfUserState extends State<InfUser> {
  var data = Data();
  var controller = Get.put(Controller());
  var resultTestList;
  List<FlSpot> dataLineChart = [];

  @override
  void initState() {
    super.initState();
  }

  List<FlSpot> makePointList() {
    List<FlSpot> dataChart = [];
    var count = 1;
    var avg = 0.0;
    var temp;
    resultTestList.add(Test());
    for(int i = 0; i < resultTestList.length; i++){
      temp = resultTestList[i].POINT;
      for(int j = i+1; j<resultTestList.length;j++){
        if(resultTestList[i].SUBMIT_AT == resultTestList[j].SUBMIT_AT){
          temp += resultTestList[j].POINT;
          count++;
        }else{
          avg = temp/count;
          if(resultTestList[i].SUBMIT_AT == '0'){
            FlSpot spot = FlSpot(7 , avg);
            dataChart.add(spot);
          }else{
            FlSpot spot = FlSpot(double.parse(resultTestList[i].SUBMIT_AT) , avg.toPrecision(2));
            dataChart.add(spot);
          }
          temp = resultTestList[j].POINT;
          count = 1;
          i = j;
        }
      }
    }
    dataLineChart = dataChart;
    print(dataChart);
    return dataChart;
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {

    const style1 = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 13,
    );
    const style2 = TextStyle(
      color: Colors.lightBlue,
      fontWeight: FontWeight.bold,
      fontSize: 13,
    );
    Widget text;
    var now;
    var valueWeek = value.toInt();
    if(DateTime.now().weekday == 0){
      now = 7;
    }else{
      now = DateTime.now().weekday;
    }

    switch (value.toInt()) {
      case 7:
        text = InkWell(
            child: Container(
                child: Text('SUN', style:(valueWeek == now)? style2 : style1)),
            onTap: (){
              print("pressed");
            },
        );
        break;
      case 1:
        text = InkWell(
          child: Container(
              child: Text('MON', style:(valueWeek == now)? style2 : style1)),
          onTap: (){
            print("pressed");
          },
        );
        break;
      case 2:
        text = InkWell(
          child: Container(
              child: Text('TUE', style:(valueWeek == now)? style2 : style1)),
          onTap: (){
            print("pressed");
          },
        );
        break;
      case 3:
        text = InkWell(
          child: Container(
              child: Text('WED', style:(valueWeek == now)? style2 : style1)),
          onTap: (){
            print("pressed");
          },
        );
        break;
      case 4:
        text = InkWell(
          child: Container(
              child: Text('THU', style:(valueWeek == now)? style2 : style1)),
          onTap: (){
            print("pressed");
          },

        );
        break;
      case 5:
        text = InkWell(
          child: Container(
              child: Text('FRI', style:(valueWeek == now)? style2 : style1)),
          onTap: (){
            print("pressed");
          },
        );
        break;
      case 6:
        text = InkWell(
          child: Container(
              child: Text('SA', style:(valueWeek == now)? style2 : style1)),
          onTap: (){
            print("pressed");
          },
        );
        break;
      default:
        text = Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  @override
  Widget build(BuildContext context) {
    Map id = {
      'USER_ID': int.parse(controller.name.value),
    };

    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: true,

        title: Text('information'.tr),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Test>>(
        future: data.getResultCurrent(id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            resultTestList = snapshot.data!;
            makePointList();
            return Stack(
              children: [
                Background(),
                Column(
                  children: [
                    Center(
                        child: Container(
                          margin: EdgeInsets.all(50),
                          child: Text(controller.user.values.elementAt(1),
                              style: TextStyle(fontSize: 40,color: Colors.white)),
                        )),
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        alignment: Alignment.topLeft,
                        child: Text('statistical'.tr,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.cyan),)),
                    Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width* 9/10,
                      child: LineChart(
                          LineChartData(
                              minX: 1,
                              maxX: 7,
                              minY: 0,
                              maxY: 10,
                              gridData: FlGridData(
                                show: false
                              ),
                              borderData: FlBorderData(
                                border: const Border(bottom: BorderSide(color: Colors.blueAccent,width: 4), left: BorderSide(color: Colors.greenAccent,width: 4)),
                              ),
                              titlesData: FlTitlesData(
                                  show: true,
                                  topTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: false
                                    )
                                  ),
                                  rightTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                          showTitles: false,
                                      )
                                  ),
                                  leftTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: false,
                                      )
                                  ),
                                  bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                          showTitles: true,
                                          interval: 1,
                                          getTitlesWidget: bottomTitleWidgets,
                                          reservedSize: 30
                                      )
                                  )
                              ),
                              lineBarsData: [
                                LineChartBarData(
                                  isCurved: true,
                                  shadow: const Shadow(
                                    color: Colors.white,
                                    blurRadius: 3,
                                  ),
                                  barWidth: 2,
                                  spots: dataLineChart,
                                )
                              ]
                          )
                      ),
                    ),
                  ],
                ),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
