import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'home.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class Questionnaires extends StatefulWidget {
  @override
  _QuestionnairesState createState() => new _QuestionnairesState();
}

class _QuestionnairesState extends State<Questionnaires> {
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
        
    // print(_data[0]["question"]);
        
    return "Success!";
    }

  @override
  void initState() {
    super.initState();
    getData();
  }
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Swiper"),
      ),
    body:  new Swiper(
        itemBuilder: (BuildContext context,int index){
          return new ListView.builder(
              shrinkWrap: true,
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
            );
        },
        itemCount: 3,
        loop: false,
        pagination: new SwiperPagination(),
        control: new SwiperControl(
          color: Colors.transparent
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => SimpleBlocDelegate(),
          ));
        },
        child: Icon(Icons.arrow_forward),
        backgroundColor: Colors.green,
      ),
    );
  }
}
