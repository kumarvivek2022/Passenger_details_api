import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/model.dart';
int currentPage = 1;


Future<PassengerDetails> fetchPassengerDetails(String size) async {
  final response = await http
      .get(Uri.parse('https://api.instantwebtools.net/v1/passenger?page=$currentPage&size=$size'));
   if (kDebugMode) {
     print(response.statusCode.toString());
   }
  if (response.statusCode == 200) {
     return PassengerDetails.fromJson(jsonDecode(response.body));
     currentPage++;
  } else {
    throw Exception('Failed to load album');
  }
}