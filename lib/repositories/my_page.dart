import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jooding/models/account.dart';

import 'package:shared_preferences/shared_preferences.dart';
// import 'package:jooding/kakaoLogin.dart';
// import 'package:flutter_kakao_login/flutter_kakao_login.dart';

class MyPage {
  // String _data;
  static Account _data;
  // static final KakaoLogin kakao = new KakaoLogin();

  // Future<void> fetchData() async {
  //   // simulate real data fetching
  //   await Future.delayed(Duration(milliseconds: 600));
  //   // store dummy data
  //   _data = 'My Page';
  // }

  Future<Account> fetchData() async {
    // final KakaoAccountResult account = await kakao.getAccountInfo();
    // final userEmail = (account.userEmail == null) ? "" : account.userEmail;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final uid = prefs.getString('uid');
            
    var response = await http.get(
      Uri.encodeFull("https://jooding-development.herokuapp.com/users/${uid}"),
      headers: {
        "Content-type": "application/json",
        "charset": "utf-8"
      }
    );

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON. 
      _data = Account.fromJson(json.decode(Utf8Decoder().convert(response.bodyBytes)));
      
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Account get data => _data;
  // String get data => _data;
}