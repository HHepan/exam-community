import 'entity/User.dart';

class globalConfig {
  // 单例模式
  static final globalConfig _instance = globalConfig._internal();

  factory globalConfig() {
    return _instance;
  }

  globalConfig._internal();

  // 全局配置属性
  String apiUrl = 'http://192.168.85.1:8080';
  User? currentUser; // 当前登录用户
  // 添加其他全局配置属性

  // 更新全局配置
  void updateConfig({
    User? currentUser,
    String? apiUrl,
    // 添加其他配置项
  }) {
    this.currentUser = currentUser;
    if (apiUrl != null) {
      this.apiUrl = apiUrl;
    }
    // 更新其他配置项
  }
}