import 'package:exam_community/entity/BlogPost.dart';
import 'package:exam_community/global-config.dart';
import 'package:flutter/material.dart';

import '../entity/User.dart';
import '../services/blog-post-service.dart';

class AddBlog extends StatelessWidget {
  TextEditingController _contentController = TextEditingController();
  final BlogPostService _blogPostService = BlogPostService(); // 创建 TestService 实例

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('发布帖子'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                controller: _contentController,
                minLines: 5, // 设置最小行数为 5
                maxLines: null, // 不限制最大行数
                decoration: InputDecoration(
                    hintText: '请输入内容',
                    border: OutlineInputBorder()
                ),
              ),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 360, // 设置父容器的宽度
                child: ElevatedButton(
                  onPressed: () async {
                    DateTime now = DateTime.now().toLocal();
                    String postTime = '${now.year}-${now.month}-${now.day} ${now.hour}:${now.minute}';
                    // 按钮点击事件处理逻辑
                    BlogPost willSaveBlogPost = BlogPost(
                        content: _contentController.text,
                        postTime: postTime,
                        adUser: globalConfig().currentUser as User,
                    );
                    await _blogPostService.save(willSaveBlogPost);
                    Navigator.pop(context, true);
                  },
                  child: Text('确认发布'),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}