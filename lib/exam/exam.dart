import 'package:flutter/material.dart';

import '../test-api.dart';
import 'exam-screen-1.dart';
import 'exam-screen-2.dart';

class Exam extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Page Exam'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DetailedExamScreen1()),
                );
              },
              child: Text('前往 detailed exam screen 1'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DetailedExamScreen2()),
                );
              },
              child: Text('前往 detailed exam screen 2'),
            ),
            ElevatedButton(
              onPressed: () {
                ApiService().fetchDataFromSpringBoot().then((data) {
                  print(data);
                }).catchError((error) {
                  print(error);
                });
              },
              child: Text('测试连接后台'),
            ),
          ],
        ),
      ),
    );
  }
}