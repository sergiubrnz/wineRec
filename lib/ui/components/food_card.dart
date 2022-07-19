import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FoodCard extends StatelessWidget {
  late final String denumire;
  late final String image;

  FoodCard({
    required this.denumire,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.45,
      height: 100,
      child: Card(
        elevation: 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: 50,
                height: 50,
                child: Image.asset(
                  image,
                  width: 90,
                  height: 90,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
            Text(
              denumire,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
