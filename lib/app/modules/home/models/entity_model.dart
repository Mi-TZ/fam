
// Represents a single text entity with styling and optional interactions
class EntityModel {
  final String text;
  final String? color;
  final String? url;
  final String? fontStyle;
  final String? fontFamily;
  final double? fontSize;

  EntityModel({
    required this.text,
    this.color,
    this.url,
    this.fontStyle,
    this.fontFamily,
    this.fontSize,
  });

  factory EntityModel.fromJson(Map<String, dynamic> json) {
    return EntityModel(
      text: json['text'] ?? '',
      color: json['color'],
      url: json['url'],
      fontStyle: json['font_style'],
      fontFamily: json['font_family'],
      fontSize: json['font_size'] is num
          ? (json['font_size'] as num).toDouble()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'color': color,
      'url': url,
      'font_style': fontStyle,
      'font_family': fontFamily,
      'font_size': fontSize,
    }..removeWhere((key, value) => value == null);
  }
}