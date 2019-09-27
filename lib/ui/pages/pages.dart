import 'package:flutter/material.dart';
import 'package:jooding/models/account.dart';

class HomePage extends StatelessWidget {
  final String text;

  HomePage({this.text}) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('My text is: $text'),
      ),
    );
  }
}

class InputPage extends StatelessWidget {
  final String text;

  InputPage({this.text}) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('My text is: $text'),
      ),
    );
  }
}

class MyPage extends StatelessWidget {
  final Account account;

  MyPage({this.account}) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Stack(
        children: <Widget>[
          ClipPath(
            child: Container(color: Colors.white.withOpacity(0.8)),
          ),
          Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: 90.0),
                SafeArea(
                  child: Container(
                  width: 150.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      image: DecorationImage(
                          image: NetworkImage(
                            account.profile_image),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.all(Radius.circular(75.0)),
                      boxShadow: [
                        BoxShadow(blurRadius: 7.0, color: Colors.grey)
                      ])),
                ),
                SizedBox(height: 90.0),
                Text(
                  account.name,
                  style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat'),
                ),
                SizedBox(height: 15.0),
                Text(
                  account.email,
                  style: TextStyle(
                      fontSize: 17.0,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Montserrat'),
                )
              ]
            )
          )
        ]
      )
    );
  }
}