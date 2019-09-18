import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => new _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  List _data;
  List _saved = [];
  
  Future<String> getData() async {
    var response = await http.get(
      Uri.encodeFull("https://jsonplaceholder.typicode.com/posts"),
      headers: {
        "Accept": "application/json"
      }
    );

    setState(() {
    _data = jsonDecode(response.body);
    });
        
    print(_data[1]["title"]);
        
    return "Success!";
    }

  @override
  void initState() {
    super.initState();
    getData();
  }
    
  @override
  Widget build(BuildContext context){   
    return new Scaffold(
      // appBar: new AppBar(title: new Text("Listviews"), backgroundColor: Colors.blue),
      body: new ListView.builder(
        padding: EdgeInsets.all(8.0),
        itemCount: _data == null ? 0 : _data.length,
        itemBuilder: (BuildContext context, int index){
          return new CheckboxListTile(
            title: new Text(_data[index]["title"]),
            value: _saved.contains(index),
            onChanged: (val) {
              setState(() {
                if (_saved.contains(index)) {
                  _saved.remove(index);
                }
                else {
                  _saved.add(index);
                }
              });
            },
          );
        },
      ),
    );
  }
}