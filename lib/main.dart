
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/modules/home/views/home_view.dart';


// Main App
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return GetMaterialApp(
      color: const Color(0xffF7F6F3),
      title: 'FamPay',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CardPage(),
    );
  }
}

