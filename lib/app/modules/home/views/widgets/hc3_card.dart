import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/card_model.dart';

class AnimatedCard extends StatefulWidget {
  final CardModel card;

  const AnimatedCard({Key? key, required this.card}) : super(key: key);

  @override
  State<AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard> {
  final _isExpanded = false.obs;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: _toggleCard,
      child: Container(
        height: widget.card.height,
        decoration: BoxDecoration(
          color: Colors.white, // Grey background
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(8), // Optional margin for spacing
        child: Row(
          children: [
            // Button Section
            Obx(() => AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                  width: _isExpanded.value ? 150 : 0, // Button container width
                  height: 270,
                  child: _buildButtons(),
                )),
            // Card Content Section
            Expanded(
              child: Obx(() => AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                    width: _isExpanded.value
                        ? MediaQuery.of(context).size.width - 80
                        : MediaQuery.of(context).size.width,
                    height: 270,
                    child: HC3CardDesign(card: widget.card),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleCard() {
    _isExpanded.value = !_isExpanded.value;
  }

  Widget _buildButtons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Edit button
        InkWell(
          onTap: () {
            log('Delete button clicked');
          },
          child: Container(
            height: 72,
            width: 59,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Color(0xffF7F6F3), // Background color of the button
            ),
            child: Column(
              children: [
                Image.asset('assets/icons/bell.png', height: 20.24, width: 17.51,),
                const Text(
                  'remind later',
                  style: TextStyle(color: Color(0xff000000), fontSize: 8),
                ),

              ],
            ),
          ),
        ),
        const SizedBox(height: 20), // Space between buttons
        // Delete button
        InkWell(
          onTap: () {
            log('Delete button clicked');
          },
          child: Container(
            height: 72,
            width: 59,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Color(0xffF7F6F3), // Background color of the button
            ),
            child: Column(
              children: [
                Image.asset('assets/icons/cross.png', height: 20.24, width: 17.51,),
                const Text(
                  'dismiss now',
                  style: TextStyle(color: Color(0xff000000), fontSize: 8),
                ),

              ],
            ),
          ),
        )
      ],
    );
  }
}

class HC3CardDesign extends StatelessWidget {
  final CardModel card;

  const HC3CardDesign({Key? key, required this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: card.height,
      child: Container(
        decoration: BoxDecoration(
          color: card.bgImage == null
              ? Colors.transparent
              : const Color(0xff454AA6),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            // Card Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Background Image
                  if (card.bgImage != null)
                    Image.network(
                      card.bgImage!.imageUrl!,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.network(
                          'https://github.com/Mi-TZ/fam/blob/main/famfallback.png?raw=true',
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        );
                      },
                    ),

                  // Title from Entities
                  if (card.formattedTitle != null &&
                      card.formattedTitle!.entities.isNotEmpty)
                    _buildFormattedText(
                      card.formattedTitle!.entities[0],
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'met_semi_bold',
                    ),

                  const SizedBox(height: 8),

                  // Description from Entities
                  if (card.formattedTitle != null &&
                      card.formattedTitle!.entities.length > 1)
                    _buildFormattedText(
                      card.formattedTitle!.entities[1],
                      fontSize: 16,
                      fontFamily: 'met_regular',
                    ),

                  const SizedBox(height: 8),

                  // CTA Button
                  if (card.cta != null && card.cta!.isNotEmpty)
                    ElevatedButton(
                      onPressed: () {
                        // Implement CTA action
                        log('HC3 Card CTA: ${card.cta!.first.text}');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      child: Text(
                        card.cta!.first.text,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
