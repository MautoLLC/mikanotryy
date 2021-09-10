import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class t5SfRadialGauge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return SfRadialGauge(axes: <RadialAxis>[
    //   RadialAxis(
    //       minimum: 0,
    //       maximum: 80,
    //       radiusFactor: 1,
    //       canScaleToFit: true,
    //       axisLabelStyle:
    //           GaugeTextStyle(fontWeight: FontWeight.bold, fontSize: 8),
    //       ranges: <GaugeRange>[
    //         GaugeRange(
    //             startValue: 0,
    //             endValue: 20,
    //             color: Colors.green,
    //             startWidth: 5,
    //             endWidth: 5),
    //         GaugeRange(
    //             startValue: 20,
    //             endValue: 40,
    //             color: Colors.orange,
    //             startWidth: 5,
    //             endWidth: 5),
    //         GaugeRange(
    //             startValue: 40,
    //             endValue: 80,
    //             color: Colors.red,
    //             startWidth: 5,
    //             endWidth: 10),
    //       ],
    //       pointers: <GaugePointer>[
    //         NeedlePointer(
    //             value: 90,
    //             lengthUnit: GaugeSizeUnit.factor,
    //             needleLength: 0.3,
    //             needleStartWidth: 1,
    //             needleEndWidth: 3)
    //       ],
    //       annotations: <GaugeAnnotation>[
    //         GaugeAnnotation(
    //           widget: Container(
    //               child: const Text('x100 rpm',
    //                   style:
    //                       TextStyle(fontSize: 7, fontWeight: FontWeight.bold))),
    //           angle: 90,
    //           positionFactor: 0.75,
    //         )
    //       ])
    // ]);
    return Image.asset('images/RPMHomepageIcon.png');
  }
}
