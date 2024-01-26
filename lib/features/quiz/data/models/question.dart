import 'package:synapsis_mobile_engineer_challenge/features/quiz/data/models/option.dart';
import 'package:synapsis_mobile_engineer_challenge/features/quiz/domain/entities/question.dart';

class QuestionModel extends QuestionEntity {
  const QuestionModel(
      {String? questionId,
      String? section,
      String? number,
      String? type,
      String? questionName,
      bool? scoring,
      List<OptionModel>? options})
      : super(
            questionId: questionId,
            section: section,
            number: number,
            type: type,
            questionName: questionName,
            scoring: scoring,
            options: options);

  factory QuestionModel.fromJson(Map<String, dynamic> map) {
    return QuestionModel(
        questionId: map['questionid'] ?? "",
        section: map['section'] ?? "",
        number: map['number'] ?? "",
        type: map['type'] ?? "",
        questionName: map['question_name'] ?? "",
        scoring: map['scoring'] ?? "",
        options: List<OptionModel>.from(
            map['options'].map((x) => OptionModel.fromJson(x))));
  }
}
