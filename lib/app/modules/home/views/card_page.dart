import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/controllers/card_controller.dart';
import 'widgets/card_group_widget.dart';

class CardPage extends StatelessWidget {
  final CardController _cardController = Get.put(CardController());

  CardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F6F3),
      body: Obx(
        () {
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

          return RefreshIndicator(
            onRefresh: () async {
              // Trigger the API call when pulled
              await _cardController.fetchCards();
            },
            child: CardDesignFactory.createCardDesign(_cardController.cards),
          );
        },
      ),
    );
  }
}
