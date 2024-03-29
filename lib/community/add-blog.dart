import 'package:flutter/material.dart';

class AddBlog extends StatelessWidget {
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
                width: 300, // 设置父容器的宽度
                child: ElevatedButton(
                  onPressed: () {
                    // 按钮点击事件处理逻辑
                  },
                  child: Text('确认发布'),
                ),
              ),
              Container(
                width: 300, // 设置父容器的宽度
                child: ElevatedButton(
                  onPressed: () {
                    // 按钮点击事件处理逻辑
                  },
                  child: Text('取消'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}