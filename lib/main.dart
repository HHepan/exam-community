import 'package:exam_community/personal/personal.dart';
import 'package:flutter/material.dart';
import 'community/community.dart';
import 'exam/exam.dart';
import 'login/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _title = '主页';
  int _selectedIndex = 0;

  void onLogin() {
    setState(() {
      isLoggedIn = true;
    });
  }

  void onLogout() {
    setState(() {
      isLoggedIn = false;
      _selectedIndex = 0;
    });
  }

  List<Widget> _widgetOptions(BuildContext context) {
    return [
      Exam(),
      Community(),
      Personal(onLogout: onLogout),
    ];
  }

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
    if (!isLoggedIn) {
      return MaterialApp(
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
            useMaterial3: true,
          ),
        home: Login(onLogin: onLogin)
      );
    } else {
      return MaterialApp(
        title: 'exam-community-app',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
          useMaterial3: true,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text(_title),
            backgroundColor: ColorScheme.fromSeed(seedColor: Colors.lightBlue).inversePrimary,
          ),
          body: Center(child: _widgetOptions(context).elementAt(_selectedIndex)),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.home), label: '主页'),
              BottomNavigationBarItem(icon: Icon(Icons.group), label: '社区'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: '我的'),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ),
      );
    }
  }
}

bool isLoggedIn = false; // 用户登录状态，默认为false