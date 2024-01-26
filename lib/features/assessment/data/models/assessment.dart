import 'package:synapsis_mobile_engineer_challenge/features/assessment/domain/entities/assessment.dart';

class AssessmentModel extends AssessmentEntity {
  const AssessmentModel(
      {String? id,
      String? name,
      String? description,
      String? image,
      String? createdAt,
      String? downloadedAt})
      : super(
            id: id,
            name: name,
            description: description,
            image: image,
            createdAt: createdAt,
            downloadedAt: downloadedAt);

  factory AssessmentModel.fromJson(Map<String, dynamic> map) {
    return AssessmentModel(
        id: map['id'] ?? "",
        name: map['name'] ?? "",
        description: map['description'] ?? "",
        image: map['image'] ?? "",
        createdAt: map['created_at'] ?? "",
        downloadedAt: map['downloaded_at'] ?? "");
  }
}
