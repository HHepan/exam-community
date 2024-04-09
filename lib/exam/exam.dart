import 'package:flutter/material.dart';

class Exam extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: GridView.count(
        crossAxisCount: 1,
        padding: EdgeInsets.all(1.0),
        childAspectRatio: 2.0 / 4.0,
        children: <Widget>[
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 1.0 / 1.0,
                  child: Image.asset('images/OIP.png'),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('我的考试'),
                    style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(Size(275, 100)),
                      alignment: Alignment.center,
                      elevation: MaterialStateProperty.all(4.0),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        )
                      )
                    ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('随机考试'),
                    style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(Size(275, 100)),
                      alignment: Alignment.center,
                      elevation: MaterialStateProperty.all(4.0),
                      shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          )
                      )
                  ),
                )
              ],
            )
          ),
        ],
      ),
    );
  }
}