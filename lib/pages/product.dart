import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Product extends StatefulWidget {
  const Product({Key? key}) : super(key: key);
  static const String id = 'product';

  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  Widget productFeature({required String fName, required String fValue, Color bgColor = Colors.white}) {
    return Container(
      color: bgColor,
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: ListTile(
        leading: Text(
          '$fName:',
          style: TextStyle(color: bgColor != Colors.white ? Colors.white : Colors.black, fontSize: 18),
        ),
        title: Text(fValue, style: TextStyle(color: bgColor != Colors.white ? Colors.white : Colors.blue)),
        contentPadding: EdgeInsets.symmetric(horizontal: 8),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Map product = ModalRoute.of(context)!.settings.arguments as Map;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(product['name']),
        ),
        body: ListView(
          children: [
            Container(
              height: 300,
              child: GridTile(
                child: Image.asset('images/products/samsung_galaxy_a12.jpg'),
                footer: Container(
                  padding: EdgeInsets.all(10),
                  height: 70,
                  color: Colors.black.withOpacity(0.3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${product['price_eg']} ج.م',
                        style: TextStyle(
                          color: Colors.redAccent.shade400,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        product['name'],
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text('المواصفات', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  productFeature(fName: 'الموديل', fValue: product['name']),
                  productFeature(fName: 'الشاشة', fValue: product['screen'], bgColor: Colors.blue),
                  productFeature(fName: 'الحمايات', fValue: product['screen_protect']),
                  productFeature(fName: 'دقة الشاشة', fValue: product['screen_res'], bgColor: Colors.blue),
                  productFeature(fName: 'نظام التشغيل', fValue: product['system']),
                  productFeature(fName: 'المعالج', fValue: product['cpu'], bgColor: Colors.blue),
                  productFeature(fName: 'المعالج الرسومى', fValue: product['gpu']),
                  productFeature(fName: 'الذاكرة', fValue: product['memory'], bgColor: Colors.blue),
                  productFeature(fName: 'الرام', fValue: product['ram']),
                  productFeature(fName: 'البطارية', fValue: product['battery'], bgColor: Colors.blue),

                  // =============================================================
                  // productFeature(fName: 'مميزات إضافية', fValue: 'بصمة تحت الشاشة'),
                  // =============================================================

                  SizedBox(height: 20),
                  Container(alignment: Alignment.center, child: Text('الكاميرات', style: TextStyle(fontSize: 18))),
                  SizedBox(height: 10),
                  productFeature(fName: 'الكاميرا الرئيسية', fValue: product['camera_main'], bgColor: Colors.green),
                  productFeature(fName: 'ميزات التصوير', fValue: product['camera_feature']),
                  productFeature(fName: 'الفيديو', fValue: product['camera_video'], bgColor: Colors.green),
                  productFeature(fName: 'الكاميرا ultrawide', fValue: product['camera_ultra']),
                  productFeature(fName: 'الكاميرا micro', fValue: product['camera_micro'], bgColor: Colors.green),
                  productFeature(fName: 'الكاميرا depth', fValue: product['camera_depth']),
                  productFeature(fName: 'الكاميرا telephoto', fValue: product['camera_tele'], bgColor: Colors.green),
                  productFeature(
                    fName: 'الكاميرا الأمامية',
                    fValue: product['	camera_self'] == null ? 'لا يوجد' : product['	camera_self'],
                  ),
                  productFeature(
                      fName: 'ميزات التصوير الأمامى', fValue: product['camera_self_feature'], bgColor: Colors.green),
                  productFeature(
                    fName: 'الفيديو الأمامى',
                    fValue: product['	camera_self_video'] == null ? 'لا يوجد' : product['	camera_self_video'],
                  ),

                  // =============================================================
                  SizedBox(height: 20),
                  Container(alignment: Alignment.center, child: Text('الأسعار', style: TextStyle(fontSize: 18))),
                  SizedBox(height: 10),
                  productFeature(fName: 'مصر', fValue: product['price_eg'], bgColor: Colors.red),
                  productFeature(fName: 'السعودية', fValue: product['price_sa']),
                  productFeature(fName: 'الإمارات', fValue: product['price_uae'], bgColor: Colors.red),
                  productFeature(fName: 'سوريا', fValue: product['price_sy']),
                  productFeature(fName: 'الأردن', fValue: product['price_jo'], bgColor: Colors.red),
                  productFeature(fName: 'الجزائر', fValue: product['price_alg']),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
