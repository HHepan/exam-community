import 'package:dio/dio.dart';
import '../entity/QuestionBank.dart';
import '../global-config.dart';

class QuestionBankService {
  final Dio _dio = Dio();

  Future<List<QuestionBank>> getAll() async {
    Response response = await _dio.get(
      '${globalConfig().apiUrl}/questionBank/getAll'
    );

    // 将服务器返回的数据转换为 List<Map<String, dynamic>>
    List<Map<String, dynamic>> jsonData = List<Map<String, dynamic>>.from(response.data);

    return QuestionBank.getQuestionBankListFromJson(jsonData);
  }

  Future<QuestionBank> getById(int id) async {
    Response response = await _dio.get(
        '${globalConfig().apiUrl}/questionBank/$id'
    );
    return QuestionBank.getOneQuestionBankFromJson(response.data);
  }
}