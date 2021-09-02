import 'package:flutter/material.dart';

class Custom_Alert extends StatelessWidget {
  String Title;
  String Description;
  Custom_Alert({required this.Title, required this.Description});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        new Text(
          Title,
          style: TextStyle(color: Color(0XFF130925)),
        ),
      ]),
      content: new Text(
        Description,
        style: TextStyle(color: Colors.purple),
      ),
      actions: <Widget>[
        //new FlatButton(
        //child: new Text("OK",style: TextStyle(color:Color(0XFF130925)),),
        //onPressed: () {
        //Navigator.pop(context);
        //},
        //),
      ],
    );
  }
}
