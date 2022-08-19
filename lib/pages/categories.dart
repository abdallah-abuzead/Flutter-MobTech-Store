import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobtech/components/side_drawer.dart';
import 'package:mobtech/pages/samsung.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);
  static const String id = 'categories';

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('الأقسام'),
        ),
        // drawer: SideDrawer(),
        body: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 5,
          ),
          children: [
            CategoryGridItem(
              name: 'Apple',
              imageUrl: 'images/categories/apple.jpg',
              onTap: () {
                Navigator.pushNamed(context, Samsung.id);
              },
            ),
            CategoryGridItem(
              name: 'Samsung',
              imageUrl: 'images/categories/samsung.png',
              onTap: () {
                Navigator.pushNamed(context, Samsung.id);
              },
            ),
            CategoryGridItem(
              name: 'Huawei',
              imageUrl: 'images/categories/huawei.jpg',
              onTap: () {
                Navigator.pushNamed(context, Samsung.id);
              },
            ),
            CategoryGridItem(
              name: 'Oppo',
              imageUrl: 'images/categories/oppo.jpg',
              onTap: () {
                Navigator.pushNamed(context, Samsung.id);
              },
            ),
            CategoryGridItem(
              name: 'Xiaomi',
              imageUrl: 'images/categories/xiaomi.png',
              onTap: () {
                Navigator.pushNamed(context, Samsung.id);
              },
            ),
            CategoryGridItem(
              name: 'Nokia',
              imageUrl: 'images/categories/nokia.jpg',
              onTap: () {
                Navigator.pushNamed(context, Samsung.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryGridItem extends StatelessWidget {
  CategoryGridItem({required this.name, required this.imageUrl, required this.onTap});
  final String name;
  final String imageUrl;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Column(
          children: [
            Expanded(child: Image.asset(imageUrl)),
            Divider(height: 10, thickness: 0.75),
            Container(
              padding: EdgeInsets.only(bottom: 5),
              child: Text(name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }
}
