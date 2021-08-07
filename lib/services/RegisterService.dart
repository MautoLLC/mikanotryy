import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/utils/colors.dart';
import 'package:mymikano_app/views/screens/MainDashboard.dart';
import 'package:oauth2/oauth2.dart' as oauth2;

Register(String username,String firstname,String lastname,String email, String password, BuildContext context) async{

  var client = await oauth2.clientCredentialsGrant(
      Uri.parse(authorizationEndpoint), identifier, secret);


  final body =  {
    'username':username,
    'enabled': true,
    'firstName':firstname,
    'lastName':lastname,
    'email':email,
    'credentials':[{"type":"password","value":password,"temporary":false}]
  };

  var response =
  //await client.read('https://example.com/api/some_resource.json');
  await client.post(Uri.parse(RegisterUserURL),
      body: json.encode(body),
      headers:  {'Content-type': 'application/json',}
  );

  print(client.credentials.toJson());

  if (response.statusCode == 201) {

    Fluttertoast.showToast(
        msg: "User created successfully ! " ,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: t13_edit_text_color ,
        textColor: Colors.black87,
        fontSize: 16.0
    );
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Theme5Dashboard()),
    );
   // print("created successfully");


  } else {

    Fluttertoast.showToast(
        msg: "Failed to create user ! " +response.body.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: t13_edit_text_color ,
        textColor: Colors.black87,
        fontSize: 16.0
    );
    //print("failed to create user");
  }


}