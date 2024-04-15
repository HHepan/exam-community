import 'package:dio/dio.dart';
import '../entity/TestAnswerStatus.dart';
import '../global-config.dart';

class TestAnswerStatusService {
  final Dio _dio = Dio();

  Future<void> save(List<TestAnswerStatus> testAnswerStatusList) async {
    Response response = await _dio.post(
      '${globalConfig().apiUrl}/test-answer-status/save',
      data: testAnswerStatusList, // 将用户对象转换为 JSON 格式并发送
    );
  }

  Future<List<TestAnswerStatus>> getTestAnswerStatusListByTestId(int testId) async {
    Response response = await _dio.get(
      '${globalConfig().apiUrl}/test-answer-status/$testId', // 将用户对象转换为 JSON 格式并发送
    );

    print('response $response');
    // 将服务器返回的数据转换为 List<Map<String, dynamic>>
    List<Map<String, dynamic>> jsonData = List<Map<String, dynamic>>.from(response.data);

    return TestAnswerStatus.getTestAnswerStatusListFromJson(jsonData);
  }
}