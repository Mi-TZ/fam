
class FormattedTextModel {
  final String text;
  final String align;
  final List<EntityModel> entities;

  FormattedTextModel({
    required this.text,
    required this.align,
    required this.entities,
  });

  factory FormattedTextModel.fromJson(Map<String, dynamic> json) {
    return FormattedTextModel(
      text: json['text'],
      align: json['align'],
      entities: (json['entities'] as List<dynamic>)
          .map((e) => EntityModel.fromJson(e))
          .toList(),
    );
  }
}

class EntityModel {
  final String text;
  final String? color;
  final String? url;
  final String? fontStyle;

  EntityModel({
    required this.text,
    this.color,
    this.url,
    this.fontStyle,
  });

  factory EntityModel.fromJson(Map<String, dynamic> json) {
    return EntityModel(
      text: json['text'],
      color: json['color'],
      url: json['url'],
      fontStyle: json['font_style'],
    );
  }
}