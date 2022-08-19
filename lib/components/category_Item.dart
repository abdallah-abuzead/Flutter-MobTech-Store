import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  CategoryItem({required this.name, required this.imageUrl});
  final String name;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      child: ListTile(
        title: Image.asset(
          imageUrl,
          height: 75,
          fit: BoxFit.cover,
        ),
        subtitle: Text(
          name,
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
