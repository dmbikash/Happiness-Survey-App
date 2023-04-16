import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happiness_survey_android/screen/pop_up_mesages.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late BuildContext mycontext;
  late double textsize;
  PopupMessages popup = PopupMessages();

  //String uri = 'http://10.0.2.2:8000/write/';
  String uri = 'http://192.168.10.57:8000/write/';

  Future<void> post_koro(String rat, String name,String badgenumber, BuildContext context2) async {
    print(uri);
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
          "name": name,
          "employeeID":badgenumber,
          "rated_at": "2023-02-01T09:36:34.592Z"
        }),
      );

      if (response.statusCode == 200) {
        Navigator.pushReplacementNamed(context, "ThankYou");
        // QuickAlert.show(
        //   widget: Text("Thanks for your Feedback",
        //     style:TextStyle(fontSize: textsize*.06) ,),
        //   barrierColor: Colors.white,
        //   context: context,
        //   type: QuickAlertType.success,
        //   confirmBtnColor: const Color(0xFF12C06A),
        //   onConfirmBtnTap: () {
        //
        //     Future.delayed(Duration.zero, (){
        //       Navigator.pushNamedAndRemoveUntil(context, "Test2", (Route<dynamic> route) => false);
        //       print("pop $context2, $context");
        //     });
        //   },
        // );
        // employeeID.clear();
        // ratings = "";
        // in_dex = -1;
        // setState(() {});
      } else {
        print("internet/ server problem with status code${response.statusCode}");
      }
    } catch (e) {
      print("eee $e");
      popup.exceptionInPosting(context, e);
    }
  }

  final employeeID = TextEditingController();
  String ratings = "";
  int in_dex = -1;
  var routeData;

  @override
  Widget build(BuildContext context) {
    mycontext = context;
    print("build");
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    textsize=w;
    PopupMessages popup = PopupMessages();
    List<String> icon = [
      //"vhappy.png",
      "sad.png",
      "neutral.png",
      "happy.png",

      //"vsad.png"
    ];
    List<String> tableName = [ "sad","neutral","happy"];
    List<String> emojiName = [ "Sad","Neutral","Happy"];
    List<int> ratingsList = [1,2,3];
    routeData = ModalRoute.of(context)?.settings.arguments;
    print("routedata----$routeData");
  //   Map<String, String> routeData = {
  //   "name":"Bikash"
  // };
    print("ok");
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        leadingWidth: 200,
        leading: Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Image.asset("assets/images/logo.png",height: 100,),
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Container(
          height: h,
          width: w ,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                //color: Colors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome, ${routeData!["name"] != null? routeData!["name"] : "- - -" }",
                      style: GoogleFonts.poppins(
                        fontSize: w*.0423,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF252849),
                        letterSpacing: 1,
                      ),
                    ),
                    SizedBox(height: h*.024,),
                    Text(
                          "Please Give Your Feedback",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: w*.0203,
                        color: Color(0xFF1FCA68
                        ),
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  width: w * .85,
                  height: h*.45,

                  //color: Colors.yellow,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        //color: Colors.orange,
                        width: w * .8,
                        //height: h * .15,
                        child: Center(
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: 3,
                              itemBuilder: ( context, int index) {
                                return InkWell(
                                  onTap: () {
                                    print("hello${index}");
                                    post_koro(
                                        tableName[index],
                                        routeData["name"]!,
                                        routeData["badgenumber"]!,
                                        mycontext);
                                    // setState(() {
                                    //   ratings = ratingsList[index].toString();
                                    //   in_dex = index;
                                    // });
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left:w*.0254,right:w*.0254),
                                        //color: Colors.blue,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: w*.0847,
                                          child: Image.asset(
                                              "assets/images/${icon[index]}"),
                                        ),
                                      ),
                                      Text(emojiName[index],
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        fontSize: w*.0305,
                                      ),),
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ),
                    ],
                  )),
              // SizedBox(
              //   height: h * .009,
              // ),
              if (false)
                Text(
                  "${ratings}",
                  style: TextStyle(
                      fontSize: w * .04,
                      color: Colors.deepOrange,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold),
                ),
              SizedBox(
                height: h * .009,
              ),
              if (false)
                Container(
                  height: 50,
                  width: w * .6,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: employeeID,
                    decoration: const InputDecoration(
                      hintText: "Employee ID :",
                    ),
                  ),
                ),
              SizedBox(height: h * .1),
              if (false)
                Container(
                  decoration: const BoxDecoration(
                      //color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  width: w * .3,
                  height: h * .05,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.teal[400],
                    ),
                    onPressed: () {
                      if (employeeID.text == "") {
                        popup.noId(context);
                      } else if (in_dex < 0) {
                        popup.noRatings(context);
                      }
                      if (in_dex >= 0 && employeeID.text != "") {
                        print("post koro");
                        post_koro(tableName[in_dex], employeeID.text, "test", context);
                      } else {
                        print("jhamela ase");
                      }
                      //print(employeeID.text);
                    },
                    child: Text(
                      "Submit",
                      style: TextStyle(
                        fontSize: w * .05,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
