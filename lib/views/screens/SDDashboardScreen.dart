import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mymikano_app/models/DashboardCardModel.dart';
import 'package:mymikano_app/views/widgets/AppWidget.dart';
import 'package:nb_utils/nb_utils.dart';

import 'SDExamScreen.dart';

class SDDashboardScreen extends StatefulWidget {


  @override
  _SDDashboardScreenState createState() => _SDDashboardScreenState();
}

class _SDDashboardScreenState extends State<SDDashboardScreen> {

  List<SDExamCardModel> cards = [
    SDExamCardModel(
      image: 'images/smartDeck/images/sdbiology.png',
      examName: 'Biology final\nexams',
      //   time: '15 minutes',
      //  icon: Icon(Icons.notifications_active, color: Colors.white54),
      startColor: Color(0xFF2889EB),
      endColor: Color(0xFF0B56CB),
    ),
    SDExamCardModel(
      image: 'images/smartDeck/images/sdchemistry.png',
      examName: 'Chemistry daily\ntest',
      //  time: '15 minutes',
      // icon: Icon(Icons.notifications_off, color: Colors.white54),
      startColor: Color(0xFFF1AD4B),
      endColor: Color(0xFFF26340),
    ),
    SDExamCardModel(
      image: 'images/smartDeck/images/sdmusic.png',
      examName: 'Music daily\nlearning',
      // time: '3 hours',
      //icon: Icon(Icons.notifications, color: Colors.white54),
      startColor: Color(0xFF7EA56C),
      endColor: Color(0xFF6C9258),
    )
  ];
  @override
  Widget build(BuildContext context) {

    return Container(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(top: 20, bottom: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: boxDecoration(radius: 5,),
                      child: TextField(
                        autofocus: false,
                        readOnly: true,
                        onTap: () {
                          //  SDSearchScreen().launch(context);
                        },
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search',
                          prefixIcon: Icon(Icons.search, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        padding: EdgeInsets.only(left: 10, top: 5, right: 15),
                        child: InkWell(
                          onTap: () {
                            //  SDNotificationScreen().launch(context);
                          },
                          child: Icon(
                              Icons.notifications_none, size: 30, color: Colors
                              .black),
                        ),
                      ),
                      Positioned(
                        right: 9,
                        top: 0,
                        child: CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.red,
                          child: Text('3', style: secondaryTextStyle(
                              color: Colors.white)),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 25),
            Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              child: Text('Hi, Mark', style: boldTextStyle(size: 20)),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              child: Text('You have 3 exams pending',
                  style: secondaryTextStyle(size: 14)),
            ),
            SizedBox(height: 15),
            Container(
              height: 250,
              child: ListView.builder(
                padding: EdgeInsets.only(right: 16),
                scrollDirection: Axis.horizontal,
                itemCount: cards.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      SDExamScreen(cards[index].examName, cards[index].image,
                          cards[index].startColor, cards[index].endColor)
                          .launch(context);
                    },
                    child: Container(
                      width: 180.0,
                      margin: EdgeInsets.only(left: 16),
                      padding: EdgeInsets.all(10),
                      decoration: boxDecoration(
                        radius: 8,
                        // spreadRadius: 1,
                        // blurRadius: 4,
                        // gradient: LinearGradient(colors: [cards[index].startColor!, cards[index].endColor!]),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.white30,
                            child: Image.asset(
                                cards[index].image!, height: 60, width: 60),
                          ),
                          SizedBox(height: 15),
                          Text(cards[index].examName!,
                              style: secondaryTextStyle(
                                  color: Colors.white, size: 20)),
                          SizedBox(height: 15),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(cards[index].time!,
                                    style: secondaryTextStyle(
                                        color: Colors.white54, size: 18)),
                                cards[index].icon!,
                              ]),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),


          ],
        ),
      ),
    );
  }


}