// 用户数据模型
class User {
  final String phone;
  final String password;
  final String sex;
  final String age;
  final String email;

  User({
    required this.phone,
    required this.password,
    this.sex = '',
    this.age = '',
    this.email = ''});

  @override
  String toString() {
    return 'User{phone: $phone, password: $password, sex: $sex, age: $age, email: $email}';
  }
}