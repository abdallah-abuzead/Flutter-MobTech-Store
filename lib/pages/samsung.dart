import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobtech/components/product_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Samsung extends StatefulWidget {
  const Samsung({Key? key}) : super(key: key);
  static const String id = 'samsung';

  @override
  _SamsungState createState() => _SamsungState();
}

class _SamsungState extends State<Samsung> {
  String? country;

  Future getAllSamsungMobiles() async {
    Uri url = Uri.parse('http://10.0.2.2/mobtech/');
    Map data = {'cat': '1'};
    // http.Response response = await http.get(url);
    http.Response response = await http.post(url, body: data);
    var responseBody = jsonDecode(response.body);
    return responseBody;
  }

  void getCountry() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    country = preferences.getString('country');
  }

  @override
  void initState() {
    super.initState();
    getCountry();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('سامسونج'),
        ),
        body: FutureBuilder(
          future: getAllSamsungMobiles(),
          builder: (context, AsyncSnapshot snapshot) {
            return !snapshot.hasData
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, i) {
                      return ProductCard(product: snapshot.data[i], country: country);
                    },
                  );
          },
        ),
      ),
    );
  }
}
