import 'package:exam_community/exam/exam-records/view-details.dart';
import 'package:exam_community/global-config.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import '../../entity/Test.dart';
import '../../services/test-service.dart';

class Records extends StatefulWidget {
  @override
  _Records createState() => _Records();
}

class _Records extends State<Records> {
  final TestService _testService = TestService(); // 创建 TestService 实例
  List<Test> testList = [];

  @override
  void initState() {
    super.initState();
    _testService.getListByUserId(globalConfig().currentUser!.id).then((callBackTest) {
      print('_Records init callback $callBackTest');
      // 在这里处理获取到的数据
      setState(() {
        testList = callBackTest;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String formatTime(String timeString) {
      List<String> parts = timeString.split(' ');
      if (parts.length != 2) {
        // 如果字符串格式不正确，则直接返回原字符串
        return timeString;
      }

      String datePart = parts[0]; // 日期部分
      String timePart = parts[1]; // 时间部分

      List<String> timeParts = timePart.split(':');
      if (timeParts.length != 2) {
        // 如果时间格式不正确，则直接返回原字符串
        return timeString;
      }

      int? hour = int.tryParse(timeParts[0]);
      int? minute = int.tryParse(timeParts[1]);

      if (hour != null && minute != null) {
        // 如果成功解析小时和分钟，则进行格式化
        String formattedHour = hour < 10 ? '0$hour' : hour.toString();
        String formattedMinute = minute < 10 ? '0$minute' : minute.toString();
        return '$datePart $formattedHour:$formattedMinute';
      } else {
        // 如果无法解析小时和分钟，则直接返回原字符串
        return timeString;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('考试/测试记录'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: testList.length, // 生成10个卡片
          itemBuilder: (BuildContext context, int index) {
            return FractionallySizedBox(
              widthFactor: 1.0, // 设置宽度占满屏幕
              child: Card(
                elevation: 4,
                margin: EdgeInsets.only(bottom: 16.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${testList[index].name}（随机测试）', // 修改为加粗放大的字体
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '开始时间：${formatTime(testList[index].startTime)}',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '结束时间：${formatTime(testList[index].endTime)}',
                        style: TextStyle(fontSize: 20),
                      ),
                      // SizedBox(height: 10),
                      // Text(
                      //   '作答情况：正确x题/${testList[index].questionNum}题',
                      //   style: TextStyle(fontSize: 20),
                      // ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ViewDetails(testId: testList[index].id)),
                              );
                            },
                            child: Text(
                              '查看详情',
                              style: TextStyle(
                                color: ColorScheme.fromSeed(seedColor: Colors.green).primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}