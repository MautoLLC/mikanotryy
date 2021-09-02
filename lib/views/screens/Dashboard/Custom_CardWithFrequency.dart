import 'package:flutter/material.dart';

class Custom_CardWithFrequency extends StatelessWidget {
  String Description;
  String Value;
  String Unit;
  String Icon;
  String Frequency;
  Custom_CardWithFrequency(
      {required this.Icon,
      required this.Description,
      required this.Value,
      required this.Unit,
      required this.Frequency});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: Padding(
        padding: EdgeInsets.fromLTRB(15, 10, 15, 20),
        child: Column(
          children: [
            Row(
              children: [
                Image(
                  image: AssetImage(Icon),
                  height: 40,
                  width: 40,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  Description,
                  style: TextStyle(
                    fontSize: 20.0,
                    //fontStyle: FontStyle.italic,
                    color: Color(0XFF130925),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'CG',
                  ),
                ),
                Spacer(),
                (Frequency != 0)
                    ? Container(
                        color: Colors.purple,
                        padding: EdgeInsets.all(5),
                        child: Text(
                          Frequency.toString() + 'Hz',
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                              //fontStyle: FontStyle.italic,
                              //color: Colors.redAccent,
                              //fontFamily: 'CG',
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    : Container()
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              Value + " " + Unit,
              style: TextStyle(
                fontSize: 30.0,
                color: Color(0XFF130925),
                //fontStyle: FontStyle.italic,
                //fontFamily: 'CG',
                //fontWeight: FontWeight.bold,
                //color: Colors.red
              ),
            )
          ],
        ),
      ),
    );
  }
}
