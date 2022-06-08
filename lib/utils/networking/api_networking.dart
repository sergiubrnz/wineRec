import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wine_rec/utils/Models/wineApiModel.dart';

class ApiService {
  var client = http.Client();

  Future<ExploreVintage> getWines() async {
    var response = await client.get(
      Uri.parse('https://mocki.io/v1/8404b7e7-5147-4646-98ed-017ad785c1c8'),
    );

    if (response.statusCode == 200) {
      return ExploreVintage.fromJson(jsonDecode(response.body));
    }
    throw Exception('${response.statusCode.toString()}');
  }
}
