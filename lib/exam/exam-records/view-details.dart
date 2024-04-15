import 'package:flutter/material.dart';

import '../../entity/TestAnswerStatus.dart';
import '../../services/test-answer-status-service.dart';

class ViewDetails extends StatefulWidget {
  final int testId;

  ViewDetails({required this.testId});

  @override
  _ViewDetails createState() => _ViewDetails();
}

class _ViewDetails extends State<ViewDetails> {
  final TestAnswerStatusService _testAnswerStatusService = TestAnswerStatusService(); // 创建 TestService 实例
  List<TestAnswerStatus> _testAnswerStatusList = [];
  String _testName = '';

  @override
  void initState() {
    super.initState();
    _testAnswerStatusService.getTestAnswerStatusListByTestId(widget.testId).then((callBackTest) {
      // 在这里处理获取到的数据
      setState(() {
        _testAnswerStatusList = callBackTest;
        _testName = callBackTest[0].test.name;
      });
    });
  }

  int countCorrectAnswers(List<TestAnswerStatus> testAnswerStatusList) {
    int correctCount = 0;
    for (var testAnswerStatus in testAnswerStatusList) {
      if (testAnswerStatus.adUserAnswer.split('. ')[0] == testAnswerStatus.correctAnswer) {
        correctCount++;
      }
    }
    return correctCount;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${_testName}',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _testAnswerStatusList.length,
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
                              '${index + 1}. ${_testAnswerStatusList[index].question.stem}',
                              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black87),
                            ),
                          ),
                          Icon(
                            _testAnswerStatusList[index].adUserAnswer.split('. ')[0] == _testAnswerStatusList[index].correctAnswer ? Icons.check_circle : Icons.cancel,
                            color: _testAnswerStatusList[index].adUserAnswer.split('. ')[0] == _testAnswerStatusList[index].correctAnswer ? Colors.green : Colors.red,
                          ),
                        ],
                      )
                    ),
                    ...List<Widget>.generate(parseOptions(_testAnswerStatusList[index].question.options).length, (int i) {
                      return ListTile(
                        title: Text(
                          parseOptions(_testAnswerStatusList[index].question.options)[i],
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
                          '你的答案：${_testAnswerStatusList[index].adUserAnswer.split('. ')[0]}',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '正确答案：${_testAnswerStatusList[index].correctAnswer}',
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
                  '正确 ${countCorrectAnswers(_testAnswerStatusList)} 题 /',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  ' 共 ${_testAnswerStatusList.length} 题',
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