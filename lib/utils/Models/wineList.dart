import 'package:wine_rec/utils/Models/wineModel.dart';

class WineList {
  List<WineModel>? wines;

  add(WineModel wine) {
    wines?.add(wine);
  }

  Map<String, dynamic> toJson() {
    return {
      'wine': wines,
    };
  }
}
