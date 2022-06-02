import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wine_rec/utils/colours.dart';

class InputTextFieldWidget extends StatefulWidget {
  const InputTextFieldWidget(
      {Key? key,
      required this.hintText,
      required this.textInputType,
      required this.icon,
      required this.isPass,
      required this.textEditingController})
      : super(key: key);
  final String hintText;
  final TextInputType textInputType;
  final IconData icon;
  final bool isPass;
  final TextEditingController textEditingController;

  @override
  State<InputTextFieldWidget> createState() => _InputTextFieldWidgetState();
}

class _InputTextFieldWidgetState extends State<InputTextFieldWidget> {
  late bool isVisible;

  @override
  void initState() {
    isVisible = widget.isPass;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: size.width * 0.8,
        decoration: BoxDecoration(
          border: Border.all(
            color: kPrimaryColor,
          ),
          color: kPrimaryLightColor,
          borderRadius: BorderRadius.circular(29),
        ),
        child: TextField(
          controller: widget.textEditingController,
          obscureText: isVisible,
          cursorColor: kPrimaryColor,
          decoration: InputDecoration(
            icon: Icon(
              widget.icon,
              color: kPrimaryColor,
            ),
            hintText: widget.hintText,
            border: InputBorder.none,
            suffixIcon: widget.isPass
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                    icon: Icon(
                      isVisible ? Icons.visibility : Icons.visibility_off,
                      color: kPrimaryColor,
                    ),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
