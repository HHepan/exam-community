import 'dart:ffi';

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
  var _title = '主页';

  static List<Widget> _widgetOptions = <Widget>[
    Exam(),
    Community(),
    Personal(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 0) {
        _title = '主页';
      } else if (_selectedIndex == 1) {
        _title = '社区';
      } else if (_selectedIndex == 2) {
        _title = '我的';
      }
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
            title: Text(_title),
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