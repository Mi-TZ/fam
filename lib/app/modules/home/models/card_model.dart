class CardModel {
  final String id;
  final String name;
  final String slug;
  final String type;

  final FormattedTextModel? formattedTitle;
  final String? title;

  final FormattedTextModel? formattedDescription;
  final String? description;

  final ImageAssetModel? bgImage;
  final GradientModel? bgGradient;
  final String? bgColor;
  final List<CardModel>? cards;

  final ImageAssetModel? icon;

  final String? url;
  final List<CTAModel>? cta;
  final bool isDisabled;
  final bool isShareable;
  final bool isInternal;

  final int? iconSize;
  final List<dynamic>? positionalImages;
  final List<dynamic>? components;

  final bool? isScrollable;
  final double? height;

  CardModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.type,
    this.formattedTitle,
    this.title,
    this.formattedDescription,
    this.description,
    this.bgImage,
    this.bgGradient,
    this.bgColor,
    this.icon,
    this.url,
    this.cta,
    required this.isDisabled,
    this.isShareable = false,
    this.isInternal = false,
    this.iconSize,
    this.positionalImages,
    this.components,
    this.isScrollable, this.height, this.cards
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      type: json['design_type'] ?? json['type'] ?? 'Unknown',

      formattedTitle: json['formatted_title'] is Map
          ? FormattedTextModel.fromJson(json['formatted_title'])
          : null,
      title: json['title'],

      formattedDescription: json['formatted_description'] is Map
          ? FormattedTextModel.fromJson(json['formatted_description'])
          : null,
      description: json['description'],

      bgImage: json['bg_image'] is Map
          ? ImageAssetModel.fromJson(json['bg_image'])
          : null,
      bgGradient: json['bg_gradient'] is Map
          ? GradientModel.fromJson(json['bg_gradient'])
          : null,
      bgColor: json['bg_color'],

      icon: json['icon'] is Map
          ? ImageAssetModel.fromJson(json['icon'])
          : null,

      url: json['url'],
      cta: json['cta'] is List
          ? (json['cta'] as List).map((ctaJson) => CTAModel.fromJson(ctaJson)).toList()
          : null,
      isDisabled: json['is_disabled'] ?? false,
      isShareable: json['is_shareable'] ?? false,
      isInternal: json['is_internal'] ?? false,

      iconSize: json['icon_size'],
      positionalImages: json['positional_images'],
      components: json['components'],
      height: json['height'],
      isScrollable: json['is_scrollable']
    );
  }
}



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

// Represents formatted text with multiple entities
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
    }..removeWhere((key, value) => value == null || value is List && value.isEmpty);
  }
}

// Represents a gradient background
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

// Represents a Call to Action (CTA) button
class CTAModel {
  final String text;
  final String? bgColor;
  final String? textColor;
  final String? url;
  final String type;
  final bool isCircular;
  final bool isSecondary;
  final int strokeWidth;

  CTAModel({
    required this.text,
    this.bgColor,
    this.textColor,
    this.url,
    this.type = 'normal',
    this.isCircular = false,
    this.isSecondary = false,
    this.strokeWidth = 0,
  });

  factory CTAModel.fromJson(Map<String, dynamic> json) {
    return CTAModel(
      text: json['text'] ?? '',
      bgColor: json['bg_color'],
      textColor: json['text_color'],
      url: json['url'],
      type: json['type'] ?? 'normal',
      isCircular: json['is_circular'] ?? false,
      isSecondary: json['is_secondary'] ?? false,
      strokeWidth: json['stroke_width'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'bg_color': bgColor,
      'text_color': textColor,
      'url': url,
      'type': type,
      'is_circular': isCircular,
      'is_secondary': isSecondary,
      'stroke_width': strokeWidth,
    }..removeWhere((key, value) => value == null);
  }
}

// Represents an image asset
class ImageAssetModel {
  final String imageType;
  final String? assetType;
  final String? imageUrl;
  final String? webpImageUrl;
  final double? aspectRatio;

  ImageAssetModel({
    required this.imageType,
    this.assetType,
    this.imageUrl,
    this.webpImageUrl,
    this.aspectRatio,
  });

  factory ImageAssetModel.fromJson(Map<String, dynamic> json) {
    return ImageAssetModel(
      imageType: json['image_type'] ?? 'ext',
      assetType: json['asset_type'],
      imageUrl: json['image_url'],
      webpImageUrl: json['webp_image_url'],
      aspectRatio: json['aspect_ratio'] is num
          ? (json['aspect_ratio'] as num).toDouble()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image_type': imageType,
      'asset_type': assetType,
      'image_url': imageUrl,
      'webp_image_url': webpImageUrl,
      'aspect_ratio': aspectRatio,
    }..removeWhere((key, value) => value == null);
  }
}

// Card Group Model to represent different design types
class CardGroupModel {
  final int id;
  final String name;
  final String? slug;
  final String designType;
  final int cardType;
  final List<CardModel> cards;
  final bool isScrollable;
  final int? height;
  final bool isFullWidth;
  final int level;

  CardGroupModel({
    required this.id,
    required this.name,
    this.slug,
    required this.designType,
    required this.cardType,
    required this.cards,
    this.isScrollable = false,
    this.height,
    this.isFullWidth = false,
    this.level = 0,
  });

  factory CardGroupModel.fromJson(Map<String, dynamic> json) {
    return CardGroupModel(
      id: json['id'],
      name: json['name'] ?? '',
      slug: json['slug'],
      designType: json['design_type'] ?? 'Unknown',
      cardType: json['card_type'] ?? 1,
      cards: json['cards'] != null
          ? (json['cards'] as List)
          .map((cardJson) => CardModel.fromJson(cardJson))
          .toList()
          : [],
      isScrollable: json['is_scrollable'] ?? false,
      height: json['height'],
      isFullWidth: json['is_full_width'] ?? false,
      level: json['level'] ?? 0,
    );
  }
}