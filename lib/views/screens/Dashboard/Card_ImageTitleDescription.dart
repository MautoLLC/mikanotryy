import 'package:flutter/material.dart';

class Card_ImageTitleDescription extends StatelessWidget {
  //const Card_ImageTitleDescription({Key key}) : super(key: key);
  String ImagePath;
  String Title;
  String Description;
  Card_ImageTitleDescription(
      {required this.ImagePath,
      required this.Title,
      required this.Description});
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
            //SizedBox(width: 5,),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                Text(
                  Description,
                  style: TextStyle(fontFamily: 'Roboto', fontSize: 10.0),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
