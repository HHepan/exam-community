import 'package:exam_community/personal/personal.dart';
import 'package:flutter/material.dart';

import 'community/community.dart';
import 'exam/exam.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    Exam(),
    Community(),
    Personal(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'exam-community-app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
            title: const Text('研考社'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: '主页'),
            BottomNavigationBarItem(icon: Icon(Icons.business), label: '社区'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: '我的'),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}