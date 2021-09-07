import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Custom_Card_CircularGuage extends StatelessWidget {
  String Title;
  String Unit;
  String Value;
  Custom_Card_CircularGuage(
      {required this.Title, required this.Unit, required this.Value});
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
                Text(
                  Title,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                    //fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            //FlutterGauge(index:double.parse(Value),counterStyle : TextStyle(color: Colors.black,fontSize: 30),circleColor: Colors.green,activeColor: Colors.orange,secondsMarker: SecondsMarker.secondsAndMinute,number: Number.all,numberInAndOut: NumberInAndOut.outside,)
            SfRadialGauge(axes: <RadialAxis>[
              //RadialAxis(minimum: 0,maximum: 100,tickOffset: 28,
              RadialAxis(
                  minimum: 0,
                  maximum: 100,
                  interval: 10,
                  ticksPosition: ElementsPosition.outside,
                  labelsPosition: ElementsPosition.outside,
                  minorTicksPerInterval: 5,
                  radiusFactor: 0.9,
                  labelOffset: 15,
                  minorTickStyle: MinorTickStyle(
                      thickness: 1.5,
                      color: Color.fromARGB(255, 143, 20, 2),
                      length: 0.07,
                      lengthUnit: GaugeSizeUnit.factor),
                  majorTickStyle: MinorTickStyle(
                    thickness: 1.5,
                    color: Color.fromARGB(255, 143, 20, 2),
                    length: 0.15,
                    lengthUnit: GaugeSizeUnit.factor,
                  ),
                  axisLineStyle: AxisLineStyle(
                    thickness: 3,
                    color: Color.fromARGB(255, 143, 20, 2),
                  ),
                  axisLabelStyle: GaugeTextStyle(
                    fontSize: 12,
                    color: Color.fromARGB(255, 143, 20, 2),
                  ),
                  ranges: <GaugeRange>[
                    GaugeRange(
                        startValue: 0,
                        endValue: 30,
                        color: Colors.grey[400],
                        startWidth: 10,
                        endWidth: 10),
                    GaugeRange(
                        startValue: 30,
                        endValue: 70,
                        color: Colors.orange,
                        startWidth: 10,
                        endWidth: 10),
                    GaugeRange(
                        startValue: 70,
                        endValue: 100,
                        color: Colors.red,
                        startWidth: 10,
                        endWidth: 10)
                  ],
                  pointers: <GaugePointer>[
                    NeedlePointer(
                        value: double.parse(Value),
                        needleStartWidth: 2,
                        needleEndWidth: 2,
                        needleColor: Colors.red,
                        knobStyle: KnobStyle(
                            knobRadius: 5,
                            sizeUnit: GaugeSizeUnit.logicalPixel,
                            color: Colors.red))
                  ],
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                        widget: Container(
                            child: Text(Value.toString(),
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Roboto',
                                    color: Colors.red[900]))),
                        angle: 90,
                        positionFactor: 0.8)
                  ])
            ]),
            Text('RPM* 100',
                style:
                    TextStyle(fontFamily: 'Roboto', color: Colors.grey[400])),
          ],
        ),
      ),
    );
  }
}
