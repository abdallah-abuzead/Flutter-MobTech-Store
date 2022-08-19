import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  ProductTile({required this.name, required this.imageUrl});
  final String name;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: GridTile(
        child: Image.asset(imageUrl),
        footer: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 10),
          height: 25,
          color: Colors.black.withOpacity(0.6),
          child: Text(
            name,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      onTap: () {
        print('tapped');
      },
    );
  }
}
