import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TransmitPage extends StatelessWidget {
  final String text;
  final String beginTime;
  final String endTime;
  TransmitPage({
        Key? key,
        required this.text,
        required this.beginTime,
        required this.endTime
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(text),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        children: [
          SizedBox(height: 150),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
              side: BorderSide(color: Colors.black, width: 0.5)
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "考试时间：${beginTime} - ${endTime}",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "考试内容：这是一个测试样例",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "考试总分：100",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              )
            ),
          _buildButton(context)
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context){
    DateTime BeginTime = DateTime.parse(beginTime);
    DateTime EndTime = DateTime.parse(endTime);
    if(DateTime.now().isBefore(BeginTime)) {
      return ElevatedButton(
        onPressed: () {
          _showExamNotStartedDialog(context);
        },
        child: Text('参加考试'),
      );
    } else if (DateTime.now().isAfter(EndTime)) {
      return ElevatedButton(
        onPressed: () {
        },
        child: Text('查看详情'),
      );
    } else {
      return ElevatedButton(
        onPressed: () {},
        child: Text("参加考试"),
      );
    }
  }

  void _showExamNotStartedDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("提示"),
            content: Text("考试还未开始"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('确定'),
              )
            ],
          );
        }
    );
  }
}

