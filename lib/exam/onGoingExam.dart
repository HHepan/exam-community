import 'package:flutter/material.dart';

class OnGoingExam extends StatefulWidget {
  final String title;
  OnGoingExam({
    Key ? key,
    required this.title
}) : super(key : key);

  @override
  _OnGoingExamState createState() => _OnGoingExamState(title: title);
}

class _OnGoingExamState extends State<OnGoingExam> {
  final String title;
  _OnGoingExamState({required this.title});

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
  String? userAnswer;

  @override
  Widget build(BuildContext context) {
    return _onGoingExam(context);
  }

  Widget _onGoingExam(BuildContext context) {
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
                    onPressed: () {
                      setState(() {
                        userAnswer = questions[currentQuestionIndex]['options'][index];
                      });
                    },
                    child: Text(questions[currentQuestionIndex]['options'][index]),
                  ),
                ),
              ),
            if(questions[currentQuestionIndex]['type'] == 'blank')
              TextField(
                onChanged: (text) {
                  userAnswer = text;
                },
                decoration: InputDecoration(
                  labelText: '请输入答案',
                  hintText: '在此输入答案',
                  border: OutlineInputBorder(),
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
