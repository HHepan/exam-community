import 'package:exam_community/login/login.dart';
import 'package:flutter/material.dart';
import '../entity/User.dart';
import '../services/user-service.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final UserService _userService = UserService(); // 创建 UserService 实例
  TextEditingController _nameRegController = TextEditingController();
  TextEditingController _phoneRegController = TextEditingController();
  TextEditingController _passwordRegController = TextEditingController();

  @override
  void dispose() {
    _nameRegController.dispose();
    _phoneRegController.dispose();
    _passwordRegController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void _dialog() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('恭喜！注册成功'),
            actions: [
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();  // 关闭确认退出对话框
                        Navigator.pop(context);  // 返回登录界面
                      },
                      child: Text('返回登录界面'),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorScheme.fromSeed(seedColor: Colors.lightBlue).inversePrimary,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text('用户注册',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _nameRegController,
              decoration: InputDecoration(labelText: '昵称'),
              onChanged: (value) {
              },
            ),
            SizedBox(height: 20),
            TextField(
              controller: _phoneRegController,
              decoration: InputDecoration(labelText: '手机号'),
              onChanged: (value) {
              },
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordRegController,
              decoration: InputDecoration(labelText: '密码'),
              obscureText: true,
              onChanged: (value) {
              },
            ),
            SizedBox(height: 20),
            Container(
                width: 400, // 设置按钮的最小宽度
                child: FloatingActionButton.extended(
                    onPressed: () async {
                      User user = User(
                        name: _nameRegController.text,
                        phone: _phoneRegController.text,
                        password: _passwordRegController.text,
                      );
                      print('will register ${user}');
                      User registerUser = await _userService.register(user);
                      if (registerUser.phone != '') {
                        _dialog();
                      }
                    },
                    label: Text('确认注册',
                        style: TextStyle(
                            fontSize: 20,
                            color: ColorScheme.fromSeed(seedColor: Colors.green).primary)
                    )
                )
            ),
          ],
        ),
      ),
    );
  }
}