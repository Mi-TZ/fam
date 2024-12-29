class GradientModel {
  final List<String> colors;
  final int? angle;

  GradientModel({
    required this.colors,
    this.angle,
  });

  factory GradientModel.fromJson(Map<String, dynamic> json) {
    return GradientModel(
      colors: (json['colors'] as List?)?.map((color) => color.toString()).toList() ?? [],
      angle: json['angle'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'colors': colors,
      'angle': angle,
    }..removeWhere((key, value) => value == null || value is List && value.isEmpty);
  }
}