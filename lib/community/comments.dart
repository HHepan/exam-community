import 'package:flutter/material.dart';

import '../entity/BlogPost.dart';

class Comments extends StatelessWidget {
  final BlogPost blogPost;

  Comments({required this.blogPost});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('帖子详情'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          ListTile(
            title: Text(blogPost.title),
            subtitle: Text(blogPost.content),
          ),
          // 显示评论详情部分
          Expanded(
            child: ListView(
              children: [
                // 评论列表
              ],
            ),
          ),
          // 输入框
          Container(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(hintText: '欢迎留下评论'),
            ),
          ),
        ],
      ),
    );
  }
}