import 'package:flutter/material.dart';

import 'card_page.dart';
class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,  
        title: Center(  
          child: Image.asset(
            'assets/icons/fampaylogo.png',  
            height: 23,
            width: 86, 
          ),
        ),
        elevation: 0,  
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: CardPage(),
      ),
    );
  }
}
