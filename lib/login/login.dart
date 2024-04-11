import 'package:flutter/material.dart';
import '../entity/User.dart';

class Login extends StatefulWidget {
  final Function onLogin;

  Login({required this.onLogin});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _phoneController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    @override
    void dispose() {
      _phoneController.dispose();
      _passwordController.dispose();
      super.dispose();
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
            Container(
                width: 400, // 设置按钮的最小宽度
                child: FloatingActionButton.extended(
                    onPressed: () {
                      User user = User(
                        phone: _phoneController.text,
                        password: _passwordController.text,
                      );
                      print('${user}');
                      // 调用父组件传递的登录回调函数
                      widget.onLogin();
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
                      // 调用父组件传递的登录回调函数
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