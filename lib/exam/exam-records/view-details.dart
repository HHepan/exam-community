import 'package:flutter/material.dart';

import '../../services/test-answer-status-service.dart';

class ViewDetails extends StatefulWidget {
  final int testId;

  ViewDetails({required this.testId});

  @override
  _ViewDetails createState() => _ViewDetails();
}

class _ViewDetails extends State<ViewDetails> {
  final TestAnswerStatusService _testAnswerStatusService = TestAnswerStatusService(); // 创建 TestService 实例

  @override
  void initState() {
    super.initState();
    _testAnswerStatusService.getTestAnswerStatusListByTestId(widget.testId).then((callBackTest) {
      print('ViewDetails callBackTest $callBackTest');
      // 在这里处理获取到的数据
      setState(() {

      });
    });
  }

  // 假设题目数据
  List<Map<String, dynamic>> showQuestions = [
    {
      'id': '1',
      'question': '题干1',
      'options': ['1', '2', '3', '4'],
      'selectedOption': '',
    },
    {
      'id': '2',
      'question': '题干2',
      'options': ['1', '2', '3', '4'],
      'selectedOption': '',
    }
  ];
  @override
  Widget build(BuildContext context) {
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
              itemCount: showQuestions.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${index + 1}. ${showQuestions[index]['question']}',
                              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black87),
                            ),
                          ),
                          Icon(
                            false ? Icons.check_circle : Icons.cancel,
                            color: false ? Colors.green : Colors.red,
                          ),
                        ],
                      )
                    ),
                    ...List<Widget>.generate(showQuestions[index]['options'].length, (int i) {
                      return ListTile(
                        title: Text(
                          showQuestions[index]['options'][i],
                          style: TextStyle(fontSize: 22.0, color: Colors.black54),
                        ),
                      );
                    }),
                    SizedBox(height: 10.0), // 添加间距
                    Divider(height: 1.0, color: Colors.grey), // 添加分割线
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          '你的答案：X',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          ' 正确答案：Q',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '回答正确',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Divider(height: 1.0, color: Colors.grey),
                    SizedBox(height: 10.0), // 添加间距
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '正确 xx 题 /',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  ' 共 xx 题',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}