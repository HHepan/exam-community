import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> fetchDataFromSpringBoot() async {
    try {
      Response response = await _dio.get('http://your-spring-boot-api-url');

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to load data from API');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
