import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobtech/components/product_card.dart';

class DataSearch extends SearchDelegate {
  List<String> data;

  DataSearch({required this.data});

  Future getSearchData() async {
    Uri url = Uri.parse('http://10.0.2.2/mobtech/searchmob.php');
    Map data = {'searchmobile': query};
    http.Response response = await http.post(url, body: data);
    List responseBody = jsonDecode(response.body);
    return responseBody.first;
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return query == ''
        ? Container()
        : FutureBuilder(
            future: getSearchData(),
            builder: (context, AsyncSnapshot snapshot) {
              return !snapshot.hasData
                  ? Center(child: CircularProgressIndicator())
                  : ProductCard(product: snapshot.data);
            },
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    bool hasQuery = query != '';
    List filteredNames = data.where((element) => element.toLowerCase().contains(query.toLowerCase())).toList();
    return ListView.builder(
      itemCount: hasQuery ? filteredNames.length : data.length,
      itemBuilder: (context, i) {
        return ListTile(
          leading: Icon(Icons.mobile_screen_share),
          title: Text(
            hasQuery ? filteredNames[i] : data[i],
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
          onTap: () {
            query = filteredNames[i];
            showResults(context);
          },
        );
      },
    );
  }
}
