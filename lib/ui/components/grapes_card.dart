import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GrapesCard extends StatelessWidget {
  late final String denumire;
  late final String color;

  GrapesCard({
    required this.denumire,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90,
      height: 100,
      child: Card(
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Image.asset(
                    'assets/grape.png',
                    width: 50,
                    height: 50,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                SizedBox(
                  width: 30,
                  height: 30,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.2),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                ),
              ],
            ),
            Text(
              denumire,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
