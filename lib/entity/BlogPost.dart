// 博客数据模型
import 'User.dart';

class BlogPost {
  final int id;
  final String postTime;
  final String content;
  User adUser;
  int likes;
  int comments;

  BlogPost({
    this.id = 0,
    required this.content,
    required this.postTime,
    required this.adUser,
    this.likes = 0,
    this.comments = 0});

  @override
  String toString() {
    return 'BlogPost{id: $id, postTime: $postTime, user: $adUser, content: $content, likes: $likes, comments: $comments}';
  }

  static List<BlogPost> getBlogPostListFromJson(List<Map<String, dynamic>> json) {
    List<BlogPost> blogPosts = [];
    for (var i = 0; i < json.length; i++) {
      blogPosts.add(BlogPost(
          id: json[i]['id'] ?? 0,
          postTime: json[i]['postTime'] ?? '',
          content: json[i]['content'] ?? '',
          likes: json[i]['likes'] ?? '',
          comments: json[i]['comments'] ?? '',
          adUser: User.getUserFromJson(json[i]['adUser']),
      ));
    }

    return blogPosts;
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'postTime': postTime,
    'adUser': adUser.toJson(),
    'content': content,
    'likes': likes,
    'comments': comments,
  };
}