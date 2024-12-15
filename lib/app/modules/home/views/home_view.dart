import 'package:flutter/material.dart';

import 'card_page.dart';
class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,  // Set your AppBar color here
        title: Center(  // Center the image in the AppBar
          child: Image.asset(
            'assets/icons/fampaylogo.png',  // Replace with the correct path to your image
            height: 23,
            width: 86,  // Set the height as needed
          ),
        ),
        elevation: 0,  // Optional: removes the shadow
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: CardPage(),
      ),
    );
  }
}
