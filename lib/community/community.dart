import 'package:flutter/material.dart';

import '../entity/BlogPost.dart';
import '../services/blog-post-service.dart';
import 'add-blog.dart';
import 'comments.dart';

class Community extends StatefulWidget {
  @override
  _CommunityState createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  final BlogPostService _blogPostService = BlogPostService(); // 创建 TestService 实例
  List<BlogPost> blogPosts = [];

  @override
  void initState() {
    super.initState();
    refresh();
  }

  void refresh() {
    print('refresh');
    _blogPostService.getAll().then((callBackBlogPostList) {
      // 在这里处理获取到的数据
      setState(() {
        blogPosts = callBackBlogPostList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: blogPosts.length,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              children: [
                ListTile(
                  title: Text(blogPosts[index].adUser.name),
                  subtitle: Text('发布时间：${blogPosts[index].postTime}'),
                ),
                SizedBox(height: 10),
                Container( // 使用 Container 组件包裹 Text 组件，并设置 alignment 为 Alignment.centerLeft
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '   ${blogPosts[index].content}',
                    style: TextStyle(fontSize: 22.0, color: Colors.black),
                  ),
                ),
                SizedBox(height: 10),
                ButtonBar(
                  alignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.thumb_up),
                      onPressed: () {
                        setState(() {
                          blogPosts[index].likes++;
                        });
                      },
                    ),
                    Text('${blogPosts[index].likes}'),
                    IconButton(
                      icon: Icon(Icons.comment),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Comments(blogPost: blogPosts[index])),
                        );
                      },
                    ),
                    Text('${blogPosts[index].comments}'),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddBlog()),
          ).then((value) {
            print('value $value');
            if (value == true) {
              refresh();
            }
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
