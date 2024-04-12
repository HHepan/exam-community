import 'package:flutter/material.dart';

import '../entity/User.dart';
import '../global-config.dart';
import '../services/user-service.dart';

class EditPersonal extends StatefulWidget {
  final Function personalSetState;

  EditPersonal({required this.personalSetState});

  @override
  _EditPersonalState createState() => _EditPersonalState();
}

class _EditPersonalState extends State<EditPersonal> {
  final UserService _userService = UserService(); // 创建 UserService 实例
  TextEditingController _nameEditController = TextEditingController();
  TextEditingController _sexEditController = TextEditingController();
  TextEditingController _ageEditController = TextEditingController();
  TextEditingController _phoneEditController = TextEditingController();
  TextEditingController _emailEditController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // 在这里设置已有的数据到文本编辑器中
    _nameEditController.text = globalConfig().currentUser!.name;
    _sexEditController.text = globalConfig().currentUser!.sex;
    _ageEditController.text = globalConfig().currentUser!.age;
    _phoneEditController.text = globalConfig().currentUser!.phone;
    _emailEditController.text = globalConfig().currentUser!.email;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('编辑个人信息'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _nameEditController,
              decoration: InputDecoration(
                labelText: '昵称',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _sexEditController,
              decoration: InputDecoration(
                labelText: '性别',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _ageEditController,
              decoration: InputDecoration(
                labelText: '年龄',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _phoneEditController,
              decoration: InputDecoration(
                labelText: '手机号',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _emailEditController,
              decoration: InputDecoration(
                labelText: '邮箱',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 360, // 设置父容器的宽度
                child: ElevatedButton(
                  onPressed: () async {
                    User updateUser = User(
                      id: globalConfig().currentUser!.id,
                      name: _nameEditController.text,
                      sex: _sexEditController.text,
                      age: _ageEditController.text,
                      phone: _phoneEditController.text,
                      email: _emailEditController.text,
                      password: globalConfig().currentUser!.password,
                    );
                    User updateSuccessUser = await _userService.update(updateUser);
                    if (updateSuccessUser.phone != '') {
                      globalConfig().updateConfig(currentUser: updateSuccessUser);
                      widget.personalSetState();
                      Navigator.pop(context);
                    }
                  },
                  child: Text('保存信息'),
                ),
              )
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {

        },
        label: Text('修改密码', style: TextStyle(fontSize: 15)),
        icon: Icon(Icons.edit),
      ),
    );
  }
}
