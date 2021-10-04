import 'package:flutter/material.dart';

class Card_ImageTitleTime extends StatelessWidget {
  //const Card_ImageTitleTime({Key key}) : super(key: key);
  Card_ImageTitleTime(
      {required this.ImagePath,
      required this.Title,
      required this.Hours,
      required this.Minutes,
      required this.Headerh,
      required this.Headerm});
  String ImagePath;
  String Title;
  String Hours;
  String Minutes;
  String Headerh;
  String Headerm;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
          child: Row(
            children: [
              Image.asset(
                ImagePath,
                height: 40,
                width: 40,
              ),
              SizedBox(
                width: 15,
              ),
              FittedBox(
                        fit: BoxFit.fitWidth, 
                child: Text(
                  Title,
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0),
                ),
              ),
              Spacer(),
              Column(
                children: [
                  Text(
                    Hours,
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0),
                  ),
                  Text(
                    Headerh,
                    style: TextStyle(fontFamily: 'Roboto', fontSize: 10.0),
                  )
                ],
              ),
              VerticalDivider(),
              Column(
                children: [
                  Text(
                    Minutes,
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0),
                  ),
                  Text(
                    Headerm,
                    style: TextStyle(fontFamily: 'Roboto', fontSize: 10.0),
                  )
                ],
              )
            ],
          )),
    );
  }
}
