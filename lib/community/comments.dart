import 'package:flutter/material.dart';

import '../entity/BlogPost.dart';

// 评论数据模型
class Comment {
  final String username;
  final String content;

  Comment({required this.username, required this.content});
}

class Comments extends StatelessWidget {
  final BlogPost blogPost;

  Comments({required this.blogPost});

  // 假设已经有一个包含20条评论数据的列表
  List<Comment> comments = List.generate(20, (index) => Comment(
    username: '用户名 $index',
    content: '评论 $index #################################################',
  ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('帖子详情'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
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
                    ListTile(
                      title: Text(blogPost.title),
                      subtitle: Text(blogPost.content),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              '以下是评论',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(
            thickness: 2, // 设置横线粗细
            color: Colors.black, // 设置横线颜色
          ),
          // 显示评论详情部分
          Expanded(
            child: ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(comments[index].username),
                        subtitle: Text(comments[index].content),
                      ),
                    ],
                  ),
                );
              }
            ),
          ),
          // 输入框
          Container(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              maxLines: null,
              decoration: InputDecoration(
                  hintText: '欢迎留下评论',
                  border: OutlineInputBorder()
              ),
            ),
          ),
        ],
      ),
    );
  }
}