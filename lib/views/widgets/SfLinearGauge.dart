import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class t5SfLinearGauge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return LayoutBuilder(
    // builder: (BuildContext context, BoxConstraints constraints) {
    // return SfLinearGauge(
    // minimum: 120.0,
    // maximum: 200.0,
    // orientation: LinearGaugeOrientation
    // .vertical,
    // majorTickStyle: LinearTickStyle(
    // length: 10),
    // numberFormat: NumberFormat("\ °C "),
    // numberFormat: NumberFormat(
    // " # °C"),
    // axisLabelStyle: TextStyle(
    // fontSize: 8,
    // fontWeight: FontWeight.bold,
    // color: Colors.black
    // ),
    // axisTrackStyle: LinearAxisTrackStyle(
    // thickness: 15,
    // edgeStyle: LinearEdgeStyle
    // .bothCurve),
    // barPointers: [
    // LinearBarPointer(
    // value: 160,
    // Changed the thickness to make the curve visible
    // thickness: 10,
    // Updated the edge style as curve at end position
    // edgeStyle: LinearEdgeStyle
    // .bothCurve,
    // color: Colors.redAccent
    // )
    // ],
    // );
    // });
    return Image.asset('images/ThermometerHomepageIcon.png');
  }
}
