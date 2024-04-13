import 'package:exam_community/entity/QuestionBank.dart';
import 'package:exam_community/entity/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../services/question-bank-service.dart';
import 'examing.dart'; // 导入服务类库

class RandomQuestions extends StatefulWidget {
  @override
  _RandomQuestionsState createState() => _RandomQuestionsState();
}

class _RandomQuestionsState extends State<RandomQuestions> {
  final QuestionBankService _questionBankService = QuestionBankService(); // 创建 UserService 实例
  String _selectedItem = '请选择题库'; // 默认选中项
  TextEditingController _testNameController = TextEditingController();
  TextEditingController _testQuestionNumController = TextEditingController();
  TextEditingController _testTimeController = TextEditingController();
  bool _showInputFields = false; // 控制输入框的显示与隐藏
  List<QuestionBank> allQuestionBanks = [];
  List<String> questionBanksItems = <String>[
  '请选择题库'
  ];

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
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => Examing()),
                      // )
                      print('当前所选择的题库名称：$_selectedItem');
                      allQuestionBanks.forEach((element) async {
                        if (element.name == _selectedItem) {
                          print('当前所选的题库：${element.id}');
                          QuestionBank selectedQuestionBank = await _questionBankService.getById(element.id);
                          print('getById 返回的题库数据 $selectedQuestionBank');
                          print('_testNameController ${_testNameController.text}');
                          print('_testQuestionNumController ${_testQuestionNumController.text}');
                          print('_testTimeController ${_testTimeController.text}');
                          Test willSaveTest = Test(
                            name: _testNameController.text,
                            questionsNum: _testQuestionNumController.text,
                            questions: selectedQuestionBank.questions,
                            startTime: DateTime.now().toString(),
                            endTime: DateTime.now().add(Duration(minutes: int.parse(_testTimeController.text))).toString()
                          );
                          print('willSaveTest $willSaveTest');
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
