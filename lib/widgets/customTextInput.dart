import 'package:flutter/material.dart';
import '../const/colors.dart';

class CustomTextInput extends StatelessWidget {
  const CustomTextInput({
    @required this.hintText,
    this.onChanged,
    this.padding = const EdgeInsets.only(left: 40),
    Key key,
  }) : super(key: key);

  final String hintText;
  final ValueChanged<String> onChanged;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: ShapeDecoration(
        color: AppColor.placeholderBg,
        shape: StadiumBorder(),
      ),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(
            color: AppColor.placeholder,
          ),
          contentPadding: padding,
        ),
      ),
    );
  }
}
