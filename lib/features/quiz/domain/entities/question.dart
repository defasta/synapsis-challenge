import 'package:equatable/equatable.dart';
import 'package:synapsis_mobile_engineer_challenge/features/quiz/domain/entities/option.dart';

class QuestionEntity extends Equatable {
  final String? questionId;
  final String? section;
  final String? number;
  final String? type;
  final String? questionName;
  final bool? scoring;
  final List<OptionEntity>? options;

  const QuestionEntity(
      {this.questionId,
      this.section,
      this.number,
      this.type,
      this.questionName,
      this.scoring,
      this.options});

  @override
  List<Object?> get props {
    return [questionId, section, number, type, questionName, scoring, options];
  }
}
