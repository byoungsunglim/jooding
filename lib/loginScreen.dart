import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'kakaoLogin.dart';
import 'package:jooding/questionnaires.dart';
import 'package:flutter_kakao_login/flutter_kakao_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

// void main() => runApp(new MyApp());

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => new _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         theme: ThemeData(primaryColor: Colors.white), 
//         home: LoginScreen());
//   }
// }

class LoginScreen extends StatelessWidget {
  static final KakaoLogin kakao = new KakaoLogin();

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        body: Builder(
            builder: (context) => Center(
              child: Column(
              children: <Widget>[
                SizedBox(height: 200.0),
                Container(
                  height: 120.0,
                  width: 240.0,
                  decoration: new BoxDecoration(
                    image: DecorationImage(
                      image: new AssetImage(
                          'lib/ui/icons/logo.png'),
                      fit: BoxFit.fill,
                    ),
                    shape: BoxShape.rectangle,
                  ),
                ),
                SizedBox(height: 200.0),
                InkWell (
                  onTap: () async {
                    final result = await kakao.login();
                    print(result);
                    if (result == KakaoLoginStatus.loggedIn) {
                      final KakaoAccountResult account = await kakao.getAccountInfo();
                      final userID = (account.userID == null) ? "" : account.userID;
                      final userEmail = (account.userEmail == null) ? "" : account.userEmail;
                      final userPhoneNumber = (account.userPhoneNumber == null) ? "" : account.userPhoneNumber;
                      final userDisplayID = (account.userDisplayID == null) ? "" : account.userDisplayID;
                      final userNickname =  (account.userNickname == null) ? "" : account.userNickname;
                      final userProfileImagePath = (account.userProfileImagePath == null) ? "" : account.userProfileImagePath;
                      final userThumbnailImagePath = (account.userThumbnailImagePath == null) ? "" : account.userThumbnailImagePath;

                      // print('- ID is ${userID}\n'
                      //       '- Email is ${userEmail}\n'
                      //       '- PhoneNumber is ${userPhoneNumber}\n'
                      //       '- DisplayID is ${userDisplayID}\n'
                      //       '- Nickname is ${userNickname}\n'
                      //       '- ProfileImagePath is ${userProfileImagePath}\n'
                      //       '- ThumbnailImagePath is ${userThumbnailImagePath}');

                      var url = 'https://jooding-development.herokuapp.com/users/registration';
                      var response = await http.post(url, body: 
                        json.encode({
                          'name': userNickname,
                          'email': userEmail, 
                          'profile_image': userProfileImagePath,
                          'phone': userPhoneNumber,
                          'kakao_id': userDisplayID
                        }));
                      print('Response status: ${response.statusCode}');
                      print('Response body: ${response.body}');

                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.setBool("welcome", true);
               
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => Questionnaires(),
                      ));
                    }
                    else {
                      _showSnackbar(context);
                    }
                  },
                child: Container(
                  width: 320.0,
                  height: 60.0,
                  alignment: FractionalOffset.center,
                  decoration: new BoxDecoration(
                    color: const Color.fromRGBO(255, 232, 18, 1.0),
                    borderRadius: new BorderRadius.all(const Radius.circular(5.0)),
                  ),
                  child: new Text(
                    "카카오톡으로 로그인",
                    style: new TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      letterSpacing: 0.3,
                    )
                  )
                ),
                )                
              ]
              )
          )
        )
      )
    );
  }

  void _showSnackbar(BuildContext context) {
    final scaff = Scaffold.of(context);
    scaff.showSnackBar(SnackBar(
      content: Text("카카오톡 로그인 실패"),
      backgroundColor: Colors.grey,
      duration: Duration(seconds: 5),
      action: SnackBarAction(
        label: 'UNDO', onPressed: scaff.hideCurrentSnackBar, textColor: Colors.white,
      ),
    ));
  }
}