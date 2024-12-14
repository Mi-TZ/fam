import 'package:flutter/material.dart';
import '../../../../core/utils/text_utils.dart';
import '../../models/card_model.dart';

class HC5CardDesign extends StatelessWidget {
  final CardModel card;

  const HC5CardDesign({Key? key, required this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Stack( // Use a Stack to overlay image and text
        children: [
          Container(
            width: double.infinity, // Full width
            child: card.bgImage != null
                ? Image.network(
              card.bgImage!.imageUrl!,
              fit: BoxFit.cover,
              alignment: Alignment.center,
              errorBuilder: (context, error, stackTrace) {
                // Fallback to asset image when an error occurs
                return Image.asset(
                  'assets/icons/hc5fallback.png',
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                );
              },
            )
                : Image.asset(
              'assets/icons/hc5fallback.png',
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column( // Wrap text elements in a Column
                crossAxisAlignment: CrossAxisAlignment.start, // Align left
                mainAxisSize: MainAxisSize.min, // Avoid unnecessary space
                children: [
                  if (card.title != null) // Check if title exists
                    Text(
                      card.title!,
                      style: const TextStyle( // Adjust styles as needed
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  if (card.description != null) // Check if description exists
                    Text(
                      card.description!,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey,
                      ),
                    ),
                  if (card.cta != null && card.cta!.isNotEmpty)
                    ElevatedButton(
                      onPressed: () {
                        // Implement CTA action
                        print('HC5 Card CTA: ${card.cta!.first.text}');
                      },
                      child: Text(card.cta!.first.text),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}