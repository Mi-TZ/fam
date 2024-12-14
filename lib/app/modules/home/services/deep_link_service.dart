import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DeepLinkService {
  static Future<void> handleDeepLink(String? url) async {
    if (url == null || url.isEmpty) return;

    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        // Custom handling for specific deep link schemes
        if (url.startsWith('fp://')) {
          _handleFamPayDeepLink(url);
        } else {
          _showErrorDialog('Cannot handle this deep link');
        }
      }
    } catch (e) {
      _showErrorDialog('Error launching deep link: $e');
    }
  }

  static void _handleFamPayDeepLink(String url) {
    // Add specific handling for FamPay deep links
    switch (url) {
      case 'fp://fampay.in/pay/':
      // Navigate to specific screen or perform action
        print('Navigating to Pay Screen');
        break;
      default:
        _showErrorDialog('Unhandled FamPay deep link');
    }
  }

  static void _showErrorDialog(String message) {
    // Implement a generic error dialog
    print(message);
  }
}