import 'package:dio/dio.dart';
import 'package:exam_community/entity/BlogPost.dart';
import '../global-config.dart';

class BlogPostService {
  final Dio _dio = Dio();

  Future<List<BlogPost>> getAll() async {
    Response response = await _dio.get(
      '${globalConfig().apiUrl}/blog-post/getAll'
    );

    List<Map<String, dynamic>> jsonData = List<Map<String, dynamic>>.from(response.data);

    return BlogPost.getBlogPostListFromJson(jsonData);
  }

  Future<void> save(BlogPost willSaveBlogPost) async {
    Response response = await _dio.post(
        '${globalConfig().apiUrl}/blog-post/save',
        data: willSaveBlogPost.toJson()
    );
  }
}