import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mymikano_app/models/QiBusModel.dart';
import 'package:mymikano_app/utils/QiBusColors.dart';
import 'package:mymikano_app/utils/QiBusConstant.dart';
import 'package:mymikano_app/utils/QiBusImages.dart';
import 'package:mymikano_app/utils/QiBusStrings.dart';
import 'package:mymikano_app/utils/colors.dart';
import 'package:mymikano_app/utils/AppWidget.dart';


class Booking extends StatefulWidget {
  final QIBusBookingModel model;

  Booking(this.model);

  @override
  BookingState createState() => new BookingState(model);
}

class BookingState extends State<Booking> {

  late QIBusBookingModel model;

  void _changed() {
    setState(() {

    });
  }

  BookingState(QIBusBookingModel model) {
    this.model = model;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(


      padding: EdgeInsets.all(spacing_middle),
      decoration: boxDecoration(showShadow: true, bgColor: Colors.blue ,radius: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(spacing_middle),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ticketInfo(QIBus_text_technician, model.technician,Colors.white70),
                          ticketInfo(QIBus_text_start_time, model.duration,Colors.white70),
                          ticketInfo(QIBus_text_duration, model.comments,Colors.white70),
                          ticketInfo(QIBus_text_Comments, model.startTime,Colors.white70),
                        ],
                      ),
                    ),
                    // Expanded(
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );

  }
}
Widget ticketInfo(var label, var value ,Color color) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Expanded(
        child: text(label),
        flex: 2,
      ),
      Expanded(
        child: text(value.toString(), textColor: color , maxLine: 10),
        flex: 3,
      ),
    ],
  );
}