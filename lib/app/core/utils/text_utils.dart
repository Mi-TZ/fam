import 'package:flutter/material.dart';

import '../../modules/home/models/formatted_text_model.dart';
import 'color_utils.dart';

class TextUtils {
  static Widget formattedText(FormattedTextModel formattedText) {
    return Text.rich(
      TextSpan(
        children: formattedText.entities.map((entity) {
          return TextSpan(
            text: entity.text,
            style: TextStyle(
              color: entity.color != null ? ColorUtils.fromHex(entity.color!) : null,
              decoration: entity.fontStyle?.contains('underline') ?? false
                  ? TextDecoration.underline
                  : TextDecoration.none,
              fontStyle: entity.fontStyle?.contains('italic') ?? false
                  ? FontStyle.italic
                  : FontStyle.normal,
            ),
          );
        }).toList(),
      ),
      textAlign: TextAlign.start,
    );
  }
}