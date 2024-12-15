import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';
import '../../models/card_model.dart';
import '../../models/entity_model.dart';

class HC6CardDesign extends StatelessWidget {
  final CardModel card;
  final bool isScrollable;

  const HC6CardDesign({
    super.key,
    required this.card,
    this.isScrollable = false,
  });

  @override
  Widget build(BuildContext context) {
    log(card.toString());
    return isScrollable
        ? SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [_buildCard(context, card)],
            ),
          )
        : Column(
            children: [_buildCard(context, card)],
          );
  }

  Widget _buildCard(BuildContext context, CardModel card) {
    return InkWell(
      onTap: () async {
        final Uri url = Uri.parse(card.url!);
        if (!await launchUrl(url)) {
          throw Exception('Could not launch $url');
        } else {
          if (kDebugMode) {
            print("No URL provided");
          }
        }
      },
      child: Card(
        elevation: 0,
        color: Color(int.parse(card.bgColor!.replaceFirst('#', '0xFF'))),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          decoration: _buildBackgroundDecoration(card),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Leading Icon
              card.bgImage != null
                  ? Image.network(
                      card.bgImage!.imageUrl!,
                      width: 30,
                      height: 30,
                    )
                  : Image.asset(
                      'assets/icons/hc6fallback.png',
                      height: 30,
                      width: 30,
                    ),

              if (card.formattedTitle != null &&
                  card.formattedTitle!.entities.isNotEmpty)
                _buildFormattedText(
                  card.formattedTitle!.entities[0],
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'met_semi_bold',
                ),

              const SizedBox(
                width: 100,
              ),
              const Icon(Icons.arrow_forward_ios, size: 22),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration? _buildBackgroundDecoration(CardModel card) {
    if (card.bgGradient != null) {
      return BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: List<Color>.from(
            card.bgGradient!.colors.map(
              (color) => Color(int.parse(color.replaceFirst('#', '0xFF'))),
            ),
          ),
        ),
      );
    } else if (card.bgImage != null) {
      return BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(card.bgImage!.imageUrl ?? ''),
          fit: BoxFit.cover,
        ),
      );
    }
    return null;
  }

  Widget _buildFormattedText(EntityModel entity,
      {double? fontSize, FontWeight? fontWeight, String? fontFamily}) {
    return Text(
      entity.text,
      style: TextStyle(
        color: entity.color != null
            ? Color(int.parse(entity.color!.replaceFirst('#', '0xFF')))
            : null,
        fontStyle:
            entity.fontStyle == 'italic' ? FontStyle.italic : FontStyle.normal,
        fontWeight: fontWeight ?? FontWeight.normal,
        fontSize: fontSize ?? entity.fontSize,
        fontFamily: fontFamily ?? entity.fontFamily,
      ),
    );
  }
}
