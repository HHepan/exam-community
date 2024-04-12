import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailedPage extends StatelessWidget {
  final String text;
  final String beginTime;
  final String endTime;
  DetailedPage({Key? key, required this.text, required this.beginTime, required this.endTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(text),
      ),
      body: ListView(
        children: [
          SizedBox(height: 150),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
              side: BorderSide(color: Colors.black, width: 2.0)
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 30, 0, 100),
              child: Text(
                "考试时间：$beginTime - $endTime\n考试内容：这是一个测试样例\n考试总分：100",
                style: TextStyle(
                  fontSize: 15,
                ),
              )
              )
            ),
          ElevatedButton(
              onPressed: (){},
              child: Text("查看详情")
          )
        ],
      ),
    );
  }
}