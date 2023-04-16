import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class PopupMessages{

  void exceptionInPosting(BuildContext context, var error){
    QuickAlert.show(
      //backgroundColor: Colors.red,
      barrierColor: Colors.white,
      confirmBtnColor: Color(0xFFD8063B),
      context: context,
      type: QuickAlertType.error,
      text: error.toString(),
      title: "Got Exception"
    );
  }

  void noRatings(BuildContext context){

  QuickAlert.show(
    //backgroundColor: Colors.red,
    barrierColor: Colors.white,
    confirmBtnColor: Color(0xFFD8063B),
    context: context,
    type: QuickAlertType.error,
    text: 'Please give your ratings',
  );
 }

  void noId(BuildContext context){
    QuickAlert.show(
    //backgroundColor: Colors.white,
    barrierColor: Colors.white,
    confirmBtnColor: Color(0xFF007E81),
    context: context,
    type: QuickAlertType.warning,
    text: 'Please Enter your Employee ID',
  );
}
}