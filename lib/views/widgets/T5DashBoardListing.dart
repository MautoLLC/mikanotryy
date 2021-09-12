import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:html/dom.dart';
import 'package:mymikano_app/models/DashboardCardModel.dart';
import 'package:mymikano_app/utils/AppWidget.dart';
import 'package:mymikano_app/utils/colors.dart';
import 'package:mymikano_app/utils/auto_size_text/auto_size_text.dart';
import 'package:mymikano_app/views/screens/WebViewScreen.dart';
import 'package:sizer/sizer.dart';

import '../../../main.dart';

// ignore: must_be_immutable
class T5DashBoardListing extends StatelessWidget {
  List<T5Category>? mFavouriteList;
  var isScrollable = false;

  T5DashBoardListing(this.mFavouriteList, this.isScrollable);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics:
            isScrollable ? ScrollPhysics() : NeverScrollableScrollPhysics(),
        itemCount: mFavouriteList!.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WebView(
                          Title: mFavouriteList!.elementAt(index).name,
                          Url:
                              "https://mikanoshop.mauto.co/${mFavouriteList!.elementAt(index).name}",
                        )),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(color: Color(0xffededed), width: 2.0))),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 9.0, 8.0, 9.0),
                child: Row(
                  children: [
                    Image.asset(
                      mFavouriteList![index].icon,
                      color: Color(0xff7b7b7b),
                      width: 30,
                      height: 30,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    SelectableText(mFavouriteList![index].name,
                        style: TextStyle(color: Color(0xff7b7b7b))),
                    Spacer(),
                    Icon(Icons.keyboard_arrow_right, color: Color(0xffc3c1c1))
                  ],
                ),
              ),
            ),
          );
        });
  }
}
