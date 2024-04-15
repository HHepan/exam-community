import 'package:exam_community/exam/exam-records/records.dart';
import 'package:exam_community/exam/random-questions/random-questions.dart';
import 'package:flutter/material.dart';

class Exam extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 从本地资源加载图片，假设图片文件名为image_example.png
            Image.asset(
              'lib/assets/images/img_2.png',
              width: 700, // 设置图片宽度
              height: 240, // 设置图片高度
            ),
            SizedBox(height: 20),
            Container(
              width: 400, // 设置按钮的最小宽度
              child: FloatingActionButton.extended(
                  onPressed: () => {

                  },
                  label: Text('我的考试', style: TextStyle(fontSize: 20))
              )
            ),
            SizedBox(height: 20),
            Container(
                width: 400, // 设置按钮的最小宽度
                child: FloatingActionButton.extended(
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RandomQuestions()),
                      ),
                    },
                    label: Text('随机测试', style: TextStyle(fontSize: 20))
                )
            ),
            SizedBox(height: 20),
            Container(
                width: 400, // 设置按钮的最小宽度
                child: FloatingActionButton.extended(
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Records()),
                      ),
                    },
                    label: Text('考试/测试记录', style: TextStyle(fontSize: 20))
                )
            )
          ],
        ),
      ),
    );
  }
}