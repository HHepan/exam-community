import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DoneExam extends StatefulWidget {
  final String title;
  DoneExam({
    Key ? key,
    required this.title
  }) : super(key : key);

  @override
  _DoneExamState createState() => _DoneExamState(title: title);
}

class _DoneExamState extends State<DoneExam> {
  final String title;
  _DoneExamState({required this.title});

  List<Map<String, dynamic>> questions = [
    {
      'question': 'What is 2 + 2?',
      'type': 'choice',
      'options': ['1', '2', '3', '4'],
      'answer': '4',
    },
    {
      'question': 'What is the capital of France?',
      'type': 'choice',
      'options': ['London', 'Paris', 'Berlin', 'Rome'],
      'answer': 'Paris'
    },
    {
      'question': '1 + 1 = _',
      'type': 'blank',
      'answer': '2',
    },
    // Add more questions here
  ];

  int currentQuestionIndex = 0;

  @override
  Widget build(BuildContext context) {
    return _doneExam(context);
  }

  Widget _doneExam(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              questions[currentQuestionIndex]['question'],
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20.0),
            if (questions[currentQuestionIndex]['type'] == 'choice')
              Column(
                children: List.generate(
                  questions[currentQuestionIndex]['options'].length,
                      (index) => ElevatedButton(
                    onPressed: null,
                    child: Text(questions[currentQuestionIndex]['options'][index]),
                  ),
                ),
              ),
            if(questions[currentQuestionIndex]['type'] == 'blank')
              TextField(
                enabled: false,
                onChanged: (text) {
                },
                decoration: InputDecoration(
                  hintText: '在此输入答案',
                  border: OutlineInputBorder(),
                ),
              ),
            Text(
              '正确答案： ${questions[currentQuestionIndex]['answer']}',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 20.0),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (currentQuestionIndex > 0) {
                        currentQuestionIndex--;
                      }
                    });
                  },
                  child: Text('上一题'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (currentQuestionIndex < questions.length - 1) {
                        currentQuestionIndex++;
                      }
                    });
                  },
                  child: Text('下一题'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}