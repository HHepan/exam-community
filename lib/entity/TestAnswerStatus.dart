import 'Question.dart';
import 'Test.dart';
import 'User.dart';

class TestAnswerStatus {
  final int id;
  final String adUserAnswer;
  final String correctAnswer;
  final User adUser;
  final Test test;
  final Question question;

  TestAnswerStatus({
    this.id = 0,
    this.adUserAnswer = '',
    this.correctAnswer = '',
    required this.adUser,
    required this.test,
    required this.question,
  });

  @override
  String toString() {
    return 'TestAnswerStatus{id: $id, adUserAnswer: $adUserAnswer, correctAnswer: $correctAnswer, user: $adUser, test: $test, question: $question}';
  }

  static List<TestAnswerStatus> getTestAnswerStatusListFromJson(List<Map<String, dynamic>> json) {
    List<TestAnswerStatus> testAnswerStatuses = [];
    for (var i = 0; i < json.length; i++) {
      testAnswerStatuses.add(TestAnswerStatus(
          id: json[i]['id'] ?? 0,
          adUserAnswer: json[i]['adUserAnswer'] ?? '',
          correctAnswer: json[i]['correctAnswer'] ?? '',
          adUser: User.getUserFromJson(json[i]['adUser']),
          test: Test.getOneTestFromJson(json[i]['test']),
          question: Question.getQuestionFromJson(json[i]['question'])
      ));
    }

    return testAnswerStatuses;
  }

  static TestAnswerStatus getTestAnswerStatusFromJson(Map<String, dynamic> json) {
    return TestAnswerStatus(
      id: json['id'] ?? 0,
      adUserAnswer: json['adUserAnswer'] ?? '',
      correctAnswer: json['correctAnswer'] ?? '',
      adUser: User.getUserFromJson(json['user']),
      test: Test.getOneTestFromJson(json['test']),
      question: Question.getQuestionFromJson(json['question'])
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'adUserAnswer': adUserAnswer,
    'correctAnswer': correctAnswer,
    'adUser': adUser.toJson(),
    'test': test.toJson(),
    'question': question.toJson(),
  };
}