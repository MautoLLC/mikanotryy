import 'package:flutter/material.dart';

class Buttons_Row extends StatelessWidget {
  String PowerOnImage;
  String PowerOffImage;
  //Sensor EngineState;
  Buttons_Row({required this.PowerOnImage, required this.PowerOffImage});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
            child: Container(
                width: 120,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage(PowerOffImage), fit: BoxFit.cover),
                  //child: Text("clickMe") // button text
                )),
            onTap: () {
              print("you clicked me");
            }),
        Spacer(),
        GestureDetector(
            child: Container(
                width: 120,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage(PowerOnImage), fit: BoxFit.cover),
                  //child: Text("clickMe") // button text
                )),
            onTap: () {
              print("you clicked me");
            }),
      ],
    );
  }
}
