import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobtech/components/custom_input_field.dart';
import 'package:http/http.dart' as http;
import 'package:mobtech/components/spinner.dart';
import 'package:mobtech/pages/home.dart';
import '../constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  static const String id = 'login';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool showSignIn = true;
  // FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String _token = '';

  @override
  void initState() {
    super.initState();
    // _firebaseMessaging.getToken().then((token) {
    //   print(token);
    //   setState(() {
    //     _token = _token;
    //   });
    // });
  }

  Future<void> signIn() async {
    var formData = signInFormKey.currentState;
    if (formData!.validate()) {
      showSpinner(context);
      Uri url = Uri.parse('http://10.0.2.2/mobtech/login.php');
      Map data = {'email': emailController.text, 'password': passwordController.text};
      http.Response response = await http.post(url, body: data);
      var responseBody = jsonDecode(response.body);
      Navigator.of(context).pop();
      if (responseBody['status'] == 'success') {
        await setUserData(responseBody);
        Navigator.of(context).pushNamedAndRemoveUntil(Home.id, (route) => false);
      } else
        showErrorDialog(context, 'البيانات المدخلة غير صحيحة');
    }
  }

  Future<void> signUp() async {
    var formData = signUpFormKey.currentState;
    if (formData!.validate()) {
      showSpinner(context);
      Uri url = Uri.parse('http://10.0.2.2/mobtech/signup.php');
      Map data = {
        'username': usernameController.text,
        'email': emailController.text,
        'password': passwordController.text,
      };
      http.Response response = await http.post(url, body: data);
      var responseBody = jsonDecode(response.body);
      Navigator.of(context).pop();
      if (responseBody['status'] == 'success') {
        await setUserData(responseBody);
        Navigator.of(context).pushNamedAndRemoveUntil(Home.id, (route) => false);
      } else
        showErrorDialog(context, 'البريد الإلكترونى موجود بالفعل');
    }
  }

  Future<void> setUserData(Map user) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('id', user['id']);
    preferences.setString('username', user['username']);
    preferences.setString('email', user['email']);
  }

  String? usernameValidator(String? value) {
    if (value!.trim().isEmpty) return 'يجب إدخال إسم المستخدم';
    if (value.trim().length < 4) return 'يجب ألا يقل إسم المستخدم عن 4 أحرف';
    if (value.trim().length > 20) return 'يجب ألا يزيد إسم المستخدم عن 20 حرف';
  }

  String? emailValidator(String? value) {
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value!);
    if (value.isEmpty) return 'يجب إدخال البريد الإلكترونى';
    if (!emailValid) return 'صيغة الإيميل المدخل غير صحيحة';
  }

  String? passwordValidator(String? value) {
    if (value!.isEmpty) return 'يجب إدخال كلمة المرور';
    if (value.length < 6) return 'يجب ألا تقل كلمة المرور عن 6 أحرف';
    if (value.length > 50) return 'يجب ألا تزيد كلمة المرور عن 50 حرف';
  }

  String? confirmPasswordValidator(String? value) {
    if (value != passwordController.text) return 'كلمة المرور غير متطابقة';
  }

  void emptyAllFields() {
    usernameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Stack(
          children: [
            Container(width: double.infinity, height: double.infinity),
            topCurve(screenWidth),
            leftCurve(screenWidth),
            Container(
              margin: EdgeInsets.only(top: 30),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        showSignIn ? 'تسجيل الدخول' : 'إنشاء حساب جديد',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 20),
                    customAvatar(),
                    SizedBox(height: showSignIn ? 40 : 15),
                    showSignIn ? signInFormBox(screenWidth) : signUpFormBox(screenWidth),
                    SizedBox(height: showSignIn ? 20 : 0),
                    !showSignIn
                        ? Container()
                        : InkWell(
                            onTap: () {},
                            child: Text(
                              'هل نسيت كلمة المرور؟',
                              style: TextStyle(color: Colors.blue, fontSize: 18),
                            ),
                          ),
                    SizedBox(height: showSignIn ? 20 : 15),
                    ElevatedButton(
                      onPressed: () {
                        showSignIn ? signIn() : signUp();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: showSignIn ? Colors.blue : Colors.grey.shade700,
                        elevation: 8,
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            showSignIn ? 'تسجيل الدخول' : 'إنشاء حساب',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(width: 10),
                          Icon(Icons.arrow_forward),
                        ],
                      ),
                    ),
                    SizedBox(height: showSignIn ? 20 : 10),
                    InkWell(
                      onTap: () {
                        setState(() {
                          showSignIn = !showSignIn;
                          emptyAllFields();
                        });
                      },
                      child: Text(
                        showSignIn ? 'إنشاء حساب جديد' : 'تسجيل الدخول',
                        style: TextStyle(color: Colors.blue, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 20),
                    !showSignIn
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.blue,
                                      elevation: 8,
                                      padding: EdgeInsets.symmetric(vertical: 13),
                                    ),
                                    child: Text('Facebook Sign in', style: TextStyle(fontSize: 20)),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.red,
                                      elevation: 8,
                                      padding: EdgeInsets.symmetric(vertical: 13),
                                    ),
                                    child: Text('Google Sign in', style: TextStyle(fontSize: 20)),
                                  ),
                                ),
                              ],
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

  Widget signInFormBox(double screenWidth) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 600),
      height: 250,
      width: screenWidth / 1.2,
      padding: EdgeInsets.only(left: 10, right: 10, top: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(blurRadius: 1, spreadRadius: 0.1, offset: Offset(1, 1))],
      ),
      child: Form(
        key: signInFormKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CustomInputField(
              //   label: 'اسم المستخدم',
              //   textFormField: TextFormField(
              //     controller: usernameController,
              //     validator: usernameValidator,
              //     decoration: kInputFieldDecoration,
              //   ),
              // ),
              //================================================
              CustomInputField(
                label: 'البريد الإلكترونى',
                textFormField: TextFormField(
                  controller: emailController,
                  validator: emailValidator,
                  keyboardType: TextInputType.emailAddress,
                  decoration: kInputFieldDecoration.copyWith(hintText: 'أدخل البريد الإلكترونى'),
                ),
              ),
              SizedBox(height: 10),
              CustomInputField(
                label: 'كلمة المرور',
                textFormField: TextFormField(
                  controller: passwordController,
                  validator: passwordValidator,
                  obscureText: true,
                  decoration: kInputFieldDecoration.copyWith(hintText: 'أدخل كلمة المرور'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget signUpFormBox(double screenWidth) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 600),
      height: 440,
      width: screenWidth / 1.2,
      padding: EdgeInsets.only(left: 10, right: 10, top: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(blurRadius: 1, spreadRadius: 0.1, offset: Offset(1, 1))],
      ),
      child: Form(
        key: signUpFormKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomInputField(
                label: 'اسم المستخدم',
                textFormField: TextFormField(
                  controller: usernameController,
                  validator: usernameValidator,
                  decoration: kInputFieldDecoration,
                ),
              ),
              //================================================
              SizedBox(height: 10),
              CustomInputField(
                label: 'البريد الإلكترونى',
                textFormField: TextFormField(
                  controller: emailController,
                  validator: emailValidator,
                  keyboardType: TextInputType.emailAddress,
                  decoration: kInputFieldDecoration.copyWith(hintText: 'أدخل البريد الإلكترونى'),
                ),
              ),
              //================================================
              SizedBox(height: 10),
              CustomInputField(
                label: 'كلمة المرور',
                textFormField: TextFormField(
                  controller: passwordController,
                  validator: passwordValidator,
                  obscureText: true,
                  decoration: kInputFieldDecoration.copyWith(hintText: 'أدخل كلمة المرور'),
                ),
              ),
              //================================================
              SizedBox(height: 10),
              CustomInputField(
                label: 'تأكيد كلمة المرور',
                textFormField: TextFormField(
                  controller: confirmPasswordController,
                  validator: confirmPasswordValidator,
                  obscureText: true,
                  decoration: kInputFieldDecoration.copyWith(hintText: 'أعد ادخال كلمة المرور'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget customAvatar() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: showSignIn ? Colors.yellow : Colors.grey.shade700,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [BoxShadow(blurRadius: 5, spreadRadius: 0.1)],
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            showSignIn = !showSignIn;
            emptyAllFields();
          });
        },
        child: Stack(
          children: [
            Positioned(top: 25, right: 25, child: Icon(Icons.person_outline, color: Colors.white, size: 50)),
            Positioned(top: 35, right: 10, child: Icon(Icons.arrow_back, color: Colors.white, size: 30)),
          ],
        ),
      ),
    );
  }

  Positioned topCurve(double screenWidth) {
    return Positioned(
      child: Transform.scale(
        scale: 1.3,
        child: Transform.translate(
          offset: Offset(0, -230),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            width: screenWidth,
            height: screenWidth,
            decoration: BoxDecoration(
              color: showSignIn ? Colors.grey.shade800 : Colors.blueAccent.shade700,
              borderRadius: BorderRadius.circular(screenWidth),
            ),
          ),
        ),
      ),
    );
  }

  Positioned leftCurve(double screenWidth) {
    return Positioned(
      top: 300,
      right: screenWidth / 1.45,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        width: screenWidth,
        height: screenWidth,
        decoration: BoxDecoration(
          color: showSignIn ? Colors.blue.withOpacity(0.25) : Colors.grey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(screenWidth),
        ),
      ),
    );
  }
}
