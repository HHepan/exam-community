// 用户数据模型
class User {
  final String phone;
  final String password;
  final String sex;
  final String name;
  final String age;
  final String email;

  User({
    required this.phone,
    required this.password,
    this.sex = '',
    this.name = '',
    this.age = '',
    this.email = ''});

  @override
  String toString() {
    return 'User{phone: $phone, password: $password, sex: $sex, name: $name, age: $age, email: $email}';
  }

  static User getUserFromJson(Map<String, dynamic> json) {
    String phoneFromJson = '';
    String passwordFromJson = '';
    String sexFromJson = '';
    String nameFromJson = '';
    String ageFromJson = '';
    String emailFromJson = '';

    if (json['phone'] != null) {
      phoneFromJson = json['phone'];
    }
    if (json['name'] != null) {
      nameFromJson = json['name'];
    }
    if (json['password'] != null) {
      passwordFromJson = json['password'];
    }
    if (json['sex'] != null) {
      sexFromJson = json['sex'];
    }
    if (json['age'] != null) {
      ageFromJson = json['age'];
    }
    if (json['email'] != null) {
      emailFromJson = json['email'];
    }

    return User(
      name: nameFromJson,
      phone: phoneFromJson,
      password: passwordFromJson,
      sex: sexFromJson,
      age: ageFromJson,
      email: emailFromJson,
    );
  }

  Map<String, dynamic> toJson() => {
    'phone': phone,
    'password': password,
    'sex': sex,
    'name': name,
    'age': age,
    'email': email,
  };
}