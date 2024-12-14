class CTAModel {
  final String text;
  final String? bgColor;
  final String? url;
  final String? textColor;

  CTAModel({
    required this.text,
    this.bgColor,
    this.url,
    this.textColor,
  });

  factory CTAModel.fromJson(Map<String, dynamic> json) {
    return CTAModel(
      text: json['text'] ?? '',
      bgColor: json['bg_color'] ?? '',
      url: json['url'] ?? '',
      textColor: json['text_color'] ?? '',
    );
  }
}