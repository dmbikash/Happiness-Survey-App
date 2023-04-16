import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  StreamController<String> _streamController = StreamController<String>();
  Stream<String> get _stream => _streamController.stream;
  int count=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder<String>(
            stream: _stream,
            builder: (BuildContext context, AsyncSnapshot<String> snapshot){
            if (snapshot.hasData) {
              return Center(child: Container(color: Colors.limeAccent,height:500, width:500,child: Center(
                  child: Text(snapshot.data!,
                    style: TextStyle(fontSize: 40),))));
            }
            else {
              return Center(child: Container(color: Colors.red,height:500, width:500,child: Center(child: Text("waiting fo data",style: TextStyle(fontSize: 40),))));
            }
  },
    ),
          TextButton(onPressed: (){
            count++;
            _streamController.add('new data $count');
            String data= "new data $count";
            post_koro("vhappy", data );

          },
              child: Text("Add to Stream",style: TextStyle(fontSize: 40),)
          )
        ],
      ),
    );
  }
  Future<void> post_koro(String rat, String empID) async {
    String uri = 'http://10.0.2.2:8000/write/';
    String temp_uri = uri + rat;
    //print(rat);
    //print(temp_uri);
    try {
      final response = await http.post(
        Uri.parse(temp_uri),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "index": "0",
          "employeeID": empID,
          "rated_at": "2023-02-01T09:36:34.592Z"
        }),
      );

      if (response.statusCode == 200) {
           print("post hoise.....");
           print(response.body);
      }
      else {
        print(" problem in writing to database");
      }
    }catch(e){
      print("this is the error $e");

    }
  }
}
