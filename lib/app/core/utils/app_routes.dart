// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
//
// // Import your view pages
// import '../../modules/home/views/home_view.dart';
// import '../modules/home/views/home_view.dart';
// import '../modules/home/views/card_detail_view.dart';
// import '../modules/home/views/error_view.dart';
//
// // Import your bindings
// import '../modules/home/bindings/home_binding.dart';
// import '../modules/home/bindings/card_detail_binding.dart';
//
// class AppRoutes {
//   // Define route names as static constants
//   static const String HOME = '/home';
//   static const String CARD_DETAIL = '/card-detail';
//   static const String ERROR = '/error';
//
//   // Define routes list
//   static final List<GetPage> routes = [
//     GetPage(
//       name: HOME,
//       page: () => HomeView(),
//       binding: HomeBinding(),
//       transition: Transition.fadeIn,
//     ),
//     GetPage(
//       name: CARD_DETAIL,
//       page: () => CardDetailView(),
//       binding: CardDetailBinding(),
//       transition: Transition.rightToLeft,
//     ),
//     GetPage(
//       name: ERROR,
//       page: () => ErrorView(),
//       transition: Transition.zoom,
//     ),
//   ];
//
//   // Method to navigate with named routes
//   static void to(String routeName, {dynamic arguments}) {
//     Get.toNamed(routeName, arguments: arguments);
//   }
//
//   // Method to replace current route
//   static void offAndTo(String routeName, {dynamic arguments}) {
//     Get.offAndToNamed(routeName, arguments: arguments);
//   }
//
//   // Method to remove all previous routes
//   static void offAllAndTo(String routeName, {dynamic arguments}) {
//     Get.offAllNamed(routeName, arguments: arguments);
//   }
// }