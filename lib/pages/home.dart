import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobtech/data/categories.dart';
import 'package:mobtech/data/products.dart';
import 'package:mobtech/pages/categories.dart';
import 'package:mobtech/services/ad_helper.dart';
import 'package:mobtech/services/data_search.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/image_carousel.dart';
import '../components/side_drawer.dart';
import '../constants.dart';
import 'package:http/http.dart' as http;
// import 'package:google_mobile_ads/google_mobile_ads.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  static const String id = 'home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? country;
  List<String> searchList = [];
  // late BannerAd _bannerAd;
  bool _isBannerAdReady = false;

  @override
  void initState() {
    super.initState();
    getAllMobiles();
    getCountry();
    // _bannerAd = BannerAd(
    //   size: AdSize.banner,
    //   // adUnitId: AdHelper.bannerAdUnitID,
    //   // adUnitId: BannerAd.testAdUnitId,
    //   adUnitId: 'ca-app-pub-6541318803364522/2520669281',
    //   listener: BannerAdListener(
    //     onAdLoaded: (_) {
    //       setState(() {
    //         _isBannerAdReady = true;
    //       });
    //     },
    //     onAdFailedToLoad: (ad, error) {
    //       print('Failed to load a banner Ad: ${error.message}');
    //       _isBannerAdReady = false;
    //       ad.dispose();
    //     },
    //   ),
    //   request: AdRequest(),
    // )..load();
  }

  Future getAllMobiles() async {
    Uri url = Uri.parse('http://10.0.2.2/mobtech/search.php');
    http.Response response = await http.get(url);
    List responseBody = jsonDecode(response.body);
    responseBody.forEach((element) {
      searchList.add(element['name']);
    });
  }

  void getCountry() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    country = preferences.getString('country');
  }

  @override
  void dispose() {
    super.dispose();
    // _bannerAd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('الصفحة الرئيسية'),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: DataSearch(data: searchList));
              },
            ),
          ],
        ),
        drawer: SideDrawer(),
        body: ListView(
          children: [
            Container(height: 280, child: ImageCarousel()),
            SizedBox(height: 20),
            // !_isBannerAdReady
            //     ? Container()
            //     : Container(
            //         height: _bannerAd.size.height.toDouble(),
            //         width: _bannerAd.size.width.toDouble(),
            //         child: AdWidget(ad: _bannerAd),
            //       ),
            InkWell(
              child: Container(
                child: Text('الأقسام', style: kHomeHeaderStyle),
                padding: EdgeInsets.symmetric(horizontal: 10),
              ),
              onTap: () {
                Navigator.pushNamed(context, Categories.id);
              },
            ),
            Container(height: 100, child: ListView(scrollDirection: Axis.horizontal, children: categories)),
            SizedBox(height: 20),
            Container(
              child: Text('أحدث المنتجات', style: kHomeHeaderStyle),
              padding: EdgeInsets.symmetric(horizontal: 10),
            ),
            Container(
              height: 440,
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 5,
                ),
                children: latestProducts,
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
