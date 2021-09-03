import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Custom_Card_CircularGuage extends StatelessWidget {
  String Icon;
  String Description;
  String Unit;
  String Value;
  Custom_Card_CircularGuage(
      {required this.Icon,
      required this.Description,
      required this.Unit,
      required this.Value});
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
                    color: Color(0XFF130925),
                    //fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'CG',
                  ),
                ),
                Spacer(),
                Text(
                  Unit,
                  style: TextStyle(
                      fontSize: 18.0,
                      //fontStyle: FontStyle.italic,
                      color: Colors.purple,
                      fontFamily: 'CG',
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            //FlutterGauge(index:double.parse(Value),counterStyle : TextStyle(color: Colors.black,fontSize: 30),circleColor: Colors.green,activeColor: Colors.orange,secondsMarker: SecondsMarker.secondsAndMinute,number: Number.all,numberInAndOut: NumberInAndOut.outside,)
            SfRadialGauge(axes: <RadialAxis>[
              RadialAxis(
                  minimum: 0,
                  maximum: 100,
                  tickOffset: 28,
                  ranges: <GaugeRange>[
                    GaugeRange(
                        startValue: 0,
                        endValue: 30,
                        color: Colors.green,
                        startWidth: 15,
                        endWidth: 20),
                    GaugeRange(
                        startValue: 30,
                        endValue: 70,
                        color: Colors.orange,
                        startWidth: 20,
                        endWidth: 30),
                    GaugeRange(
                        startValue: 70,
                        endValue: 100,
                        color: Colors.red,
                        startWidth: 30,
                        endWidth: 35)
                  ],
                  pointers: <GaugePointer>[
                    NeedlePointer(
                        value: double.parse(Value),
                        tailStyle: TailStyle(width: 8, length: 0.2))
                  ],
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                        widget: Container(
                            child: Text(Value.toString(),
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold))),
                        angle: 90,
                        positionFactor: 0.8)
                  ])
            ])
          ],
        ),
      ),
    );
  }
}
