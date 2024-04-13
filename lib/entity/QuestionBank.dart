import ' Question.dart';

class QuestionBank {
  final int id;
  final String name;
  final List<Question> questions;

  QuestionBank({
    this.id = 0,
    this.name = '',
    this.questions = const [], // 初始化questions字段为空列表
  });

  @override
  String toString() {
    return 'QuestionBank{id: $id, name: $name, questions: $questions}';
  }

  static List<QuestionBank> getQuestionBankListFromJson(List<Map<String, dynamic>> json) {
    List<QuestionBank> questionBanks = [];
    for (var i = 0; i < json.length; i++) {
      int idFromJson = 0;
      String nameFromJson = '';

      if (json[i]['id'] != null) {
        idFromJson = json[i]['id'];
      }
      if (json[i]['name'] != null) {
        nameFromJson = json[i]['name'];
      }

      questionBanks.add(QuestionBank(
        id: idFromJson,
        name: nameFromJson,
      ));
    }

    return questionBanks;
  }

  static QuestionBank getOneQuestionBankFromJson(Map<String, dynamic> json) {
    int idFromJson = 0;
    String nameFromJson = '';
    List<Question> questionsFromJson = [];

    if (json['id'] != null) {
      idFromJson = json['id'];
    }
    if (json['name'] != null) {
      nameFromJson = json['name'];
    }
    if (json['questions'] != null) {
      questionsFromJson = List<Question>.from(json['questions'].map((questionJson) => Question.getQuestionFromJson(questionJson)));
    }

    return QuestionBank(
      id: idFromJson,
      name: nameFromJson,
      questions: questionsFromJson,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'questions': questions.map((question) => question.toJson()).toList(),
  };
}
