import 'package:flutter/material.dart';

class AlcoholStyle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color hexToColor(String code) {
      return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
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
                  new Padding(padding: EdgeInsets.only(top: 140.0)),
                  new Text('Step2. 술타일 정보',
                  style: new TextStyle(color: Colors.black, fontSize: 25.0),),
                  new Padding(padding: EdgeInsets.only(top: 50.0)),
                  new TextFormField(
                    decoration: new InputDecoration(
                      labelText: "나이",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(
                        ),
                      ),
                      //fillColor: Colors.green
                    ),
                    validator: (val) {
                      if(val.length==0) {
                        return "Email cannot be empty";
                      }else{
                        return null;
                      }
                    },
                    keyboardType: TextInputType.number,
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                  new Padding(padding: EdgeInsets.only(top: 20.0)),
                  new TextFormField(
                    decoration: new InputDecoration(
                      labelText: "성별",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(
                        ),
                      ),
                      //fillColor: Colors.green
                    ),
                    validator: (val) {
                      if(val.length==0) {
                        return "Email cannot be empty";
                      }else{
                        return null;
                      }
                    },
                    keyboardType: TextInputType.text,
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                  new Padding(padding: EdgeInsets.only(top: 20.0)),
                  new TextFormField(
                    decoration: new InputDecoration(
                      labelText: "몸무게",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(
                        ),
                      ),
                      //fillColor: Colors.green
                    ),
                    validator: (val) {
                      if(val.length==0) {
                        return "Email cannot be empty";
                      }else{
                        return null;
                      }
                    },
                    keyboardType: TextInputType.number,
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                  new RaisedButton(
                    child: new Text(
                      'Change color'),
                    onPressed: () {
                    }
                  ),
                
                  new Expanded(
                    child: new Align(
                      alignment: Alignment.bottomCenter,
                      child: FloatingActionButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => AlcoholStyle(),
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
