import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wine_rec/utils/Models/wineApiModel.dart';

class ApiService {
  var client = http.Client();

  Future<ExploreVintage> getWines(String searchType, var searchParams) async {
    // var response = await client.get(
    //   Uri.parse('https://mocki.io/v1/8404b7e7-5147-4646-98ed-017ad785c1c8'),
    // );
    String url =
        'https://www.vivino.com/api/explore/explore?country_codes[]=ro&page=1&price_range_max=50&order_by=ratings_average&grape_filter=any&currency_code=USD&per_page=50&country_codes[]=md';

    if (searchType == 'color') {
      url =
          'https://www.vivino.com/api/explore/explore?country_codes[]=ro&page=1&price_range_max=50&wine_type_ids[]=$searchParams&order_by=ratings_average&grape_filter=any&currency_code=USD&per_page=50&country_codes[]=md';
    } else if (searchType == 'year') {
      url =
          'https://www.vivino.com/api/explore/explore?country_codes[]=ro&page=1&price_range_max=50&order_by=ratings_average&grape_filter=any&currency_code=USD&per_page=50&wine_years[]=$searchParams&country_codes[]=md';
    } else if (searchType == 'food') {
      url =
          'https://www.vivino.com/api/explore/explore?country_codes[]=ro&page=1&price_range_max=50&order_by=ratings_average&grape_filter=any&currency_code=USD&per_page=50&food_ids[]=$searchParams&country_codes[]=md';
    } else if (searchType == 'sort') {
      if (searchParams.runtimeType == String) {
        url =
            'https://www.vivino.com/api/explore/explore?country_codes[]=ro&page=1&price_range_max=50&order_by=ratings_average&grape_filter=any&currency_code=USD&per_page=50&grape_ids[]=$searchParams&country_codes[]=md';
      } else {
        url =
            'https://www.vivino.com/api/explore/explore?country_codes[]=ro&page=1&price_range_max=50&order_by=ratings_average&grape_filter=any&currency_code=USD&per_page=50&country_codes[]=md';
        for (var i = 0; i < searchParams.length; i++) {
          url += '&grape_ids[]=${searchParams[i].toString()}';
        }
      }
    }

    var response = await client.get(Uri.parse(url), headers: {
      "Content-type": "application/json",
      "Accept": "application/json",
      "User-Agent":
          "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:66.0) Gecko/20100101 Firefox/66.0",
    });

    if (response.statusCode == 200) {
      return ExploreVintage.fromJson(jsonDecode(response.body));
    }
    throw Exception('${response.statusCode.toString()}');
  }
}
