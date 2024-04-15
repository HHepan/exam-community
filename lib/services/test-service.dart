import 'package:dio/dio.dart';
import 'package:exam_community/entity/Test.dart';
import '../global-config.dart';

class TestService {
  final Dio _dio = Dio();

  Future<Test> save(Test test) async {
    Response response = await _dio.post(
      '${globalConfig().apiUrl}/test/save',
      data: test.toJson(), // 将用户对象转换为 JSON 格式并发送
    );
    return Test.getOneTestFromJson(response.data);
  }

  Future<Test> getById(int id) async {
    Response response = await _dio.get(
      '${globalConfig().apiUrl}/test/$id');
    return Test.getOneTestFromJson(response.data);
  }

  getListByUserId(int id) async {
    Response response = await _dio.get(
        '${globalConfig().apiUrl}/test/get-list-by-user-id/$id');

    List<Map<String, dynamic>> jsonData = List<Map<String, dynamic>>.from(response.data);

    return Test.getTestListFromJson(jsonData);
  }
}