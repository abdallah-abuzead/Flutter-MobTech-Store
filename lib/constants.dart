import 'package:flutter/material.dart';

const kProductSpecWidth = 150.0;
const kDrawerTileStyle = TextStyle(color: Colors.black, fontSize: 18);
const kHomeHeaderStyle = TextStyle(color: Colors.blue, fontSize: 25, fontWeight: FontWeight.bold);

final kInputFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
  hintText: 'أدخل اسم المستخدم',
  filled: true,
  fillColor: Colors.grey.shade200,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey.shade500, width: 1, style: BorderStyle.solid),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blue, width: 1, style: BorderStyle.solid),
  ),
);
