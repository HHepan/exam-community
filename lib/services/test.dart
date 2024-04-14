import 'package:dio/dio.dart';
import 'package:exam_community/entity/test.dart';
import '../global-config.dart';

class TestService {
  final Dio _dio = Dio();

  Future<Test> save(Test test) async {
    print('test service $test');
    print('test service test.toJson() ${test.toJson()}');
    Response response = await _dio.post(
      '${globalConfig().apiUrl}/test/save',
      data: test.toJson(), // 将用户对象转换为 JSON 格式并发送
    );
    return Test.getOneTestFromJson(response.data);
  }
}