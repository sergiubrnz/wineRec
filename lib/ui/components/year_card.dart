import 'package:flutter/material.dart';

class YearCard extends StatelessWidget {
  late final String year;

  YearCard({
    required this.year,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.45,
      height: 30,
      child: Card(
        elevation: 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              year,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
