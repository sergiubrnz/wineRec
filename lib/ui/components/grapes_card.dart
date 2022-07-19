import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wine_rec/utils/colours.dart';

class GrapesCard extends StatelessWidget {
  late final String denumire;
  late final String color;

  GrapesCard({
    required this.denumire,
    required this.color,
  });

  Color getColor() {
    Color widgetColor = Colors.red.withOpacity(0.2);
    if (color == 'red') {
      widgetColor = kRedWine.withOpacity(0.4);
    } else if (color == 'white') {
      widgetColor = kWhiteWine.withOpacity(0.4);
    } else if (color == 'rose') {
      widgetColor = kRoseWine.withOpacity(0.4);
    }
    return widgetColor;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.215,
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
                        color: getColor(),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                ),
              ],
            ),
            FittedBox(
              fit: BoxFit.cover,
              child: Text(
                denumire,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
