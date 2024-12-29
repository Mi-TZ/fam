// Represents formatted text with multiple entities
import 'entity_model.dart';

class FormattedTextModel {
  final String text;
  final String? align;
  final List<EntityModel> entities;

  FormattedTextModel({
    required this.text,
    this.align,
    required this.entities,
  });

  factory FormattedTextModel.fromJson(Map<String, dynamic> json) {
    return FormattedTextModel(
      text: json['text'] ?? '',
      align: json['align'],
      entities: json['entities'] != null
          ? (json['entities'] as List)
              .map((entity) => EntityModel.fromJson(entity))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'align': align,
      'entities': entities.map((entity) => entity.toJson()).toList(),
    }..removeWhere(
        (key, value) => value == null || value is List && value.isEmpty);
  }
}
