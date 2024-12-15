import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/card_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/entity_model.dart';

class AnimatedCard extends StatefulWidget {
  final CardModel card;

  const AnimatedCard({Key? key, required this.card}) : super(key: key);

  @override
  State<AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard> {
  final RxBool _isExpanded = false.obs;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: _toggleCard,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Obx(() => Row(
          children: [
            // Button Section
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              width: _isExpanded.value
                  ? MediaQuery.of(context).size.width * 0.35
                  : 0,
              child: _buildButtons(),
            ),
            // Card Content Section
            Expanded(
              child: AnimatedContainer(

                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
                child: HC3CardDesign(card: widget.card, isExpanded: _isExpanded),
              ),
            ),
          ],
        )),
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
        InkWell(
          onTap: () => log('Remind later clicked'),
          child: Container(
            height: 72,
            width: 89,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: const Color(0xffF7F6F3),
            ),
            child: Column(
              children: [
                const SizedBox(height: 5),
                Image.asset(
                  'assets/icons/bell.png',
                  height: 20,
                  width: 17,
                ),
                const SizedBox(height: 5),
                const Text(
                  'Remind later',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        InkWell(
          onTap: () => log('Dismiss now clicked'),
          child: Container(
            height: 72,
            width: 89,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: const Color(0xffF7F6F3),
            ),
            child: Column(
              children: [
                const SizedBox(height: 5),
                Image.asset(
                  'assets/icons/cross.png',
                  height: 20,
                  width: 17,
                ),
                const SizedBox(height: 5),
                const Text(
                  'Dismiss now',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class HC3CardDesign extends StatelessWidget {
  final CardModel card;
  final RxBool isExpanded;

  const HC3CardDesign({super.key, required this.card, required this.isExpanded});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          image: card.bgImage != null
              ? DecorationImage(
            image: NetworkImage(card.bgImage!.imageUrl!),
            fit: BoxFit.fill,
            onError: (error, stackTrace) {
              log('Error loading background image: $error');
            },
          )
              : null, // No background image if card.bgImage is null
          borderRadius: BorderRadius.circular(12),
        ),
      
        child: Padding(
          padding: const EdgeInsets.only(left: 32, bottom: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 170),
              if (card.formattedTitle != null &&
                  card.formattedTitle!.entities.isNotEmpty) ...[
                _buildFormattedText(
                  card.formattedTitle!.entities[0],
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'met_semi_bold',
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.001),
                Text(
                  card.formattedTitle!.text.replaceAll(RegExp(r'[{}\n]'), ''),
                  style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'met_semi_bold',
                      color: Colors.white),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                if (card.formattedTitle!.entities.length > 1)
                  _buildFormattedText(
                    card.formattedTitle!.entities[1],
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'met_regular',
                  ),
              ],
              SizedBox(height: MediaQuery.of(context).size.height * 0.06),
              if (card.cta != null && card.cta!.isNotEmpty && !isExpanded.value)
                ElevatedButton(
                  onPressed: () async {
                    final Uri url = Uri.parse(card.url!);
      
                    if (!await launchUrl(url)) {
                      throw Exception('Could not launch $url');
                    }
      
                    log('HC3 Card CTA: ${card.cta!.first.text}');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    minimumSize: const Size(128, 42),
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

