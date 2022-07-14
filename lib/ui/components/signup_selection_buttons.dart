import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/colours.dart';

class SignupSelectionButtons extends StatefulWidget {
  final String text;
  final bool isSelected;
  final bool fixedWidth;
  const SignupSelectionButtons(
      {Key? key,
      required this.text,
      required this.isSelected,
      required this.fixedWidth})
      : super(key: key);

  @override
  State<SignupSelectionButtons> createState() => _SignupSelectionButtonsState();
}

class _SignupSelectionButtonsState extends State<SignupSelectionButtons> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Padding(
        padding: widget.fixedWidth
            ? const EdgeInsets.symmetric(horizontal: 10.0)
            : const EdgeInsets.symmetric(horizontal: 5),
        child: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 20),
            width: widget.fixedWidth ? size.width * 0.4 : null,
            height: size.height * 0.05,
            decoration: BoxDecoration(
              border: Border.all(
                color: kPrimaryColor,
              ),
              color: widget.isSelected
                  ? kPrimaryColor.withOpacity(0.3)
                  : Colors.white70,
              borderRadius: BorderRadius.circular(29),
            ),
            child: Center(
              child: Text(
                widget.text,
                style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: kPrimaryColor,
                ),
              ),
            )),
      ),
    );
  }
}
