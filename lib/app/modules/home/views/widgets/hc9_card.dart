import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../../models/card_model.dart';

class HC9CardDesign extends StatelessWidget {
  final CardModel cardGroup;

  const HC9CardDesign({Key? key, required this.cardGroup}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 300,
      child: _buildCard(context, cardGroup),
    );
  }

  Widget _buildCard(BuildContext context, CardModel card) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate height based on width and aspect ratio
        double height =
            constraints.maxWidth / (card.bgImage?.aspectRatio ?? 2.0);

        return Card(
          margin: const EdgeInsets.all(8),
          child: Container(
            // width: constraints.maxWidth,
            height: height,
            decoration: _buildDecoration(card),
            child: const Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Text(''),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget? _buildCTAButton(CardModel card) {
    if (card.cta != null && card.cta!.isNotEmpty) {
      final firstCTA = card.cta!.first;
      return ElevatedButton(
        onPressed: () {
          if (kDebugMode) {
            print('HC9 Card CTA: ${firstCTA.text}');
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: firstCTA.bgColor != null
              ? Color(int.parse(firstCTA.bgColor!.replaceFirst('#', '0xFF')))
              : null,
          foregroundColor: firstCTA.textColor != null
              ? Color(int.parse(firstCTA.textColor!.replaceFirst('#', '0xFF')))
              : null,
        ),
        child: Text(firstCTA.text),
      );
    }
    return null;
  }

  BoxDecoration? _buildDecoration(CardModel card) {
    // Prioritize gradient over background image
    if (card.bgGradient != null) {
      return BoxDecoration(
        borderRadius: BorderRadius.circular(11),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: card.bgGradient!.colors.map((color) {
            // Handle potential color parsing issues
            try {
              return Color(int.parse(color.replaceFirst('#', '0xFF')));
            } catch (e) {
              // Fallback to a default color if parsing fails
              return Colors.grey;
            }
          }).toList(),
        ),
      );
    }

    // Fallback to background image if no gradient
    if (card.bgImage?.imageUrl != null) {
      return BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(card.bgImage?.imageUrl ?? ''),
          fit: BoxFit.cover,
          onError: (exception, stackTrace) {
            if (kDebugMode) {
              print('Image load error: $exception');
            }
          },
        ),
      );
    }

    // Fallback to background color if provided
    if (card.bgColor != null) {
      return BoxDecoration(
        color: Color(int.parse(card.bgColor!.replaceFirst('#', '0xFF'))),
      );
    }

    // Return null if no decoration is needed
    return null;
  }
}
