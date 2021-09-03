import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
class Sliders_Section extends StatelessWidget {
  String OilValue;
  String CoolantValue;
  String FuelValue;
  Sliders_Section({required this.OilValue,required this.CoolantValue,required this.FuelValue});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.fromLTRB(15, 10, 15, 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image:AssetImage('assets/oilpressure.png'),
                  height: 40,
                  width: 40,),
                SizedBox(width: 5,),
                Text('Oil Pressure',style: TextStyle(color:Color(0XFF130925),fontWeight: FontWeight.bold,fontSize:20.0,fontFamily: 'CG'),),
              ],
            ),
            SizedBox(height: 10,),
            Divider(color: Colors.orange,),
          SizedBox(height: 5,),
            // FlutterSlider(
            //   hatchMark: FlutterSliderHatchMark(
            //     linesDistanceFromTrackBar: 2,
            //     labelsDistanceFromTrackBar: 50,
            //     displayLines: true,
            //     density:0.1,
            //     labels: [
            //       FlutterSliderHatchMarkLabel(percent: 0, label: Text('0')),
            //       FlutterSliderHatchMarkLabel(
            //           percent: 20, label: Text('2')),
            //       FlutterSliderHatchMarkLabel(percent: 40, label: Text('4')),
            //       FlutterSliderHatchMarkLabel(
            //           percent: 60, label: Text('6')),
            //       FlutterSliderHatchMarkLabel(
            //           percent: 80, label: Text('8')),
            //       FlutterSliderHatchMarkLabel(
            //           percent: 100, label: Text('10 Bar')),
            //     ],
            //   ),
            //   tooltip: FlutterSliderTooltip(
            //     alwaysShowTooltip: true,
            //   ),
            //   trackBar: FlutterSliderTrackBar(
            //       activeTrackBarHeight: 8,
            //       activeDisabledTrackBarColor: Colors.green,
            //     activeTrackBar: BoxDecoration(
            //         borderRadius: BorderRadius.circular(4),
            //         color: Colors.blue.withOpacity(0.5)
            //     ),
            //   ),
            //   handler: FlutterSliderHandler(
            //     disabled: true,
            //     decoration: BoxDecoration(
            //     ),
            //     child: Material(
            //       type: MaterialType.card,
            //       color: Colors.orange,
            //       elevation: 10,
            //
            //     ),
            //   ),
            //   values:[double.parse(OilValue)],
            //   visibleTouchArea: false,
            //   min: 0,
            //   max: 10,
            //   touchSize: 15,
            //   disabled: true,
            // ),
        SfLinearGauge(
          minimum: 0,
          maximum: 10,
            ranges: <LinearGaugeRange>[
              //First range
              LinearGaugeRange(startValue: 0, endValue: 4, color: Colors.green),
              //Second range
              LinearGaugeRange(startValue: 4, endValue: 10, color: Colors.red)
            ],
          axisTrackStyle: LinearAxisTrackStyle(
              thickness: 10
          ),
          markerPointers: [
            LinearShapePointer(
                value: double.parse(OilValue),
                shapeType: LinearShapePointerType.invertedTriangle,
                position: LinearElementPosition.cross,
                onValueChanged: (value) {
                  // setState(() {
                  //   widgetPointerValue = value;
                  // });
                },
                // color: double.parse(OilValue) <= 4
                //     ? Colors.green
                //     : double.parse(OilValue) < 7
                //     ? Colors.orange
                //     : Colors.red
            ),
            LinearWidgetPointer(
              value: double.parse(OilValue),
              onValueChanged: (value) {
                // setState(() {
                //   widgetPointerValue = value;
                // });
              },
              child: Container(
                width: 55,
                height: 45,
                child: Center(
                  child: Text(
                    double.parse(OilValue).toStringAsFixed(0)+" bar",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: double.parse(OilValue) <= 4
                            ? Colors.green
                            : double.parse(OilValue) < 7
                            ? Colors.orange
                            : Colors.red
                    ),
                  ),
                ),
              ),
              position: LinearElementPosition.outside,
            ),
          ],

        ),
            SizedBox(height: 35,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image:AssetImage('assets/temp.png'),
                  height: 40,
                  width: 40,),
                SizedBox(width: 5,),
                Text('Coolant Temp',style: TextStyle(color:Color(0XFF130925),fontWeight: FontWeight.bold,fontSize:20.0,fontFamily: 'CG'),),
              ],
            ),
            //Text('Coolant Temp',style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize:20.0,fontFamily: 'CG'),),
            SizedBox(height: 10,),
            Divider(color:Colors.orange),
            SizedBox(height: 5,),
            // FlutterSlider(
            //   hatchMark: FlutterSliderHatchMark(
            //     linesDistanceFromTrackBar: 2,
            //     labelsDistanceFromTrackBar: 50,
            //     displayLines: true,
            //     density:0.1,
            //     labels: [
            //       FlutterSliderHatchMarkLabel(percent: 0, label: Text('-16')),
            //       FlutterSliderHatchMarkLabel(
            //           percent: 20, label: Text('11')),
            //       FlutterSliderHatchMarkLabel(percent: 40, label: Text('38')),
            //       FlutterSliderHatchMarkLabel(
            //           percent: 60, label: Text('66')),
            //       FlutterSliderHatchMarkLabel(
            //           percent: 80, label: Text('93')),
            //       FlutterSliderHatchMarkLabel(
            //           percent: 100, label: Text('120 °C')),
            //       // FlutterSliderHatchMarkLabel(
            //       //     percent: 120, label: Text('120 °C')),
            //     ],
            //   ),
            //   tooltip: FlutterSliderTooltip(
            //     alwaysShowTooltip: true,
            //   ),
            //   trackBar: FlutterSliderTrackBar(
            //       activeTrackBarHeight: 8,
            //       activeDisabledTrackBarColor: Colors.green,
            //     activeTrackBar: BoxDecoration(
            //         borderRadius: BorderRadius.circular(4),
            //         color: Colors.blue.withOpacity(0.5)
            //     ),
            //   ),
            //   handler: FlutterSliderHandler(
            //     disabled: true,
            //     decoration: BoxDecoration(
            //     ),
            //     child: Material(
            //       type: MaterialType.card,
            //       color: Colors.orange,
            //       elevation: 10,
            //
            //     ),
            //   ),
            //   values: [double.parse(CoolantValue)],
            //   visibleTouchArea: false,
            //   min: -16,
            //   max: 120,
            //   touchSize: 15,
            //   disabled: true,
            // ),
            SfLinearGauge(
              minimum: -16,
              maximum: 120,
              ranges: <LinearGaugeRange>[
                //First range
                LinearGaugeRange(startValue: -16, endValue: 66, color: Colors.green),
                //Second range
                LinearGaugeRange(startValue: 66, endValue: 93, color: Colors.orange),
                LinearGaugeRange(startValue: 93, endValue: 120, color: Colors.red)

              ],
              axisTrackStyle: LinearAxisTrackStyle(
                  thickness: 10
              ),
              markerPointers: [
                LinearShapePointer(
                  value: double.parse(CoolantValue),
                  shapeType: LinearShapePointerType.invertedTriangle,
                  position: LinearElementPosition.cross,
                  onValueChanged: (value) {
                    // setState(() {
                    //   widgetPointerValue = value;
                    // });
                  },
                  // color: double.parse(OilValue) <= 4
                  //     ? Colors.green
                  //     : double.parse(OilValue) < 7
                  //     ? Colors.orange
                  //     : Colors.red
                ),
                LinearWidgetPointer(
                  value: double.parse(CoolantValue),
                  onValueChanged: (value) {
                    // setState(() {
                    //   widgetPointerValue = value;
                    // });
                  },
                  child: Container(
                    width: 55,
                    height: 45,
                    child: Center(
                      child: Text(
                        double.parse(CoolantValue).toStringAsFixed(0)+" °C",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: double.parse(CoolantValue) <= 66
                                ? Colors.green
                                : double.parse(CoolantValue) < 93
                                ? Colors.orange
                                : Colors.red
                        ),
                      ),
                    ),
                  ),
                  position: LinearElementPosition.outside,
                ),
              ],

            ),

            SizedBox(height: 35,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image:AssetImage('assets/fuellevel.png'),
                  height: 40,
                  width: 40,),
                SizedBox(width: 5,),
                Text('Fuel Level',style: TextStyle(color:Color(0XFF130925),fontWeight: FontWeight.bold,fontSize:20.0,fontFamily: 'CG'),),
              ],
            ),            SizedBox(height: 10,),
            Divider(color: Colors.orange,),
            SizedBox(height: 5,),
            // FlutterSlider(
            //   hatchMark: FlutterSliderHatchMark(
            //     linesDistanceFromTrackBar: 2,
            //     labelsDistanceFromTrackBar: 50,
            //     displayLines: true,
            //     density:0.1,
            //     labels: [
            //       FlutterSliderHatchMarkLabel(percent: 0, label: Text('0')),
            //       FlutterSliderHatchMarkLabel(
            //           percent: 20, label: Text('20')),
            //       FlutterSliderHatchMarkLabel(percent: 40, label: Text('40')),
            //       FlutterSliderHatchMarkLabel(
            //           percent: 60, label: Text('60')),
            //       FlutterSliderHatchMarkLabel(
            //           percent: 80, label: Text('80')),
            //       FlutterSliderHatchMarkLabel(
            //           percent: 100, label: Text('100 %')),
            //     ],
            //   ),
            //   tooltip: FlutterSliderTooltip(
            //     alwaysShowTooltip: true,
            //   ),
            //   trackBar: FlutterSliderTrackBar(
            //       activeTrackBarHeight: 8,
            //       activeDisabledTrackBarColor: Colors.green,
            //     activeTrackBar: BoxDecoration(
            //         borderRadius: BorderRadius.circular(4),
            //         color: Colors.blue.withOpacity(0.5)
            //     ),
            //   ),
            //   handler: FlutterSliderHandler(
            //     disabled: true,
            //     decoration: BoxDecoration(
            //     ),
            //     child: Material(
            //       type: MaterialType.card,
            //       color: Colors.orange,
            //       elevation: 10,
            //
            //     ),
            //   ),
            //   values:[double.parse(FuelValue)],
            //   visibleTouchArea: false,
            //   min: 0,
            //   max: 100,
            //   touchSize: 15,
            //   disabled: true,
            // ),
            SfLinearGauge(
              minimum: 0,
              maximum: 100,
              ranges: <LinearGaugeRange>[
                //First range
                LinearGaugeRange(startValue:0, endValue: 100, color: Colors.green),
                //Second range
                //LinearGaugeRange(startValue: 66, endValue: 93, color: Colors.orange),
                //LinearGaugeRange(startValue: 93, endValue: 120, color: Colors.red)

              ],
              axisTrackStyle: LinearAxisTrackStyle(
                  thickness: 10
              ),
              markerPointers: [
                LinearShapePointer(
                  value: double.parse(FuelValue),
                  shapeType: LinearShapePointerType.invertedTriangle,
                  position: LinearElementPosition.cross,
                  onValueChanged: (value) {
                    // setState(() {
                    //   widgetPointerValue = value;
                    // });
                  },
                  // color: double.parse(OilValue) <= 4
                  //     ? Colors.green
                  //     : double.parse(OilValue) < 7
                  //     ? Colors.orange
                  //     : Colors.red
                ),
                LinearWidgetPointer(
                  value: double.parse(FuelValue),
                  onValueChanged: (value) {
                    // setState(() {
                    //   widgetPointerValue = value;
                    // });
                  },
                  child: Container(
                    width: 55,
                    height: 45,
                    child: Center(
                      child: Text(
                        double.parse(FuelValue).toStringAsFixed(0)+" %",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color:Colors.green
                        ),
                      ),
                    ),
                  ),
                  position: LinearElementPosition.outside,
                ),
              ],

            ),

          ],
        ),
      ),
    );
  }
}
