import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happiness_survey_android/screen/welcome_screen.dart';

class ThankYou extends StatefulWidget {
  const ThankYou({Key? key}) : super(key: key);

  @override
  State<ThankYou> createState() => _ThankYouState();
}

class _ThankYouState extends State<ThankYou> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
      );
    });
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        leadingWidth: 200,
        leading: Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Image.asset("assets/images/logo.png",width: w*.084,),
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Container(
          height: 500,
          //color: Colors.red,
          //width: 400,
          //duration: Duration(seconds: 3),
          child: Column(
            children: [
              Image(image: AssetImage("assets/images/feedback.png")),
              SizedBox(height: 40,),
              Text("Thanks For Your Feedback",
              style: GoogleFonts.poppins(
                fontSize: w*.0423,
                fontWeight: FontWeight.w600,
                color: Color(0xFF252849),
               ),
              ),
              SizedBox(height: 80,),



              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF00539B),
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5), // rounded corner radius
                    ),
                    minimumSize: Size(w*.1355, h*.052),

                  ),
                  onPressed: (){Navigator.pushReplacementNamed(context, "WelcomeScreen");}, child: Text("OK",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: w*.025,
              ),),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
