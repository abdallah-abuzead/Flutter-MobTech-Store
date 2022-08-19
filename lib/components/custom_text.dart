import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  CustomText(this.text, {this.style});
  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Text(
        text,
        style: style,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
