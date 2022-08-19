import 'package:flutter/material.dart';
import 'package:mobtech/components/custom_text.dart';
import 'package:mobtech/pages/product.dart';
import '../constants.dart';

class ProductCard extends StatelessWidget {
  ProductCard({required this.product, this.country});
  final Map product;
  final String? country;

  String getPrice() {
    String price;
    switch (country) {
      case 'eg':
        price = product['price_eg'];
        break;
      case 'sa':
        price = product['price_sa'];
        break;
      case 'sy':
        price = product['price_sy'];
        break;
      case 'alg':
        price = product['price_alg'];
        break;
      case 'jo':
        price = product['price_jo'];
        break;
      case 'uae':
        price = product['price_uae'];
        break;
      default:
        price = 'غير متوفر';
    }
    return price;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Product.id, arguments: product);
      },
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(left: 10, top: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: Image.asset('images/products/samsung_galaxy_s20.jpg', height: 160, fit: BoxFit.cover),
              ),
              Expanded(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product['name'], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text('الكاميرا: ', style: TextStyle(color: Colors.grey)),
                        CustomText(product['camera_main'], style: TextStyle(color: Colors.blue)),
                      ],
                    ),
                    Row(
                      children: [
                        Text('المعالج: ', style: TextStyle(color: Colors.grey)),
                        CustomText(product['cpu'], style: TextStyle(color: Colors.blue)),
                      ],
                    ),
                    Row(
                      children: [
                        Text('الذاكرة: ', style: TextStyle(color: Colors.grey)),
                        CustomText(product['memory'], style: TextStyle(color: Colors.blue)),
                      ],
                    ),
                    SizedBox(height: 2),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('البطارية: ', style: TextStyle(color: Colors.grey)),
                        CustomText(product['battery'], style: TextStyle(color: Colors.blue)),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Container(
                          width: kProductSpecWidth,
                          child: Row(
                            children: [
                              Text('السعر: ', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                              Text(
                                getPrice(),
                                style: TextStyle(color: Colors.red, fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
