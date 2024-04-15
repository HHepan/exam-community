import 'dart:math';

import 'package:exam_community/entity/QuestionBank.dart';
import 'package:exam_community/entity/Test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../entity/Question.dart';
import '../../services/question-bank-service.dart';
import '../../services/test-service.dart';
import 'examing.dart';

class RandomQuestions extends StatefulWidget {
  @override
  _RandomQuestionsState createState() => _RandomQuestionsState();
}

class _RandomQuestionsState extends State<RandomQuestions> {
  final QuestionBankService _questionBankService = QuestionBankService(); // 创建 QuestionBankService 实例
  final TestService _testService = TestService(); // 创建 TestService 实例
  String _selectedItem = '请选择题库'; // 默认选中项
  TextEditingController _testNameController = TextEditingController();
  TextEditingController _testQuestionNumController = TextEditingController();
  TextEditingController _testTimeController = TextEditingController();
  bool _showInputFields = false; // 控制输入框的显示与隐藏
  List<QuestionBank> allQuestionBanks = [];
  List<String> questionBanksItems = <String>[
  '请选择题库'
  ];
  Test _willSaveTest = Test();

  @override
  void initState() {
    super.initState();
    _questionBankService.getAll().then((questionBanks) {
      // 在这里处理获取到的数据
      setState(() {
        allQuestionBanks = questionBanks;
        questionBanks.forEach((element) {
          questionBanksItems.add(element.name);
        });
      });
    });
  }

  void _startTestDialog() {
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
                  Text('${_willSaveTest.name}', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 12),
                  Text('共${_willSaveTest.questionNum}道题', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 12),
                  Text('${_willSaveTest.startTime}开始', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 12),
                  Text('预计${_willSaveTest.endTime}结束', style: TextStyle(fontSize: 18)),
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
                    child: Text('稍等一下'),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () async {
                      Test savedTest = await _testService.save(_willSaveTest);
                      if (savedTest.id != 0) {
                        Navigator.of(context).pop();  // 关闭确认退出对话框
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Examing(testId: savedTest.id)),
                        );
                      }
                    },
                    child: Text(
                      '开始答题',
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

  List<int> generateRandomNumbers(int number, int max) {
    if (number <= 0 || max <= 0 || number > max) {
      throw ArgumentError('Invalid input parameters');
    }

    Set<int> selectedNumbers = {};
    Random random = Random();

    while (selectedNumbers.length < number) {
      int randomNumber = random.nextInt(max);
      if (!selectedNumbers.contains(randomNumber)) {
        selectedNumbers.add(randomNumber);
      }
    }

    return selectedNumbers.toList();
  }

  List<Question> getRandomQuestions(List<Question> questions, int num) {
    List<Question> result = [];
    List<int> randomNumbers = generateRandomNumbers(num, questions.length);
    randomNumbers.forEach((element) {
      result.add(questions[element]);
    });
    return result;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('随机测试'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _testNameController,
              decoration: InputDecoration(
                labelText: '测试名称',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: InputDecorator(
              decoration: InputDecoration(
                labelText: '题库',
                border: OutlineInputBorder(),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedItem,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedItem = newValue!;
                      if (_selectedItem != '请选择题库') {
                        _showInputFields = true; // 当选择了题库时显示输入框
                      } else {
                        _showInputFields = false;
                      }
                    });
                  },
                  items: questionBanksItems.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          if (_showInputFields) // 根据_showInputFields的值来判断是否显示输入框
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: _testQuestionNumController,
                decoration: InputDecoration(
                  labelText: '题目总数',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number, // 设置输入键盘类型为数字键盘
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly, // 只允许输入数字
                  LengthLimitingTextInputFormatter(3), // 最大长度为3
                ],
              ),
            ),
          if (_showInputFields)
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: _testTimeController,
                decoration: InputDecoration(
                  labelText: '测试时长（单位：分钟）',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number, // 设置输入键盘类型为数字键盘
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly, // 只允许输入数字
                  LengthLimitingTextInputFormatter(3), // 最大长度为3
                ],
              ),
            ),
          if (_showInputFields)
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 360, // 设置父容器的宽度
                  child: ElevatedButton(
                    onPressed: () {
                      allQuestionBanks.forEach((element) async {
                        if (element.name == _selectedItem) {
                          QuestionBank selectedQuestionBank = await _questionBankService.getById(element.id);
                          DateTime now = DateTime.now().toLocal();
                          DateTime end = now.add(Duration(minutes: int.parse(_testTimeController.text)));
                          String startTime = '${now.year}-${now.month}-${now.day} ${now.hour}:${now.minute}';
                          String endTime = '${end.year}-${end.month}-${end.day} ${end.hour}:${end.minute}';

                          Test willSaveTest = Test(
                            name: _testNameController.text,
                            questionNum: _testQuestionNumController.text,
                            questions: getRandomQuestions(selectedQuestionBank.questions, int.parse(_testQuestionNumController.text)),
                            startTime: startTime,
                            endTime: endTime
                          );
                          _willSaveTest = willSaveTest;
                          _startTestDialog();
                        }
                      });
                    },
                    child: Text('随机出题并开始测试'),
                  ),
                )
              ],
            ),
        ],
      ),
    );
  }
}
