import 'kakaoLogin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kakao_login/flutter_kakao_login.dart';


class SecondScreen extends StatelessWidget {
  final profileImage;
  SecondScreen({this.profileImage});
  
  @override
  Widget build(BuildContext context) {
    print(profileImage);
    return Scaffold(
      body: Image.network(
          profileImage,
        ),
      );
  }
}