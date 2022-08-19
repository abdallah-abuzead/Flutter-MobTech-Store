// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobtech/pages/choose_country.dart';
import 'package:mobtech/pages/login.dart';
import 'package:mobtech/pages/categories.dart';
import 'package:mobtech/pages/home.dart';
import 'package:mobtech/pages/posts.dart';
import 'package:mobtech/pages/product.dart';
import 'package:mobtech/pages/samsung.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  // await Firebase.initializeApp();
  // WidgetsFlutterBinding.ensureInitialized();
  // MobileAds.instance.initialize();
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MobTech',
      initialRoute: ChooseCountry.id,
      routes: {
        Home.id: (context) => Home(),
        Categories.id: (context) => Categories(),
        Samsung.id: (context) => Samsung(),
        ChooseCountry.id: (context) => ChooseCountry(),
        Login.id: (context) => Login(),
        Posts.id: (context) => Posts(),
        Product.id: (context) => Product(),
      },
      theme: ThemeData(
        appBarTheme: AppBarTheme(centerTitle: true),
        fontFamily: 'Cairo',
      ),
    );
  }
}
