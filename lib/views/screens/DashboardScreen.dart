import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:mymikano_app/utils/DataGenerator.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/views/screens/MenuScreen.dart';
import 'package:mymikano_app/views/widgets/SubTitleText.dart';
import 'package:mymikano_app/views/widgets/T13Widget.dart';
import 'package:mymikano_app/views/widgets/itemElement.dart';
import 'package:mymikano_app/views/widgets/AppWidget.dart';
import 'package:mymikano_app/models/DashboardCardModel.dart';
import 'package:mymikano_app/utils/images.dart';
import 'package:mymikano_app/utils/strings.dart';

import 'ListPage.dart';

class Dashboard extends StatefulWidget {
  static var tag = "/T5Dashboard";

  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  bool passwordVisible = false;
  bool isRemember = false;
  var currentIndexPage = 0;
  List<T5Category>? mFavouriteList;
  List<String>? mSliderList;

  @override
  void initState() {
    super.initState();
    passwordVisible = false;
    mFavouriteList = getDItems();
    mSliderList = getSliders();
  }

  void changeSldier(int index) {
    setState(() {
      currentIndexPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    changeStatusColor(Colors.transparent);
    var width = MediaQuery.of(context).size.width;
    width = width - 50;
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    TextEditingController SearchController = new TextEditingController();
    return Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        body: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            SafeArea(
              child: Container(
                transform: Matrix4.translationValues(0.0, 8.0, 0.0),
                margin: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MenuScreen()));
                      },
                      child: SvgPicture.asset(ic_menu),
                    ),
                    Spacer(),
                    Image.asset(
                      'images/MyMikanoLogo2.png',
                      width: 60,
                      height: 60,
                    ),
                    Spacer(),
                    IconButton(
                        onPressed: () {
                          // TODO Notification Page Open
                        },
                        icon: Icon(Icons.notifications))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                child: Row(
                  children: [
                    Expanded(
                        child: t13EditTextStyle(lbl_Search, SearchController))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SubTitleText(title: lbl_Top_Categories),
                ],
              ),
            ),
            SizedBox(
              height: 21,
            ),
            SizedBox(
              height: 100,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: mFavouriteList!.length,
                physics: AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              // TODO Open category page
                            },
                            child: Container(
                              alignment: Alignment.center,
                              decoration: boxDecoration(
                                  radius: 33,
                                  showShadow: false,
                                  bgColor: mainGreyColorTheme.withOpacity(0.3)),
                              child: commonCacheImageWidget(
                                mFavouriteList![index].icon,
                                60,
                                width: 80,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          mFavouriteList![index].name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            fontFamily: PoppinsFamily,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 41,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SubTitleText(title: lbl_Popular_Products),
                  ViewMoreBtn(title: lbl_Popular_Products),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                height: 440,
                child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return ItemElement(
                        title: "Philips led bulb",
                        image: t3_mcb,
                        code: "Code-2344",
                        price: "14.88",
                      );
                    }),
              ),
            ),
            SizedBox(
              height: 41,
            ),
            SizedBox(
              height: 140,
              child: ListView.builder(
                  itemCount: mSliderList!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: commonCacheImageWidget(
                          mSliderList!.elementAt(index), 300),
                    );
                  }),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SubTitleText(title: lbl_Flash_Sale),
                  ViewMoreBtn(title: lbl_Flash_Sale),
                ],
              ),
            ),
            SizedBox(
              height: 21,
            ),
            SizedBox(
                height: 250,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: SizedBox(
                          width: 140,
                          child: ItemElement(
                            title: "Philips led bulb",
                            image: t3_mcb,
                            code: "Code-2344",
                            price: "14.88",
                          ),
                        ),
                      );
                    })),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SubTitleText(title: lbl_Top_Brands),
                ],
              ),
            ),
            SizedBox(
              height: 21,
            ),
            SizedBox(
                height: 60,
                child: ListView.builder(
                    itemCount: 4,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          width: 105,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border:
                                Border.all(color: lightBorderColor, width: 1),
                          ),
                          child: commonCacheImageWidget(
                              "assets/Brand${index + 1}.png", 60,
                              width: 60),
                        ),
                      );
                    })),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SubTitleText(title: lbl_Trending_Now),
                  ViewMoreBtn(title: lbl_Trending_Now)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                height: 450,
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return TrendingNowItem();
                    }),
              ),
            )
          ]),
        ));
  }
}

class TrendingNowItem extends StatelessWidget {
  const TrendingNowItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(color: lightBorderColor, width: 1))),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                // TODO Open category page
              },
              child: Container(
                alignment: Alignment.center,
                decoration: boxDecoration(
                    radius: 33,
                    showShadow: true,
                    bgColor: mainGreyColorTheme.withOpacity(0.3)),
                child: commonCacheImageWidget(
                  t3_mcb,
                  60,
                  width: 80,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Philips led bulb",
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Poppins",
                    color: mainBlackColorTheme,
                  ),
                ),
                SizedBox(
                  height: 11,
                ),
                Text(
                  "Code-2344",
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Poppins",
                    color: mainGreyColorTheme,
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "\$14.88",
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Poppins",
                    color: mainBlackColorTheme,
                  ),
                ),
                SizedBox(
                  height: 7,
                ),
                GestureDetector(
                  onTap: () {
                    // TODO logic
                  },
                  child: commonCacheImageWidget(ic_Cart, 24),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ViewMoreBtn extends StatelessWidget {
  String title;
  ViewMoreBtn({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          //TODO View More Logic
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ListPage(title: title)));
        },
        child: Text(lbl_View_more,
            style: TextStyle(
                color: mainGreyColorTheme,
                fontSize: 15,
                fontFamily: PoppinsFamily)));
  }
}
