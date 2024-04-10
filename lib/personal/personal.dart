import 'package:flutter/material.dart';

import 'edit-personal.dart';

class Personal extends StatelessWidget {
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
                        '张三，欢迎您~', // 修改为加粗放大的字体
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '用户账号：',
                        style: TextStyle(fontSize: 18),
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
                        '性别：男',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '年龄：20',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '手机号：13100000000',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '邮箱：123456@mail.com',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EditPersonal()),
          );
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}