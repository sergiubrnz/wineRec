import 'package:flutter/material.dart';

class YearCard extends StatelessWidget {
  late final String year;

  YearCard({
    required this.year,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170,
      height: 30,
      child: Card(
        elevation: 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(year),
          ],
        ),
      ),
    );
  }
}
