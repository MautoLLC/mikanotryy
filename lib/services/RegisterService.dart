import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mymikano_app/utils/colors.dart';
import 'package:mymikano_app/views/screens/MainDashboard.dart';
import 'package:oauth2/oauth2.dart' as oauth2;

Register(String username,String firstname,String lastname,String email, String password, BuildContext context) async{

  final authorizationEndpoint =
  Uri.parse('https://dev.codepickles.com:8443/auth/realms/master/protocol/openid-connect/token');


  final identifier = 'MymikanoApp';
  final secret = '9abafef9-82fe-4360-8283-ee7d2e8b3879';

  var client = await oauth2.clientCredentialsGrant(
      authorizationEndpoint, identifier, secret);
  final url =
  Uri.parse('https://dev.codepickles.com:8443/auth/admin/realms/master/users');
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
  await client.post(url,
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
        msg: "Failed to create user ! " ,
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