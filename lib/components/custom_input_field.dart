import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  const CustomInputField({required this.label, required this.textFormField});

  final String label;
  final TextFormField textFormField;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600)),
          SizedBox(height: 10),
          textFormField,
        ],
      ),
    );
  }
}
