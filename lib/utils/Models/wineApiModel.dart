import 'dart:convert';

class ExploreVintage {
  ExploreVintage({
    required this.matches,
  });

  List<Match> matches;

  factory ExploreVintage.fromJson(Map<String, dynamic> json) => ExploreVintage(
        matches: List<Match>.from(
            json["explore_vintage"]["matches"].map((x) => Match.fromJson(x))),
      );

  Map<String, dynamic> toJson() {
    return {
      'matches': jsonEncode(matches.map((e) => e.toJson()).toList()),
    };
  }
}

class Match {
  Match({
    required this.vintage,
    required this.price,
  });

  Vintage vintage;
  Price price;

  factory Match.fromJson(Map<String, dynamic> json) => Match(
        vintage: Vintage.fromJson(json["vintage"]),
        price: Price.fromJson(json["price"]),
      );

  Map<String, dynamic> toJson() {
    return {
      'vintage': vintage.toJson(),
      'price': price.toJson(),
    };
  }
}

class Price {
  Price({
    required this.id,
    required this.amount,
    required this.discountedFrom,
    required this.discountPercent,
    required this.type,
    required this.sku,
    required this.url,
    required this.visibility,
    required this.bottleTypeId,
    required this.currency,
    required this.bottleType,
  });

  int id;
  double amount;
  dynamic discountedFrom;
  dynamic discountPercent;
  String type;
  String sku;
  String url;
  int visibility;
  int bottleTypeId;
  Currency currency;
  BottleType bottleType;

  Map<String, dynamic> toJson() {
    return {
      'currency': currency.toJson(),
      'amount': amount,
      'url': url,
    };
  }

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        id: json["id"],
        amount: json["amount"].toDouble(),
        discountedFrom: json["discounted_from"],
        discountPercent: json["discount_percent"],
        type: json["type"],
        sku: json["sku"],
        url: json["url"],
        visibility: json["visibility"],
        bottleTypeId: json["bottle_type_id"],
        currency: Currency.fromJson(json["currency"]),
        bottleType: BottleType.fromJson(json["bottle_type"]),
      );
}

class BottleType {
  BottleType({
    required this.id,
    required this.name,
    required this.shortName,
    required this.shortNamePlural,
    required this.volumeMl,
  });

  int id;
  String name;
  String shortName;
  String shortNamePlural;
  int volumeMl;

  factory BottleType.fromJson(Map<String, dynamic> json) => BottleType(
        id: json["id"],
        name: json["name"],
        shortName: json["short_name"],
        shortNamePlural: json["short_name_plural"],
        volumeMl: json["volume_ml"],
      );
}

class Currency {
  Currency({
    required this.code,
    required this.name,
    required this.prefix,
    required this.suffix,
  });

  String code;
  String name;
  String prefix;
  dynamic suffix;

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
    };
  }

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        code: json["code"],
        name: json["name"],
        prefix: json["prefix"],
        suffix: json["suffix"],
      );
}

class Vintage {
  Vintage({
    required this.id,
    required this.seoName,
    required this.name,
    required this.statistics,
    required this.image,
    required this.wine,
    required this.year,
    required this.grapes,
    required this.hasValidRatings,
  });

  int id;
  String seoName;
  String name;
  Statistics statistics;
  ApiImage image;
  Wine wine;
  String year;
  dynamic grapes;
  bool hasValidRatings;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'statistics': statistics.toJson(),
      'image': image.toJson(),
      'wine': wine.toJson(),
      'year': year,
      'grapes': grapes,
    };
  }

  factory Vintage.fromJson(Map<String, dynamic> json) => Vintage(
        id: json["id"],
        seoName: json["seo_name"],
        name: json["name"],
        statistics: Statistics.fromJson(json["statistics"]),
        image: ApiImage.fromJson(json["image"]),
        wine: Wine.fromJson(json["wine"]),
        year: json["year"].toString(),
        grapes: json["grapes"],
        hasValidRatings: json["has_valid_ratings"],
      );
}

class ApiImage {
  ApiImage({
    required this.location,
    required this.variations,
  });

  String location;
  ImageVariations variations;

  Map<String, dynamic> toJson() {
    return {
      'location': location,
      'variations': variations.toJson(),
    };
  }

  factory ApiImage.fromJson(Map<String, dynamic> json) => ApiImage(
        location: json["location"],
        variations: ImageVariations.fromJson(json["variations"]),
      );
}

class ImageVariations {
  ImageVariations({
    required this.medium_square,
    required this.medium,
  });

  Map<String, dynamic> toJson() {
    return {
      'medium': medium,
      'medium_square': medium_square,
    };
  }

  String medium_square;
  String medium;

  factory ImageVariations.fromJson(Map<String, dynamic> json) =>
      ImageVariations(
        medium_square: json["medium_square"],
        medium: json["medium"],
      );
}

class Statistics {
  Statistics({
    required this.status,
    required this.ratingsCount,
    required this.ratingsAverage,
    required this.labelsCount,
  });

  String status;
  int ratingsCount;
  double ratingsAverage;
  int labelsCount;

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'ratingsAverage': ratingsAverage,
    };
  }

  factory Statistics.fromJson(Map<String, dynamic> json) => Statistics(
        status: json["status"],
        ratingsCount: json["ratings_count"],
        ratingsAverage: json["ratings_average"].toDouble(),
        labelsCount: json["labels_count"],
      );
}

class Wine {
  Wine({
    required this.id,
    required this.name,
    required this.seoName,
    required this.typeId,
    required this.vintageType,
    required this.isNatural,
    required this.region,
    required this.style,
    required this.hasValidRatings,
  });

  int id;
  String name;
  String seoName;
  int typeId;
  int vintageType;
  bool isNatural;
  Region region;
  dynamic style;
  bool hasValidRatings;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'typeId': typeId,
      'vintageType': vintageType,
      'region': region,
      'style': style,
    };
  }

  factory Wine.fromJson(Map<String, dynamic> json) => Wine(
        id: json["id"],
        name: json["name"],
        seoName: json["seo_name"],
        typeId: json["type_id"],
        vintageType: json["vintage_type"],
        isNatural: json["is_natural"],
        region: Region.fromJson(json["region"]),
        style: json["style"],
        hasValidRatings: json["has_valid_ratings"],
      );
}

class Region {
  Region({
    required this.id,
    required this.name,
    required this.nameEn,
    required this.seoName,
    required this.country,
  });

  int id;
  String name;
  String nameEn;
  String seoName;
  Country country;

  Map<String, dynamic> toJson() {
    return {
      'country': country.toJson(),
      'name': name,
    };
  }

  factory Region.fromJson(Map<String, dynamic> json) => Region(
        id: json["id"],
        name: json["name"],
        nameEn: json["name_en"],
        seoName: json["seo_name"],
        country: Country.fromJson(json["country"]),
      );
}

class Country {
  Country({
    required this.code,
    required this.name,
    required this.nativeName,
    required this.seoName,
    //required this.currency,
    required this.regionsCount,
    required this.usersCount,
    required this.winesCount,
    required this.wineriesCount,
  });

  String code;
  String name;
  String nativeName;
  String seoName;
  //Currency currency;
  int regionsCount;
  int usersCount;
  int winesCount;
  int wineriesCount;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'wineriesCount': wineriesCount,
    };
  }

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        code: json["code"],
        name: json["name"],
        nativeName: json["native_name"],
        seoName: json["seo_name"],
        //currency: Currency.fromJson(json["currency"]),
        regionsCount: json["regions_count"],
        usersCount: json["users_count"],
        winesCount: json["wines_count"],
        wineriesCount: json["wineries_count"],
      );
}

class Winery {
  Winery({
    required this.id,
    required this.name,
    required this.seoName,
    required this.status,
  });

  int id;
  String name;
  String seoName;
  int status;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }

  factory Winery.fromJson(Map<String, dynamic> json) => Winery(
        id: json["id"],
        name: json["name"],
        seoName: json["seo_name"],
        status: json["status"],
      );
}
