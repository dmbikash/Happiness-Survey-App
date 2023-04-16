import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:http/http.dart' as http;

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  var data;
  var history = 99; // basically its a checker
  late int id;
  int count = 0;
  bool flag = false;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(.3),
          image: const DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TimerBuilder.periodic(const Duration(seconds: 1),
                  builder: (context) {
                //var data ;
                fetchLatest().then((result) {
                  id = result;
                  print("history $history");
                  if (history != id && history != 99) {
                    count = 2;
                    print("yaaaaaaaaaaaaaaaaaaaaaa");
                  }

                  //print(id.runtimeType);
                  fetch_user_info(id).then((userInfo) {
                    print("user-info-runtimetype----------${userInfo.runtimeType}");
                    print(" userinfo --$userInfo");
                    data = userInfo;
                    print("data---$data");
                    flag = true;
                    history = id;
                  });
                });

                if (flag && count == 2) {
                  //Timer.cancel();

                  Future.delayed(Duration.zero, () {
                    Navigator.pushReplacementNamed(context, "Home", arguments: {
                      "name": data["Name"],
                      "badgenumber": data["Badgenumber"]
                    });
                  });
                  //return Text('userID:' + "\n" +data.toString(),style: const TextStyle(fontSize: 40),);
                  return Text(
                    "Done",
                    style: const TextStyle(fontSize: 40),
                  );
                } else {
                  //////////////////////////////////////MAIN SCREEN WILL BE HERE
                  return Column(
                    children: [
                      Image(
                        image: AssetImage("assets/images/logo.png"),
                      ),
                      SizedBox(height: 20,),
                      Text("Happiness Survey",
                      style: GoogleFonts.poppins(
                        fontSize:w*.05,
                        fontWeight: FontWeight.w600,
                      ),
                      ),
                      SizedBox(height: 40,),
                      RichText(
                        text: TextSpan(
                          style: GoogleFonts.poppins(fontSize: w*.0309, color: Colors.black),
                          children: [
                            TextSpan(text: 'Please Scan '),
                            TextSpan(text: 'Your ID', style: TextStyle(color:Color(0xFF1FCA68) ,fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: h*.050,
                      ),
                      Image(
                        image: AssetImage("assets/images/faceID.png"),
                        fit: BoxFit.cover,
                        width: w*.1525,
                      ),
                    ],
                  );
                }
              }),
              if (true)
                TextButton(
                    onPressed: () {
                      flag = false;
                      count = 1;
                      Navigator.pushNamed(context, "Home",
                          arguments: {
                            "name": data["Name"],
                            "badgenumber": data["Badgenumber"]
                          });
                    },
                    child: Text(
                      "next",
                      style: TextStyle(fontSize: 40
                      ,color: Colors.transparent,
                      ),
                    )),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> fetchLatest() async {
    var api_data;
    //String url = 'http://10.0.2.2:8000/latest_insert';
    String url = 'http://192.168.10.57:8000/latest_insert';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      api_data = jsonDecode(response.body);
      api_data = api_data[0]["USERID"];
      print(":found---$api_data");
      //return api_data;
    } else {
      print('No Ratings Found for happy');
    }
    return api_data;
  }

  Future<dynamic> fetch_user_info(int id) async {
    var api_data;
    //String url = 'http://10.0.2.2:8000/userInfo/$id';
    String url = 'http://192.168.10.57:8000/userInfo/$id';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      api_data = jsonDecode(response.body);
      print("received api data---$api_data");
      //api_data = api_data["Name"];
      print(":found---$api_data");
      //return api_data;
    } else {
      print('No Ratings Found for happy');
    }
    return api_data;
  }
}
/*
Center(
child: Container(
width: 600,
height: 200,
color: Colors.redAccent.withOpacity(.5),
child: const Center(child: Text("Hi",style: TextStyle(fontSize: 40),))
),
),

 */
