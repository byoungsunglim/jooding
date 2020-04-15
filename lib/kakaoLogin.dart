import 'dart:async';
import 'package:flutter_kakao_login/flutter_kakao_login.dart';

class KakaoLogin {
  static final FlutterKakaoLogin kakaoSignIn = new FlutterKakaoLogin();

  Future<Object> login() async {
    final KakaoLoginResult result = await kakaoSignIn.logIn();

    return result.status;
    // _processLoginResult(result);
  }

  Future<Null> logOut() async {
    final KakaoLoginResult result = await kakaoSignIn.logOut();
    // _processLoginResult(result);
  }

  Future<Null> unlink() async {
    await kakaoSignIn.unlink();
  }

  Future<KakaoAccountResult> getAccountInfo() async {
    final KakaoLoginResult result = await kakaoSignIn.getUserMe();
    if (result != null && result.status != KakaoLoginStatus.error) {
      // final KakaoAccountResult account = result.account;
      return result.account;
    }
    else {
      return null;
    }
  }

  Future<Null> getAccessToken() async {
    final KakaoAccessToken accessToken = await (kakaoSignIn.currentAccessToken);
    if (accessToken != null) {
      final token = accessToken.token;
      // _showAlert(context, "token is $token");
    } else {
      // _showAlert(context, "No Access Token");
    }
  }


  // void _processLoginResult(KakaoLoginResult result) {
  //   switch (result.status) {
  //     case KakaoLoginStatus.loggedIn:
  //         // _showAlert(context, "User Logged In");
  //         return result.status;
  //       break;
  //     case KakaoLoginStatus.loggedOut:
  //         // _showAlert(context, "User Logged Out");
  //       break;
  //     case KakaoLoginStatus.error:
  //         // _showAlert(context, "Error");
  //       break;
  //   }
  // }

  // void _processAccountResult(KakaoAccountResult account) {
  //   if (account == null) {
  //     // _showAlert(context, "No Account Info");
  //   } else {
  //     final userID = (account.userID == null) ? 'None' : account.userID;
  //     final userEmail = (account.userEmail == null) ? 'None' : account.userEmail;
  //     final userPhoneNumber = (account.userPhoneNumber == null) ? 'None' : account.userPhoneNumber;
  //     final userDisplayID = (account.userDisplayID == null) ? 'None' : account.userDisplayID;
  //     final userNickname =  (account.userNickname == null) ? 'None' : account.userNickname;
  //     final userProfileImagePath = (account.userProfileImagePath == null) ? 'None' : account.userProfileImagePath;
  //     final userThumbnailImagePath = (account.userThumbnailImagePath == null) ? 'None' : account.userThumbnailImagePath;

  //     // _showAlert(context, '- ID is ${userID}\n'
  //     //                     '- Email is ${userEmail}\n'
  //     //                     '- PhoneNumber is ${userPhoneNumber}\n'
  //     //                     '- DisplayID is ${userDisplayID}\n'
  //     //                     '- Nickname is ${userNickname}\n'
  //     //                     '- ProfileImagePath is ${userProfileImagePath}\n'
  //     //                     '- ThumbnailImagePath is ${userThumbnailImagePath}');
  //   }
  // }

  // void _showAlert(BuildContext context, String value) {
  //   if (value.isEmpty) return;

  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return new AlertDialog(
  //           content: new Text(value,
  //               style: new TextStyle(fontWeight: FontWeight.bold)),
  //           actions: <Widget>[
  //             new FlatButton(
  //               child: new Text('OK'),
  //               onPressed: () {
  //                 Navigator.of(context).pop(true);
  //               },
  //             )
  //           ],
  //         );
  //       });
  // }

  // Widget build(BuildContext context) {
  //   return new MaterialApp(
  //     home: new Scaffold(
  //       body: new Align(
  //         alignment: FractionalOffset.center,
  //         child: InkWell (
  //           onTap: () {
  //             login();
  //           },
  //           child: Container(
  //             width: 320.0,
  //             height: 60.0,
  //             alignment: FractionalOffset.center,
  //             decoration: new BoxDecoration(
  //               color: const Color.fromRGBO(255, 232, 18, 1.0),
  //               borderRadius: new BorderRadius.all(const Radius.circular(5.0)),
  //             ),
  //             child: new Text(
  //               "카카오톡으로 로그인",
  //               style: new TextStyle(
  //                 color: Colors.black,
  //                 fontSize: 20.0,
  //                 letterSpacing: 0.3,
  //               )
  //             )
  //           )
  //         )
  //       )
  //     )
  //   );
  // }
}
