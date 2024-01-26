import 'package:equatable/equatable.dart';

class OptionEntity extends Equatable {
  final String? optionId;
  final String? optionName;
  final int? points;
  final int? flag;

  const OptionEntity({this.optionId, this.optionName, this.points, this.flag});

  @override
  List<Object?> get props {
    return [optionId, optionName, points, flag];
  }
}
