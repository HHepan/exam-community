// 博客数据模型
class BlogPost {
  final String title;
  final String content;
  int likes;
  int comments;

  BlogPost({
    required this.title,
    required this.content,
    this.likes = 0,
    this.comments = 0});

  @override
  String toString() {
    return 'BlogPost{BlogPost: $title, content: $content, likes: $likes, comments: $comments}';
  }
}