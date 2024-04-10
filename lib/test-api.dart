import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<String> fetchDataFromSpringBoot() async {
    try {
      Response response = await _dio.get('http://192.168.85.1:8080/flutter/getAll');

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
