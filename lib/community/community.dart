import 'package:flutter/material.dart';

import '../entity/BlogPost.dart';
import 'comments.dart';

class Community extends StatefulWidget {
  @override
  _CommunityState createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  // 假设已经有一个包含20条博客数据的列表
  List<BlogPost> blogPosts = List.generate(20, (index) => BlogPost(
    title: 'Title $index',
    content: 'Content $index',
  ));

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
                  title: Text(blogPosts[index].title),
                  subtitle: Text(blogPosts[index].content),
                ),
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
    );
  }
}
