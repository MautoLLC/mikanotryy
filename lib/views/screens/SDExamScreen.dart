import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mymikano_app/views/widgets/AppWidget.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/utils/strings.dart';
import 'package:mymikano_app/views/widgets/T13Widget.dart';
import 'package:mymikano_app/utils/colors.dart';
// import 'package:prokit_flutter/main/utils/Lipsum.dart' as lipsum;
import 'package:nb_utils/nb_utils.dart';
// import 'package:prokit_flutter/main/utils/AppWidget.dart';
// import 'package:prokit_flutter/smartDeck/SDUtils/SDColors.dart';
// import 'package:prokit_flutter/smartDeck/SDUtils/SDStyle.dart';

// ignore: must_be_immutable
class SDExamScreen extends StatefulWidget {
  String? name;
  String? image;
  Color? startColor;
  Color? endColor;

  SDExamScreen([this.name, this.image, this.startColor, this.endColor]);

  @override
  _SDExamScreenState createState() => _SDExamScreenState();
}

class _SDExamScreenState extends State<SDExamScreen> {
  late var text;

  @override
  // ignore: must_call_super
  void initState() {
    text =
        "helloooooooooooooooooooooooooooooooooooooo kjjjjjjjjjjjjjjjjs9ojs9sk ijs9sssijiajsixjaiOax";
    // lipsum.createText(numParagraphs: 1, numSentences: 5);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //changeStatusColor(widget.startColor!);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [widget.startColor!, widget.endColor!],
          ),
        ),
        height: size.height,
        width: size.width,
        padding: EdgeInsets.only(top: 25, left: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: CloseButton(color: Colors.black),
            ),
            Container(
              margin: EdgeInsets.only(top: 50, left: 16),
              child: CircleAvatar(
                backgroundColor: t13_edit_text_color,
                child: Image.asset(widget.image!, height: 60, width: 60),
                radius: 40,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.only(left: 16),
              child: Text(
                widget.name!,
                style: boldTextStyle(color: Colors.black, letterSpacing: 0.2),
              ),
            ),

            Expanded(
              child:
                  // Container(
                  //   margin: EdgeInsets.only(top: 25),
                  //   padding: EdgeInsets.only(left: 15, right: 15),
                  //   child: Text(
                  //     text,
                  //     style: secondaryTextStyle(size: 14, color: Colors.black.withOpacity(0.5)),
                  //   ),
                  // ),
                  Container(
                decoration:
                    boxDecoration(bgColor: t13_edit_text_color, radius: 30.0),
                padding: EdgeInsets.all(spacing_standard_new),

                child: Text(
                  text,
                  style: secondaryTextStyle(
                      size: 14, color: Colors.black.withOpacity(0.5)),
                ),
                // SizedBox(height:30),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              child: T13Button(
                textContent: t13_lbl_proceed,
                onPressed: () {
                  // p.animateToPage(2, duration: Duration(seconds: 1), curve: Curves.linear);
                },
              ),
            ),

            // Container(
            //   alignment: Alignment.bottomCenter,
            //   margin: EdgeInsets.only(top: 25, bottom: 25),
            //   padding: EdgeInsets.only(left: 15, right: 15),
            //   child: InkWell(
            //     onTap: () {
            //       //SDExamDetailsScreen().launch(context);
            //     },
            //     child: FittedBox(
            //       child: Container(
            //         margin: EdgeInsets.only(top: 20),
            //         padding: EdgeInsets.fromLTRB(10, 4, 10, 4),
            //         decoration: boxDecoration(radius: 4),
            //         child: Center(
            //           child: Text('Start Exam', style: boldTextStyle(size: 12, color: Colors.black)),
            //         ),
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
