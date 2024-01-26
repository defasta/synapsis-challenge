import 'package:synapsis_mobile_engineer_challenge/features/quiz/domain/entities/option.dart';

class OptionModel extends OptionEntity {
  const OptionModel(
      {String? optionId, String? optionName, int? points, int? flag})
      : super(
            optionId: optionId,
            optionName: optionName,
            points: points,
            flag: flag);

  factory OptionModel.fromJson(Map<String, dynamic> map) {
    return OptionModel(
        optionId: map['optionid'] ?? "",
        optionName: map['option_name'] ?? "",
        points: map['points'] ?? "",
        flag: map['flag'] ?? "");
  }
}
