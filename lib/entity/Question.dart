// 题目数据模型
class Question {
  final int id;
  final String stem;
  final String options;
  final String answer;

  Question({
    this.id = 0,
    this.stem = '',
    this.options = '',
    this.answer = '',
  });

  @override
  String toString() {
    return 'Question{id: $id, stem: $stem, options: $options, answer: $answer}';
  }

  static Question getQuestionFromJson(Map<String, dynamic> json) {
    int idFromJson = 0;
    String stemFromJson = '';
    String optionsFromJson = '';
    String answerFromJson = '';

    if (json['id'] != null) {
      idFromJson = json['id'];
    }
    if (json['stem'] != null) {
      stemFromJson = json['stem'];
    }
    if (json['options'] != null) {
      optionsFromJson = json['options'];
    }
    if (json['answer'] != null) {
      answerFromJson = json['answer'];
    }

    return Question(
      id: idFromJson,
      stem: stemFromJson,
      options: optionsFromJson,
      answer: answerFromJson,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'stem': stem,
    'options': options,
    'answer': answer,
  };
}