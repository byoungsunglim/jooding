import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'kakaoLogin.dart';
import 'SecondScreen.dart';
import 'package:flutter_kakao_login/flutter_kakao_login.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Colors.white), 
        home: LoginScreen());
  }
}

class LoginScreen extends StatelessWidget {
  static final KakaoLogin kakao = new KakaoLogin();

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        body: Builder(
            builder: (context) => Center(
              child: InkWell (
              onTap: () async {
                final result = await kakao.login();
                print(result);
                if (result == KakaoLoginStatus.loggedIn) {
                  final KakaoAccountResult account = await kakao.getAccountInfo();
                  final userProfileImagePath = (account.userProfileImagePath == null) ? 'None' : account.userProfileImagePath;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => SecondScreen(),
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
              )
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