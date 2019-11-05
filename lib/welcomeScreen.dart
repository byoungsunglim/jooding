import 'package:flutter/material.dart';
import 'package:jooding/basicProfile.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new WelcomeScreenState());
  }
}

class WelcomeScreenState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Material(
        child: new Container (
          padding: const EdgeInsets.all(50.0),
          color: Colors.white,
          child: new Container(
            child: new Center(
              child: new Column(
                children : [
                  new Padding(padding: EdgeInsets.only(top: 180.0)),
                  new Text("술례자님의 지갑과 건강을 지켜주는\n 첫걸음, 지금 시작해 볼까요?",
                    style: new TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                    textAlign: TextAlign.center
                  ),
                  new Expanded(
                    child: new Align(
                      alignment: Alignment.bottomCenter,
                      child: FloatingActionButton.extended(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => BasicProfile(),
                          ));
                        },
                        label: Text("Let's Go!"),
                        backgroundColor: Colors.lightBlue,
                      ),
                    ),
                  ),
                  new Padding(padding: EdgeInsets.only(bottom: 30.0)),
                ]
              ),
            )
          )
        )
      )
    );
  }
}
