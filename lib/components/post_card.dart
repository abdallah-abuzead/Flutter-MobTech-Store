import 'package:flutter/material.dart';
import 'package:mobtech/pages/comments.dart';
import 'package:mobtech/services/animate_route.dart';

class PostCard extends StatelessWidget {
  PostCard({required this.post});

  final Map post;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.only(bottom: 15),
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(child: Icon(Icons.person)),
            title: Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(post['username'], style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600)),
            ),
            trailing: Icon(Icons.more_vert),
            subtitle: Column(
              children: [
                Text(post['post']),
                SizedBox(height: 20),
                post['post_image'] != ''
                    ? Image.network('http://10.0.2.2/mobtech/upload/${post['post_image']}')
                    : Container(),
              ],
            ),
          ),
          Divider(color: Colors.grey, thickness: 0.6),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(border: Border(left: BorderSide(color: Colors.grey))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('اعجاب', textAlign: TextAlign.center),
                        SizedBox(width: 5),
                        Icon(Icons.thumb_up, color: Colors.grey),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(SlideUp(page: Comments(postId: post['post_id'])));
                    ;
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('تعليق', textAlign: TextAlign.center),
                        SizedBox(width: 5),
                        Icon(Icons.comment, color: Colors.grey),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
        ],
      ),
    );
  }
}
