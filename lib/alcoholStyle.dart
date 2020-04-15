import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jooding/home.dart';

class MyButtonModal {
  String buttonText;
  Color buttonColor;

  MyButtonModal({this.buttonText, this.buttonColor});
}

class AlcoholStyle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new _AlcoholStyle(),
    );
  }
}

class _AlcoholStyle extends StatefulWidget {
  @override
  _AlcoholStyleState createState() => _AlcoholStyleState();
}

class _AlcoholStyleState extends State<_AlcoholStyle> {
  List<MyButtonModal> _buttonList = new List();
  List _data = new List();
  bool init = false;
  
  Future<List> getData() async {
    var response = await http.get(
      Uri.encodeFull("https://jsonplaceholder.typicode.com/posts"),
      headers: {
        "Accept": "application/json"
      }
    );

    // setState(() {
    _data = jsonDecode(response.body);
    //   for (var i = 0; i < 10; i++) {
    //     _buttonList.add(MyButtonModal(buttonText:_data[i]['title'], buttonColor: Colors.black));
    //     print(_data[i]);
    //   }
    // });
        
    return _data;
    }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    if (!init) {  
      return new FutureBuilder(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return MaterialApp(
              home: new Material(
                child: new Container (
                  padding: const EdgeInsets.all(50.0),
                  color: Colors.white,
                  child: new Container(
                    child: new Center(
                      child: new CircularProgressIndicator()
                    )
                  )
                )
              )
            );
          default:
            if (snapshot.hasError)
              return new Text('Error: ${snapshot.error}');
            else
              return createListView(context, snapshot);
        }
      },
    );
    }
    else {
      return createListView(context, null);
    }

    // return new Scaffold(
    //   body: futureBuilder,
    // );
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    if (!init) {
      _data = snapshot.data;
      for (var i = 0; i < 5; i++) {
        // print("###");
        // print(_data[i]['title']);
        _buttonList.add(MyButtonModal(buttonText:_data[i]['title'], buttonColor: Colors.black));
      }
      init = true;
    }
    
    return MaterialApp(
      home: new Material(
        child: new Container (
          padding: const EdgeInsets.all(50.0),
          color: Colors.white,
          child: new Container(
            child: new Center(
              child: new Column(
                children : [
                  new ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.all(8.0),
                    itemCount: _buttonList == null ? 0 : _buttonList.length,
                    itemBuilder: (BuildContext context, int index){
                      return new InkWell(
                          child: Container(
                              decoration: BoxDecoration(
                                  color: _buttonList[index].buttonColor,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Color(0xffaaaaaa))),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Center(
                                child: Text(_buttonList[index].buttonText,
                                style: new TextStyle(color: Colors.white),),
                              )),
                          onTap: () {
                            setState(() {
                              _buttonList[index].buttonColor = Colors.yellow;
                            });
                          },
                      );
                    },
                  ),
                  new Expanded(
                    child: new Align(
                      alignment: Alignment.bottomCenter,
                      child: FloatingActionButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => SimpleBlocDelegate(),
                          ));
                        },
                        child: Icon(Icons.arrow_forward),
                        backgroundColor: Colors.lightBlue,
                      ),
                    ),
                  ),
                  new Padding(padding: EdgeInsets.only(bottom: 30.0)),
                ]
              )
            ),
          )
        )
      )
    );
  }
}