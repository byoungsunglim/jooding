import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'kakaoLogin.dart';
import 'package:flutter_kakao_login/flutter_kakao_login.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class Profile {
  final String name;
  final String email;
  final String profile_image;
  final String kakao_id;
  final String phone;

  Profile({this.name, this.email, this.profile_image, this.kakao_id, this.phone});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      name: json['user']['name'],
      email: json['user']['email'],
      profile_image: json['user']['profile_image'],
      kakao_id: json['user']['kakao_id'],
      phone: json['user']['phone']
    );
  }
}

class _HomeState extends State<Home> {
  static Profile _userData;
  static final KakaoLogin kakao = new KakaoLogin();

  Future<Profile> getProfile() async {
    final KakaoAccountResult account = await kakao.getAccountInfo();
    final userEmail = (account.userEmail == null) ? "" : account.userEmail;
            
    var response = await http.get(
      Uri.encodeFull("https://jooding-development.herokuapp.com/users/${userEmail}"),
      headers: {
        "Content-type": "application/json",
        "charset": "utf-8"
      }
    );

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
           
      return Profile.fromJson(json.decode(Utf8Decoder().convert(response.bodyBytes)));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

  @override
  void initState() {
    super.initState();
    getProfile().then((values) {
      setState(() {
        _userData = values;
      });
    });
  }

  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Input',
      style: optionStyle,
    ),
    Scaffold(
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
                            "https://picsum.photos/id/237/200/300"),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.all(Radius.circular(75.0)),
                      boxShadow: [
                        BoxShadow(blurRadius: 7.0, color: Colors.grey)
                      ])),
                ),
                SizedBox(height: 90.0),
                Text(
                  "name",
                  style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat'),
                ),
                SizedBox(height: 15.0),
                Text(
                  "email",
                  style: TextStyle(
                      fontSize: 17.0,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Montserrat'),
                ),
                // SizedBox(height: 25.0),
                // Container(
                //     height: 30.0,
                //     width: 95.0,
                //     child: Material(
                //       borderRadius: BorderRadius.circular(20.0),
                //       shadowColor: Colors.greenAccent,
                //       color: Colors.green,
                //       elevation: 7.0,
                //       child: GestureDetector(
                //         onTap: () {},
                //         child: Center(
                //           child: Text(
                //             'Edit Name',
                //             style: TextStyle(color: Colors.white, fontFamily: 'Montserrat'),
                //           ),
                //         ),
                //       ),
                //     )),
                //     SizedBox(height: 25.0),
                // Container(
                //     height: 30.0,
                //     width: 95.0,
                //     child: Material(
                //       borderRadius: BorderRadius.circular(20.0),
                //       shadowColor: Colors.redAccent,
                //       color: Colors.red,
                //       elevation: 7.0,
                //       child: GestureDetector(
                //         onTap: () {},
                //         child: Center(
                //           child: Text(
                //             'Log out',
                //             style: TextStyle(color: Colors.white, fontFamily: 'Montserrat'),
                //           ),
                //         ),
                //       ),
                //     ))
              ],
            ))
      ],
      )
    )
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('BottomNavigationBar Sample'),
      // ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            title: Text('Input'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('My'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}