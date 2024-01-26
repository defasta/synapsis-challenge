import 'package:equatable/equatable.dart';

class AssessmentEntity extends Equatable {
  final String? id;
  final String? name;
  final String? description;
  final String? image;
  final String? createdAt;
  final String? downloadedAt;

  const AssessmentEntity(
      {this.id,
      this.name,
      this.description,
      this.image,
      this.createdAt,
      this.downloadedAt});

  @override
  List<Object?> get props {
    return [id, name, description, image, createdAt, downloadedAt];
  }
}
