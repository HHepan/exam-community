import 'Question.dart';

class Test {
  final int id;
  final String name;
  final String questionNum;
  final String startTime;
  final String endTime;
  final List<Question> questions;

  Test({
    this.id = 0,
    this.name = '',
    this.questionNum = '',
    this.startTime = '',
    this.endTime = '',
    this.questions = const [], // 初始化questions字段为空列表
  });

  @override
  String toString() {
    return 'Test{id: $id, name: $name, questionsNum: $questionNum, startTime: $startTime, endTime: $endTime, questions: $questions}';
  }

  static List<Test> getTestListFromJson(List<Map<String, dynamic>> json) {
    List<Test> tests = [];
    for (var i = 0; i < json.length; i++) {
      int idFromJson = 0;
      String nameFromJson = '';
      String questionsNumFromJson = '';
      String startTimeFromJson = '';
      String endTimeFromJson = '';

      if (json[i]['id'] != null) {
        idFromJson = json[i]['id'];
      }
      if (json[i]['name'] != null) {
        nameFromJson = json[i]['name'];
      }
      if (json[i]['questionsNum'] != null) {
        questionsNumFromJson = json[i]['questionsNum'];
      }
      if (json[i]['startTime'] != null) {
        startTimeFromJson = json[i]['startTime'];
      }
      if (json[i]['endTime'] != null) {
        endTimeFromJson = json[i]['endTime'];
      }

      tests.add(Test(
        id: idFromJson,
        name: nameFromJson,
        questionNum: questionsNumFromJson,
        startTime: startTimeFromJson,
        endTime: endTimeFromJson,
      ));
    }

    return tests;
  }

  static Test getOneTestFromJson(Map<String, dynamic> json) {
    int idFromJson = 0;
    String nameFromJson = '';
    String questionNumFromJson = '';
    String startTimeFromJson = '';
    String endTimeFromJson = '';
    List<Question> questionsFromJson = [];

    if (json['id'] != null) {
      idFromJson = json['id'];
    }
    if (json['name'] != null) {
      nameFromJson = json['name'];
    }
    if (json['questionNum'] != null) {
      questionNumFromJson = json['questionNum'];
    }
    if (json['startTime'] != null) {
      startTimeFromJson = json['startTime'];
    }
    if (json['endTime'] != null) {
      endTimeFromJson = json['endTime'];
    }
    if (json['questions'] != null) {
      questionsFromJson = List<Question>.from(json['questions'].map((questionJson) => Question.getQuestionFromJson(questionJson)));
    }

    return Test(
      id: idFromJson,
      name: nameFromJson,
      questionNum: questionNumFromJson,
      startTime: startTimeFromJson,
      endTime: endTimeFromJson,
      questions: questionsFromJson,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'questionNum': questionNum,
    'startTime': startTime,
    'endTime': endTime,
    'questions': questions.map((question) => question.toJson()).toList(),
  };
}
