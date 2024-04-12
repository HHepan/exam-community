import 'package:exam_community/login/register.dart';
import 'package:flutter/material.dart';
import '../entity/User.dart';
import '../services/user-service.dart';

class Login extends StatefulWidget {
  final Function onLogin;

  Login({required this.onLogin});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final UserService _userService = UserService(); // 创建 UserService 实例
  String _errorMessage = ''; // 用于存储错误消息
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorScheme.fromSeed(seedColor: Colors.lightBlue).inversePrimary,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text('欢迎登录',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: '手机号'),
              onChanged: (value) {
              },
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: '密码'),
              obscureText: true,
              onChanged: (value) {
              },
            ),
            SizedBox(height: 20),
            Text(
              _errorMessage,
              style: TextStyle(color: Colors.red),
            ),
            SizedBox(height: 20),
            Container(
                width: 400, // 设置按钮的最小宽度
                child: FloatingActionButton.extended(
                    onPressed: () async {
                      User user = User(
                        phone: _phoneController.text,
                        password: _passwordController.text,
                      );
                      User loginUser = await _userService.login(user);
                      if (loginUser.phone != '') {
                        // 调用父组件传递的登录回调函数
                        widget.onLogin();
                      } else {
                        // 用户名或者密码错误，执行这里
                        setState(() {
                          _errorMessage = '用户名或密码错误，请再试';
                        });
                      }
                    },
                    label: Text('登录',
                        style: TextStyle(
                            fontSize: 20,
                            color: ColorScheme.fromSeed(seedColor: Colors.green).primary)
                    )
                )
            ),
            SizedBox(height: 20),
            Container(
                width: 400, // 设置按钮的最小宽度
                child: FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Register()),
                      );
                    },
                    label: Text('还没有账号？点我注册',
                        style: TextStyle(
                            fontSize: 20,
                            color: ColorScheme.fromSeed(seedColor: Colors.black87).primary)
                    )
                )
            ),
          ],
        ),
      ),
    );
  }
}