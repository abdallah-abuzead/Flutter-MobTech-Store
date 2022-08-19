import 'package:flutter/material.dart';
import 'package:mobtech/pages/categories.dart';
import 'package:mobtech/pages/home.dart';
import 'package:mobtech/pages/login.dart';
import 'package:mobtech/pages/posts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({Key? key}) : super(key: key);

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  String username = '';
  String email = '';
  bool isLogin = false;

  void getUserData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      if (preferences.getString('username') != null) {
        username = preferences.getString('username') as String;
        email = preferences.getString('email') as String;
        isLogin = true;
      }
    });
  }

  Future<void> signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('username');
    preferences.remove('email');
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountEmail: Text(isLogin ? email : ''),
            accountName: Text(isLogin ? username : ''),
            currentAccountPicture: CircleAvatar(child: Icon(Icons.person)),
            decoration: BoxDecoration(
              color: Colors.red,
              image: DecorationImage(
                image: AssetImage('images/drawer_backgroud.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            title: Text('الصفحة الرئيسية', style: kDrawerTileStyle),
            leading: Icon(Icons.home, color: Colors.blue, size: 25),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(context, Home.id, (route) => false);
            },
          ),
          ListTile(
            title: Text('الأقسام', style: kDrawerTileStyle),
            leading: Icon(Icons.category, color: Colors.blue, size: 25),
            onTap: () {
              Navigator.popAndPushNamed(context, Categories.id);
            },
          ),
          !isLogin
              ? Container()
              : ListTile(
                  title: Text('المنشورات', style: kDrawerTileStyle),
                  leading: Icon(Icons.post_add, color: Colors.blue, size: 25),
                  onTap: () {
                    Navigator.popAndPushNamed(context, Posts.id);
                  },
                ),
          Divider(color: Colors.blue),
          ListTile(
            title: Text('حول التطبيق', style: kDrawerTileStyle),
            leading: Icon(Icons.info, color: Colors.blue, size: 25),
            onTap: () {},
          ),
          ListTile(
            title: Text('الإعدادات', style: kDrawerTileStyle),
            leading: Icon(Icons.settings, color: Colors.blue, size: 25),
            onTap: () {},
          ),
          isLogin
              ? ListTile(
                  title: Text('تسجيل الخروج', style: kDrawerTileStyle),
                  leading: Icon(Icons.logout, color: Colors.blue, size: 25),
                  onTap: () {
                    signOut();
                    Navigator.pushNamedAndRemoveUntil(context, Home.id, (route) => false);
                    Navigator.pushNamed(context, Login.id);
                  },
                )
              : ListTile(
                  title: Text('تسجيل الدخول', style: kDrawerTileStyle),
                  leading: Icon(Icons.login, color: Colors.blue, size: 25),
                  onTap: () {
                    Navigator.popAndPushNamed(context, Login.id);
                  },
                ),
        ],
      ),
    );
  }
}
