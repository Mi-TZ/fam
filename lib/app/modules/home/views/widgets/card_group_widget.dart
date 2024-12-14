import 'dart:developer';
import 'package:flutter/material.dart';
import '../../models/card_model.dart';
import 'hc1_card.dart';
import 'hc3_card.dart';
import 'hc5_card.dart';
import 'hc6_card.dart';
import 'hc9_card.dart';

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
              cardBuilder: (card) => HC9CardDesign(cardGroup: card),
              height: 200,
            ));
          } else {
            cardWidgets.add(HC9CardDesign(cardGroup: typeCards.first));
          }
          break;
        case 'HC3':
          // Check if the cards are scrollable
          if (typeCards.first.isScrollable == true && typeCards.length > 1) {
            cardWidgets.add(_buildHorizontalCards(
              cards: typeCards,
              cardBuilder: (card) => AnimatedCard(card: card),
              height: 250, // Adjust height as needed
            ));
          } else {
            cardWidgets.add(AnimatedCard(card: typeCards.first));
          }
          break;
        case 'HC1':
        // Check if there are multiple H C1 cards
          if (typeCards.length > 1) {
            cardWidgets.add(_buildHorizontalCards(
              cards: typeCards,
              cardBuilder: (card) => HC1CardDesign(
                card: card,
                isInHorizontalScroll: true,
              ),
              height: 100, // Adjust height as needed
            ));
          } else {
            cardWidgets.add(HC1CardDesign(card: typeCards.first));
          }
          break;

        case 'HC5':
          // Check if the cards are scrollable
          if (typeCards.first.isScrollable == true && typeCards.length > 1) {
            cardWidgets.add(_buildHorizontalCards(
              cards: typeCards,
              cardBuilder: (card) => HC5CardDesign(card: card),
              height: 200, // Adjust height as needed
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
              height: 200, // Adjust height as needed
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

    return ListView(
      children: cardWidgets,
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

  const BaseCardDesign({Key? key, required this.card}) : super(key: key);
}
