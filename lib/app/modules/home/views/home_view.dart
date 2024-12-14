import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/card_controller.dart';
import '../models/card_model.dart';
import 'widgets/card_group_widget.dart';

class CardPage extends StatelessWidget {
  final CardController _cardController = Get.put(CardController());

  @override
  Widget build(BuildContext context) {
    // Fetch cards when the page is first built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cardController.fetchCards();
    });

    return Scaffold(
      backgroundColor: const Color(0xffF7F6F3),
      appBar: AppBar(
        title: const Text('FamPay'),
        centerTitle: true,
      ),
      body: Obx(() {
        // Loading state
        if (_cardController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // Error state
        if (_cardController.error.value.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error: ${_cardController.error.value}'),
                ElevatedButton(
                  onPressed: _cardController.fetchCards,
                  child: const Text('Retry'),
                )
              ],
            ),
          );
        }

        // No cards state
        if (_cardController.cards.isEmpty) {
          return const Center(
            child: Text('No cards available'),
          );
        }

        // Use the updated CardDesignFactory to create card designs
        return CardDesignFactory.createCardDesign(_cardController.cards);
      }),
    );
  }
}