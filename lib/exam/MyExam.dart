import 'package:flutter/material.dart';
import 'package:exam_community/exam/TransmitPage.dart';

class MyExam extends StatelessWidget {
  MyExam({super.key});
  final int num = 5;
  String beginTime = '2024-04-12 08:00:00';
  String endTime = '2024-04-12 08:30:00';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('我的考试'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: ListView(
          children: [
            for (int i = 1; i <= num; i++)
              GestureDetector(
                onTap: () {
                  String examStatus = _getExamStatus(i);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TransmitPage(
                          text: examStatus,
                          beginTime: beginTime,
                          endTime: endTime,
                      ),
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
    DateTime now = DateTime.now();
    if (now.isAfter(EndTime)) {
      return "考试$i（已超时）";
    } else if (now.isBefore(BeginTime)) {
      return "考试$i（未开始）";
    } else {
      return "考试$i（进行中）";
    }
  }

  Widget _buildCardContent(int i) {
    String examStatus = _getExamStatus(i);
    return Text(
      examStatus,
      style: TextStyle(fontSize: 20),
    );
  }
}

