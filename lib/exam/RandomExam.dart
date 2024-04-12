import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RandomExam extends StatelessWidget{
  const RandomExam({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('随机考试'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: (){},
          child: Text('返回'),
        ),
      ),
    );
  }
}