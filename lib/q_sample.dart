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
        
    print(_data[0]["question"]);
        
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
      body: SafeArea(
        bottom: false,
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Container(
            height: 100,
            padding: const EdgeInsets.all(8.0),
            color: Colors.blue[600],
            alignment: Alignment.center,
            child: Text('일주일에 몇 번 음주를 하십니까?',
            textScaleFactor: 0.8,
              style: Theme.of(context)
                  .textTheme
                  .display1
                  .copyWith(color: Colors.white)),
          ),
          Expanded(
            child: new ListView.builder(
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
            ),
          )
        ]
        )
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
