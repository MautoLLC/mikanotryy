import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mymikano_app/models/QiBusModel.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/utils/strings.dart';
import 'package:mymikano_app/utils/colors.dart';
import 'package:mymikano_app/views/widgets/AppWidget.dart';

class Booking extends StatefulWidget {
  final QIBusBookingModel model;
  String categoryName;
  Booking(this.model, this.categoryName);

  @override
  BookingState createState() => new BookingState(model);
}

class BookingState extends State<Booking> {
  late QIBusBookingModel model;

  void _changed() {
    setState(() {});
  }

  BookingState(QIBusBookingModel model) {
    this.model = model;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(spacing_middle),
      // .limeAccent
      // yellow
      // deepOrange
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(blurRadius: 10, color: Colors.black26, offset: Offset(3, 3))
        ],
        border: Border.all(
          color: Colors.white70,
          width: 1.0,
        ),
        borderRadius: BorderRadius.all(
            Radius.circular(24.0) //                 <--- border radius here
            ),
        color: Colors.white,
      ),
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
                          ticketInfo(
                              "Category :", widget.categoryName, Colors.black87,
                              col: t5Cat3),
                          ticketInfo(text_start_time + " :", model.duration,
                              Colors.black87,
                              col: t5Cat3),
                          ticketInfo(text_duration + " :", model.comments,
                              Colors.black87,
                              col: t5Cat3),
                          ticketInfo(text_Comments + " :", model.startTime,
                              Colors.black87,
                              col: t5Cat3),
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

Widget ticketInfo(var label, var value, Color color, {Color? col}) {
  String val = "";
  if (value == "")
    val = "N/A";
  else
    val = value.toString();
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Expanded(
        child: text(label, textColor: col),
        flex: 2,
      ),
      Expanded(
        child: text(val.toString(), textColor: color, maxLine: 10),
        flex: 3,
      ),
    ],
  );
}
