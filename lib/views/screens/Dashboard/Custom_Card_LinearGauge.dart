import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

class Custom_Card_LinearGuage extends StatelessWidget {
  double Frequency;
  String Description;
  String Icon;
  Custom_Card_LinearGuage(
      {required this.Frequency, required this.Description, required this.Icon});
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
                    fontWeight: FontWeight.bold,
                    fontFamily: 'CG',
                  ),
                ),
                Spacer(),
                (Frequency != 0)
                    ? Container(
                        color: Colors.green,
                        padding: EdgeInsets.all(5),
                        child: Text(
                          Frequency.toString() + 'Hz',
                          style: TextStyle(
                              fontSize: 14.0,
                              //fontStyle: FontStyle.italic,
                              //color: Colors.redAccent,
                              //fontFamily: 'CG',
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    : Container()
              ],
            ),
            SizedBox(height: 15),
            FlutterSlider(
              hatchMark: FlutterSliderHatchMark(
                linesDistanceFromTrackBar: 2,
                labelsDistanceFromTrackBar: 45,
                displayLines: true,
                density: 0.1,
                labels: [
                  FlutterSliderHatchMarkLabel(percent: 0, label: Text('0')),
                  FlutterSliderHatchMarkLabel(percent: 20, label: Text('20')),
                  FlutterSliderHatchMarkLabel(percent: 40, label: Text('40')),
                  FlutterSliderHatchMarkLabel(percent: 60, label: Text('60')),
                  FlutterSliderHatchMarkLabel(percent: 80, label: Text('80')),
                  FlutterSliderHatchMarkLabel(
                      percent: 100, label: Text('100 %')),
                ],
              ),
              tooltip: FlutterSliderTooltip(
                alwaysShowTooltip: true,
              ),
              trackBar: FlutterSliderTrackBar(
                  activeTrackBarHeight: 5,
                  activeDisabledTrackBarColor: Colors.green),
              handler: FlutterSliderHandler(
                disabled: true,
                decoration: BoxDecoration(),
                child: Material(
                  type: MaterialType.card,
                  color: Colors.orange,
                  elevation: 10,
                ),
              ),
              values: [3.8],
              visibleTouchArea: false,
              min: 0,
              max: 10,
              touchSize: 15,
              disabled: true,
            ),
          ],
        ),
      ),
    );
  }
}
