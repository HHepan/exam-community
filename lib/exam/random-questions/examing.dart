import 'package:exam_community/entity/Question.dart';
import 'package:exam_community/global-config.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import '../../entity/Test.dart';
import '../../entity/TestAnswerStatus.dart';
import '../../entity/User.dart';
import '../../services/test-answer-status-service.dart';
import '../../services/test.dart';
import '../exam.dart'; // 导入 Timer 类库

class Examing extends StatefulWidget {
  final int testId;

  Examing({required this.testId});

  @override
  _ExamingState createState() => _ExamingState();
}

class _ExamingState extends State<Examing> {
  final TestService _testService = TestService(); // 创建 TestService 实例
  final TestAnswerStatusService _testAnswerStatusService = TestAnswerStatusService(); // 创建 TestService 实例
  String testName = '测试名称';
  late Test thisTest;
  int _remainingTimeInSeconds = 0; // 设置初始剩余时间为1800秒（30分钟）
  late Timer _timer; // 声明 Timer 变量

  // 假设题目数据
  List<Map<String, dynamic>> showQuestions = [];

  @override
  void initState() {
    super.initState();
    startCountdownTimer(); // 启动倒计时
    _testService.getById(widget.testId).then((callBackTest) {
      // 在这里处理获取到的数据
      setState(() {
        thisTest = callBackTest;
        callBackTest.questions.forEach((question) {
          showQuestions.add(
              {
                'id': '${question.id}',
                'question': '${question.stem}',
                'options': parseOptions(question.options),
                'selectedOption': '',
              }
          );
        });
        _remainingTimeInSeconds = calculateTimeDifference(callBackTest.startTime, callBackTest.endTime) * 60;
        testName = callBackTest.name;
      });
    });
  }

  int calculateTimeDifference(String startTimeStr, String endTimeStr) {
    DateTime startTime = _parseTime(startTimeStr);
    DateTime endTime = _parseTime(endTimeStr);

    Duration difference = endTime.difference(startTime);

    return difference.inMinutes;
  }

  DateTime _parseTime(String timeStr) {
    List<String> parts = timeStr.split(' ');
    List<String> dateParts = parts[0].split('-');
    List<String> timeParts = parts[1].split(':');

    int year = int.parse(dateParts[0]);
    int month = int.parse(dateParts[1]);
    int day = int.parse(dateParts[2]);
    int hour = int.parse(timeParts[0]);
    int minute = int.parse(timeParts[1]);

    return DateTime(year, month, day, hour, minute);
  }


  List<String> parseOptions(String input) {
    List<String> options = input.split(';');
    List<String> formattedOptions = [];

    for (String option in options) {
      List<String> parts = option.split('-');
      if (parts.length == 2) {
        String formattedOption = "${parts[0].trim()}. ${parts[1].trim()}";
        formattedOptions.add(formattedOption);
      }
    }

    return formattedOptions;
  }

  void startCountdownTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTimeInSeconds > 0) {
          _remainingTimeInSeconds--;
        } else {
          timer.cancel(); // 停止计时器
          // 处理时间到的逻辑
        }
      });
    });
  }

  void _submitDialog(bool isBack) {
    String title = '确认交卷？';
    if (isBack) {
      title = '退出此页面系统将自动为您提交作答，请确认？';
    }
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 12),
                Text('交卷后可在考试/测试记录中查看', style: TextStyle(fontSize: 18)),
              ],
            ),
          ],
        ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // 关闭确认退出对话框
                    },
                    child: Text('取消'),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      onSave();
                      Navigator.of(context).pop();  // 关闭确认退出对话框
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Text(
                      '确定',
                      style: TextStyle(
                        color: ColorScheme.fromSeed(seedColor: Colors.green).primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  onSave() {
    List<TestAnswerStatus> willSaveItemList = [];

    showQuestions.forEach((showQuestion) {
      Question questionSpy = thisTest.questions[0];
      thisTest.questions.forEach((element) {
        if (element.id.toString() == showQuestion['id']) {
          questionSpy = element;
        }
      });

      TestAnswerStatus willSaveItem = TestAnswerStatus(
        adUserAnswer: showQuestion['selectedOption'],
        correctAnswer: questionSpy.answer,
        adUser: globalConfig().currentUser as User,
        test: thisTest,
        question: questionSpy,
      );
      willSaveItemList.add(willSaveItem);
    });

    _testAnswerStatusService.save(willSaveItemList);
  }

  @override
  void dispose() {
    _timer.cancel(); // 销毁计时器
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int minutes = (_remainingTimeInSeconds ~/ 60); // 计算剩余分钟数
    int seconds = _remainingTimeInSeconds % 60; // 计算剩余秒数

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$testName',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            _submitDialog(true);
          },
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: showQuestions.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        '${index + 1}. ${showQuestions[index]['question']}',
                        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                    ),
                    ...List<Widget>.generate(showQuestions[index]['options'].length, (int i) {
                      return RadioListTile(
                        title: Text(
                          showQuestions[index]['options'][i],
                          style: TextStyle(fontSize: 19.0, color: Colors.black54),
                        ),
                        value: showQuestions[index]['options'][i],
                        groupValue: showQuestions[index]['selectedOption'],
                        onChanged: (value) {
                          setState(() {
                            showQuestions[index]['selectedOption'] = value.toString();
                          });
                        },
                        activeColor: Colors.blue, // 选中项的颜色
                      );
                    }),
                    SizedBox(height: 10.0), // 添加间距
                    Divider(height: 1.0, color: Colors.grey), // 添加分割线
                    SizedBox(height: 10.0), // 添加间距
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '剩余时间: ${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}', // 显示剩余时间
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: () {
                    _submitDialog(false);
                  },
                  child: Text('我要交卷'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15), // 按钮内边距
                    textStyle: TextStyle(fontSize: 18), // 按钮文字样式
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
