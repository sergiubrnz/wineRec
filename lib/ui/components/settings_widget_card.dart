import 'package:flutter/material.dart';
import 'package:wine_rec/utils/colours.dart';

class SettingsWidgetCard extends StatelessWidget {
  final String? text;
  final IconButton? rightIcon;
  final Function? onClick;

  SettingsWidgetCard({
    Key? key,
    this.text,
    this.rightIcon,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick as void Function()?,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: kPrimaryColor),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            )),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      8.0,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 18,
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Text(
                        text!,
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: rightIcon!,
                          onPressed: () {},
                        ),
                      ),
                    ),
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
