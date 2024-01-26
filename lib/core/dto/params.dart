class AssessmentParams {
  final String page;
  final String limit;
  const AssessmentParams({required this.page, required this.limit});
}

class LoginParams {
  final String email;
  final String password;
  final bool isSaved;
  const LoginParams(
      {required this.email, required this.password, required this.isSaved});

  @override
  List<Object> get props => [email, password, isSaved];
}

class SubmitQuiz {
  final String assessmentId;
  final List<Answer> answers;
  const SubmitQuiz({required this.assessmentId, required this.answers});

  Map<String, dynamic> toJson() => {
        "assessment_id": assessmentId,
        "answers": List<dynamic>.from(answers.map((x) => x.toJson()))
      };

  @override
  List<Object?> get props {
    return [assessmentId, answers];
  }
}

class Answer {
  final String questionId;
  String answer;

  Answer({required this.questionId, required this.answer});

  Map<String, dynamic> toJson() =>
      {"question_id": questionId, "answer": answer};

  @override
  List<Object?> get props {
    return [questionId, answer];
  }
}
