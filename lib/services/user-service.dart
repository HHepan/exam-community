import 'package:dio/dio.dart';
import 'package:exam_community/entity/User.dart';
import '../global-config.dart';

class UserService {
  final Dio _dio = Dio();

  Future<User> login(User user) async {
    Response response = await _dio.post(
        '${globalConfig().apiUrl}/ad-user/login',
      data: user.toJson(), // 将用户对象转换为 JSON 格式并发送
    );

    if (response.statusCode == 200) {
      return User.getUserFromJson(response.data);
    } else {
      throw Exception('Failed to load data from API');
    }
  }

  Future<User> register(User user) async {
    Response response = await _dio.post(
      '${globalConfig().apiUrl}/ad-user/register',
      data: user.toJson(), // 将用户对象转换为 JSON 格式并发送
    );
    return User.getUserFromJson(response.data);
  }

  Future<User> update(User user) async {
    Response response = await _dio.post(
      '${globalConfig().apiUrl}/ad-user/update',
      data: user.toJson(), // 将用户对象转换为 JSON 格式并发送
    );
    return User.getUserFromJson(response.data);
  }
}