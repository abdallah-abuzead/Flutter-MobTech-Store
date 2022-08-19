import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mobtech/components/post_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Posts extends StatefulWidget {
  const Posts({Key? key}) : super(key: key);
  static const String id = 'posts';

  @override
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  TextEditingController postController = TextEditingController();
  Map user = {};
  File? _file;

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

  Future getAllPosts() async {
    Uri url = Uri.parse('http://10.0.2.2/mobtech/post.php');
    http.Response response = await http.get(url);
    var responseBody = jsonDecode(response.body);
    return responseBody;
  }

  Future chooseImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _file = File(pickedImage!.path);
    });
  }

  Future addPost() async {
    if (_file == null) return;
    String base64 = base64Encode(_file!.readAsBytesSync());
    String imageName = _file!.path.split('/').last;
    Uri url = Uri.parse('http://10.0.2.2/mobtech/addpost.php');
    var data = {'post': postController.text, 'post_user': user['id'], 'base64': base64, 'image_name': imageName};
    http.Response response = await http.post(url, body: data);
    var responseBody = jsonDecode(response.body);
    if (responseBody['status'] == 'success') Navigator.popAndPushNamed(context, Posts.id);
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('المنشورات'),
        ),
        body: ListView(
          children: [
            addPostCard(),
            SizedBox(height: 25),
            FutureBuilder(
              future: getAllPosts(),
              builder: (context, AsyncSnapshot snapshot) {
                return !snapshot.hasData
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        reverse: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, i) {
                          return PostCard(post: snapshot.data[i]);
                        },
                      );
              },
            ),
          ],
        ),
      ),
    );
  }

  Card addPostCard() {
    return Card(
      elevation: 4,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(child: Icon(Icons.person)),
                SizedBox(width: 15),
                Expanded(
                  child: TextFormField(
                    controller: postController,
                    maxLines: 5,
                    minLines: 1,
                    maxLength: 500,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(right: 10),
                      hintText: 'أضف منشور',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(22),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.camera_enhance, color: Colors.grey.shade700),
                        onPressed: () {
                          chooseImage();
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey.withOpacity(0.2)))),
            child: InkWell(
              onTap: () {
                addPost();
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('نشر', style: TextStyle(color: Colors.grey.shade700, fontSize: 16)),
                    SizedBox(width: 5),
                    Icon(Icons.add_box, color: Colors.grey.shade700),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
