import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wine_rec/utils/Models/wineModel.dart';
import 'package:wine_rec/utils/colours.dart';

class WineCard extends StatelessWidget {
  WineCard({
    Key? key,
    this.wine,
  });

  final WineModel? wine;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Card(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                child: Image.network(
                  wine!.photoUrl,
                  height: 80,
                ),
              ),
            ),
            Expanded(
              child: Text(
                wine!.denumire,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: kPrimaryColor,
                  fontSize: 18,
                  fontFamily: 'AdobeGaramond',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(wine!.year.toString()),
                    Text('${wine!.pret.toString()} \$'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
