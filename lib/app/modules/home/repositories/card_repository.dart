// import 'dart:convert';
// import 'dart:developer';
//
// import 'package:http/http.dart' as http;
// import '../../../core/constants/api_constants.dart';
// import '../models/card_group_model.dart';
// import '../models/card_model.dart';
//
// class CardRepository {
//   Future<List<CardGroupModel>> getCardGroups() async {
//     try {
//       final response = await http.get(Uri.parse(ApiConstants.cardGroupsUrl));
//
//       if (response.statusCode == 200) {
//         final List<dynamic> responseData = jsonDecode(response.body);
//
//         log("Fetched card groups successfully: $responseData");
//         return responseData.map((e) => CardGroupModel.fromJson(e)).toList();
//       } else {
//         log("Failed to fetch card groups: ${response.statusCode}");
//         throw Exception('Failed to load card groups');
//       }
//     } catch (e) {
//       log("Error fetching card groups: $e");
//       rethrow;
//     }
//   }
// }