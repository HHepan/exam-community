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
}