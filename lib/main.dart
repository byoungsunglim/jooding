import 'package:flutter/material.dart';
import 'package:jooding/loginScreen.dart';

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
              return snapshot.data.getBool("welcome") != null
                  ? new SimpleBlocDelegate()
                  : new LoginScreen();
            } else {
            }
        }
      },
    );
  }
}