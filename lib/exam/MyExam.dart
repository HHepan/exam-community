import 'package:flutter/material.dart';
import 'package:exam_community/exam/DetailedPage.dart';

class MyExam extends StatelessWidget {
  MyExam({super.key});
  final int num = 5;
  String beginTime = '2024-04-12 09:00:00';
  String endTime = '2024-04-12 09:30:00';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('我的考试'),
        ),
        body: ListView(
          children: [
            for (int i = 1; i <= num; i++)
              GestureDetector(
                onTap: () {
                  String examStatus = _getExamStatus(i); // 获取考试状态文本
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailedPage(
                          text: examStatus,
                          beginTime: beginTime,
                          endTime: endTime,
                      ), // 将文本传递给 DetailedPage 页面
                    ),
                  );
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: _buildCardContent(i),
                  ),
                ),
              ),
          ],
        ));
  }

  String _getExamStatus(int i) {
    DateTime BeginTime = DateTime.parse(beginTime);
    DateTime EndTime = DateTime.parse(endTime);
    if (EndTime.isAfter(DateTime.now())) {
      return "考试$i（已超时）";
    } else if (BeginTime.isBefore(DateTime.now())) {
      return "考试$i（未参加）";
    } else {
      return "考试$i（进行中）";
    }
  }

  Widget _buildCardContent(int i) {
    String examStatus = _getExamStatus(i); // 获取考试状态文本
    return Text(
      examStatus,
      style: TextStyle(fontSize: 20),
    );
  }
}
