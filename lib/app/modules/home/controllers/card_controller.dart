import 'dart:convert';
import 'package:fam_assignment/app/core/constants/api_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/card_model.dart';

class CardController extends GetxController {
  final RxList<CardModel> cards = <CardModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  Future<void> fetchCards() async {
    isLoading.value = true;
    error.value = '';
    const apiUrl = ApiConstants.cardGroupsUrl;
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final List<CardModel> fetchedCards = [];

        for (final group in data) {
          final hcGroups = group['hc_groups'] as List<dynamic>;

          for (final hcGroup in hcGroups) {
            final String groupDesignType = hcGroup['design_type'] ?? 'Unknown';
            final List<dynamic> cardsData = hcGroup['cards'];

            fetchedCards.addAll(cardsData.map((cardJson) {
              final Map<String, dynamic> cardWithType =
                  Map<String, dynamic>.from(cardJson);
              cardWithType['design_type'] = groupDesignType;

              return CardModel.fromJson(cardWithType);
            }));
          }
        }

        cards.assignAll(fetchedCards);
        for (var card in fetchedCards) {
          if (kDebugMode) {
            print('Parsed Card: ${card.type}, Name: ${card.name}');
          }
        }
      } else {
        error.value = 'Failed to fetch cards: ${response.statusCode}';
      }
    } catch (e) {
      error.value = 'Error fetching cards: $e';
    } finally {
      isLoading.value = false;
    }
  }
}
