import 'package:flutter/material.dart';
import 'package:jooding/loginScreen.dart';
import 'package:jooding/welcomeScreen.dart';
import 'package:jooding/questionnaires.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:jooding/home.dart';


void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder:
          (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return new SimpleBlocDelegate();
          default:
            if (!snapshot.hasError) {
              // return snapshot.data.getBool("welcome") != null
              if (snapshot.data.getBool("login") == null) {
                return new LoginScreen();
              }
              else if (snapshot.data.getBool("welcome") == null) {
                return new WelcomeScreen();
              }
              else if (snapshot.data.getBool("questionnaires") == null) {
                return new Questionnaires();
              }
              else {
                return new SimpleBlocDelegate();
              }
            } else {
            }
        }
      },
    );
  }
}