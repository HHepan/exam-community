import 'package:flutter/material.dart';
import 'dart:async';

import '../exam.dart'; // 导入 Timer 类库

class Examing extends StatefulWidget {
  @override
  _ExamingState createState() => _ExamingState();
}

class _ExamingState extends State<Examing> {
  // 假设题目数据
  List<Map<String, dynamic>> questions = [
    {
      'question': '问题1：Flutter是哪个公司开发的？',
      'options': ['A. Google', 'B. Facebook', 'C. Microsoft', 'D. Apple'],
      'selectedOption': '',
    },
    {
      'question': '问题2：Flutter的语言是什么？',
      'options': ['A. Dart', 'B. Java', 'C. Swift', 'D. C#'],
      'selectedOption': '',
    },
    // 添加更多题目...
  ];

  int _remainingTimeInSeconds = 10; // 设置初始剩余时间为1800秒（30分钟）
  late Timer _timer; // 声明 Timer 变量

  @override
  void initState() {
    super.initState();
    startCountdownTimer(); // 启动倒计时
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

  void _submitDialog() {
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
                Text('确认交卷？', style: TextStyle(fontWeight: FontWeight.bold)),
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
          '<测试名称>',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: questions.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        questions[index]['question'],
                        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                    ),
                    ...List<Widget>.generate(questions[index]['options'].length, (int i) {
                      return RadioListTile(
                        title: Text(
                          questions[index]['options'][i],
                          style: TextStyle(fontSize: 19.0, color: Colors.black54),
                        ),
                        value: questions[index]['options'][i],
                        groupValue: questions[index]['selectedOption'],
                        onChanged: (value) {
                          setState(() {
                            questions[index]['selectedOption'] = value.toString();
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
                  onPressed: _submitDialog,
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
