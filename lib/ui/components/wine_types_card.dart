import 'package:flutter/material.dart';

class WineTypesCard extends StatelessWidget {
  late final String denumire;
  late final String image;

  WineTypesCard({
    required this.denumire,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 100,
      child: Card(
        elevation: 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Image.asset(
                image,
                width: 80,
                height: 80,
                fit: BoxFit.scaleDown,
              ),
            ),
            Text(denumire),
          ],
        ),
      ),
    );
  }
}
