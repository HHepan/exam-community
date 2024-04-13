import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'examing.dart'; // 导入服务类库

class RandomQuestions extends StatefulWidget {
  @override
  _RandomQuestionsState createState() => _RandomQuestionsState();
}

class _RandomQuestionsState extends State<RandomQuestions> {
  String _selectedItem = '请选择题库'; // 默认选中项
  bool _showInputFields = false; // 控制输入框的显示与隐藏

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
                  items: <String>[
                    '请选择题库',
                    '考研数学',
                    '考研英语',
                    '考研政治'
                  ].map<DropdownMenuItem<String>>((String value) {
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
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Examing()),
                      )
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
