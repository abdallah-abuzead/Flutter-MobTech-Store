import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mobtech/services/animate_route.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Comments extends StatefulWidget {
  Comments({required this.postId});
  final String postId;

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  Map user = {};
  TextEditingController commentController = TextEditingController();

  void getUserData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      if (preferences.getString('username') != null) {
        user = {
          'id': preferences.getString('id') as String,
          'username': preferences.getString('username') as String,
          'email': preferences.getString('username') as String,
        };
      }
    });
  }

  Future getAllPostComments() async {
    Uri url = Uri.parse('http://10.0.2.2/mobtech/comments.php');
    var data = {'post_id': widget.postId};
    http.Response response = await http.post(url, body: data);
    var responseBody = jsonDecode(response.body);
    return responseBody;
  }

  Future addComment() async {
    Uri url = Uri.parse('http://10.0.2.2/mobtech/addcomment.php');
    var data = {'comment': commentController.text, 'post_id': widget.postId, 'user_id': user['id']};
    http.Response response = await http.post(url, body: data);
    var responseBody = jsonDecode(response.body);
    if (responseBody['status'] == 'success')
      Navigator.pushReplacement(context, SlideUp(page: Comments(postId: widget.postId)));
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              color: Colors.white,
              width: screenWidth,
              height: screenHeight,
            ),
            Positioned(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 70),
                  child: FutureBuilder(
                    future: getAllPostComments(),
                    builder: (context, AsyncSnapshot snapshot) {
                      return !snapshot.hasData
                          ? Center(child: CircularProgressIndicator())
                          : ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, i) {
                                return ListTile(
                                  leading: CircleAvatar(child: Icon(Icons.person)),
                                  title: Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Text(snapshot.data[i]['username']),
                                  ),
                                  subtitle: Container(
                                    padding: EdgeInsets.all(10),
                                    color: Colors.grey.shade100,
                                    child: Text(snapshot.data[i]['comment']),
                                  ),
                                );
                              },
                            );
                    },
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: 60,
                width: screenWidth,
                padding: EdgeInsets.all(5),
                decoration:
                    BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Colors.grey.shade300))),
                child: Row(
                  children: [
                    IconButton(icon: Icon(Icons.camera_alt, color: Colors.grey), onPressed: () {}),
                    Expanded(
                      child: TextFormField(
                        controller: commentController,
                        decoration: InputDecoration(
                          hintText: 'اكتب تعليقك هنا',
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          contentPadding: EdgeInsets.only(right: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          suffixIcon: IconButton(
                              icon: Icon(Icons.send),
                              onPressed: () {
                                addComment();
                              }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
