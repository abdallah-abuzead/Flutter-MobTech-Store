import 'package:flutter/material.dart';
import 'package:mobtech/pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/countries.dart';

class ChooseCountry extends StatefulWidget {
  const ChooseCountry({Key? key}) : super(key: key);
  static const String id = 'choose_country';

  @override
  _ChooseCountryState createState() => _ChooseCountryState();
}

class _ChooseCountryState extends State<ChooseCountry> {
  Future<void> setCountry(String country) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('country', country);
  }

  void getCountry() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? country = preferences.getString('country');
    if (country != null) {
      Navigator.pushNamedAndRemoveUntil(context, Home.id, (route) => false);
    }
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
          title: Text('اختر البلد'),
        ),
        body: ListView.builder(
          itemCount: countries.length,
          itemBuilder: (context, i) {
            return ListTile(
              title: Text(countries[i]['name']),
              onTap: () async {
                await setCountry(countries[i]['code']);
                Navigator.pushNamedAndRemoveUntil(context, Home.id, (route) => false);
              },
              trailing: CircleAvatar(radius: 22, backgroundImage: AssetImage(countries[i]['flag_url'])),
            );
          },
        ),
      ),
    );
  }
}
