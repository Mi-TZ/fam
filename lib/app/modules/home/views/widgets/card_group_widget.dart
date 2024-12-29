import 'dart:developer';
import 'package:flutter/material.dart';
import '../../services/models/card_model.dart';
import 'hc1_card/hc1_card.dart';
import 'hc3_card/animated_hc3_card.dart';
import 'hc5_card/hc5_card.dart';
import 'hc6_card/hc6_card.dart';
import 'hc9_card/hc9_card.dart';

class CardDesignFactory {
  static Widget createCardDesign(List<CardModel> cards) {
    // Group cards by type
    Map<String, List<CardModel>> cardGroups = {};
    for (var card in cards) {
      if (!cardGroups.containsKey(card.type)) {
        cardGroups[card.type] = [];
      }
      cardGroups[card.type]!.add(card);
    }

    List<Widget> cardWidgets = [];
    cardGroups.forEach((type, typeCards) {
      switch (type) {
        case 'HC9':
        // If more than one HC9 card, create a horizontal scroll view
          if (typeCards.length > 1) {
            cardWidgets.add(_buildHorizontalCards(
              cards: typeCards,
              cardBuilder: (card) => HC9CardDesign(
                card: card,
              ),
              height: 195,
            ));
          } else {
            cardWidgets.add(HC9CardDesign(card: typeCards.first));
          }
          break;
        case 'HC3':
        // Check if the cards are scrollable
          if (typeCards.first.isScrollable == true && typeCards.length > 1) {
            cardWidgets.add(_buildHorizontalCards(
              cards: typeCards,
              cardBuilder: (card) => AnimatedHC3Card(card: card),
              height: 600, // Adjust height as needed
            ));
          } else {
            cardWidgets.add(AnimatedHC3Card(card: typeCards.first));
          }
          break;
        case 'HC1':
          if (typeCards.length > 1) {
            if (typeCards.first.isScrollable == false) {
              // When not scrollable and there are multiple cards, fit them in a row using Wrap
              cardWidgets.add(Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.start,
                children: typeCards.map((card) {
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      final cardWidth = (constraints.maxWidth - 16) / 2;
                      return SizedBox(
                        width: cardWidth,
                        child: HC1CardDesign(
                          card: card,
                          isInHorizontalScroll: false,
                        ),
                      );
                    },
                  );
                }).toList(),
              ));
            } else {
              // If scrollable, build a horizontal scroll view
              cardWidgets.add(_buildHorizontalCards(
                cards: typeCards,
                cardBuilder: (card) => HC1CardDesign(
                  card: card,
                  isInHorizontalScroll: true,
                ),
                height: 90,
              ));
            }
          } else {
            // Single card case
            cardWidgets.add(HC1CardDesign(
              card: typeCards.first,
              isInHorizontalScroll: false,
            ));
          }
          break;

        case 'HC5':
        // Check if the cards are scrollable
          if (typeCards.first.isScrollable == true && typeCards.length > 1) {
            cardWidgets.add(_buildHorizontalCards(
              cards: typeCards,
              cardBuilder: (card) => HC5CardDesign(card: card),
              height: 200,
            ));
          } else {
            cardWidgets.add(HC5CardDesign(card: typeCards.first));
          }
          break;
        case 'HC6':
        // Check if the cards are scrollable
          if (typeCards.first.isScrollable == true && typeCards.length > 1) {
            cardWidgets.add(_buildHorizontalCards(
              cards: typeCards,
              cardBuilder: (card) => HC6CardDesign(card: card),
              height: 200,
            ));
          } else {
            cardWidgets.add(HC6CardDesign(card: typeCards.first));
          }
          break;
        default:
          cardWidgets.add(Card(
            child: ListTile(
              title: Text('Unsupported Card Type: $type'),
            ),
          ));
      }
    });

    return ListView.separated(
      itemCount: cardWidgets.length,
      itemBuilder: (context, index) {
        return cardWidgets[index];
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 10.0);
      },
    );
  }

  // Generic method to build horizontal scrollable cards
  static Widget _buildHorizontalCards({
    required List<CardModel> cards,
    required Widget Function(CardModel) cardBuilder,
    double? height,
  }) {
    return SizedBox(
      height: height ?? 200, // Default height if not provided
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cards.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: cardBuilder(cards[index]),
          );
        },
      ),
    );
  }
}

abstract class BaseCardDesign extends StatelessWidget {
  final CardModel card;

  const BaseCardDesign({super.key, required this.card});
}