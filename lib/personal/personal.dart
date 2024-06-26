import 'package:exam_community/global-config.dart';
import 'package:flutter/material.dart';
import 'edit-personal.dart';

class Personal extends StatefulWidget {
  final Function onLogout;

  Personal({required this.onLogout});

  @override
  _Personal createState() => _Personal();
}

class _Personal extends State<Personal> {
  void _logoutDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('确认退出？'),
          actions: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // 关闭确认退出对话框
                    },
                    child: Text('取消'),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // 在这里执行退出登录操作
                      widget.onLogout();
                      // 清除当前登录用户信息
                      globalConfig().updateConfig(currentUser: null);
                      // 可以在这里处理清除用户信息等操作
                      Navigator.of(context).pop();  // 关闭确认退出对话框
                    },
                    child: Text(
                      '退出',
                      style: TextStyle(
                        color: ColorScheme.fromSeed(seedColor: Colors.deepOrange).primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FractionallySizedBox(
              widthFactor: 1.0, // 设置宽度占满屏幕
              child: Card(
                elevation: 4,
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${globalConfig().currentUser?.name}，欢迎您~', // 修改为加粗放大的字体
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            '获赞', // 添加点赞图标
                            style: TextStyle(fontSize: 18),
                          ),
                          Icon(Icons.thumb_up), // 点赞图标
                          Text(
                            '：9999', // 添加点赞图标
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 按钮均匀分布
              children: [
                ElevatedButton(
                  onPressed: () {
                    // 点击“我的帖子”按钮的操作
                  },
                  child: Text('我的帖子', style: TextStyle(fontSize: 18)),
                ),
                ElevatedButton(
                  onPressed: () {
                    // 点击“我的评论”按钮的操作
                  },
                  child: Text('我的评论', style: TextStyle(fontSize: 18)),
                ),
                ElevatedButton(
                  onPressed: () {
                    // 点击“我的收藏”按钮的操作
                  },
                  child: Text('我的收藏', style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
            SizedBox(height: 10),
            FractionallySizedBox(
              widthFactor: 1.0,
              child: Card(
                elevation: 4,
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '个人信息',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '性别：${globalConfig().currentUser?.sex != null && globalConfig().currentUser!.sex.isNotEmpty ? globalConfig().currentUser?.sex : "-"}',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '年龄：${globalConfig().currentUser?.age != null && globalConfig().currentUser!.age.isNotEmpty ? globalConfig().currentUser?.age : "-"}',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '手机号：${globalConfig().currentUser?.phone != null && globalConfig().currentUser!.phone.isNotEmpty ? globalConfig().currentUser?.phone : "-"}',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '邮箱：${globalConfig().currentUser?.email != null && globalConfig().currentUser!.email.isNotEmpty ? globalConfig().currentUser?.email : "-"}',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
                width: 400, // 设置按钮的最小宽度
                child: FloatingActionButton.extended(
                    onPressed: _logoutDialog,
                    label: Text('退出登录',
                        style: TextStyle(
                            fontSize: 20,
                            color: ColorScheme.fromSeed(seedColor: Colors.deepOrange).primary)
                    )
                )
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EditPersonal(personalSetState: setPersonalState)),
          );
        },
        child: Icon(Icons.edit),
      ),
    );
  }

  void setPersonalState() {
    setState(() {});
  }
}