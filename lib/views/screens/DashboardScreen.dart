import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mymikano_app/State/ProductState.dart';
import 'package:mymikano_app/State/UserState.dart';
import 'package:mymikano_app/models/CarouselImageModel.dart';
import 'package:mymikano_app/models/StoreModels/ProductModel.dart';
import 'package:mymikano_app/services/StoreServices/ProductService.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:mymikano_app/utils/DataGenerator.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/views/widgets/NotificationBell.dart';
import 'package:mymikano_app/views/widgets/SubTitleText.dart';
import 'package:mymikano_app/views/widgets/T13Widget.dart';
import 'package:mymikano_app/views/widgets/HorizontalItemElement.dart';
import 'package:mymikano_app/views/widgets/itemElement.dart';
import 'package:mymikano_app/views/widgets/AppWidget.dart';
import 'package:mymikano_app/models/CategoryModel.dart';
import 'package:mymikano_app/utils/images.dart';
import 'package:mymikano_app/utils/strings.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import 'ListPage.dart';

class Dashboard extends StatefulWidget {
  static var tag = "/T5Dashboard";

  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  List<CategoryModel>? mFavouriteList;
  bool guestLogin = true;

  init() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    guestLogin = await prefs.getBool("GuestLogin")!;
    setState(() {
      
    });
  }

  @override
  void initState() {
    init();
    super.initState();
    Provider.of<UserState>(context, listen: false).update();
    mFavouriteList = getDItems();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    TextEditingController SearchController = new TextEditingController();
    return Consumer<ProductState>(
      builder: (context, state, child) => Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              SafeArea(
                child: Container(
                  transform: Matrix4.translationValues(0.0, 8.0, 0.0),
                  margin: EdgeInsets.only(left: 16, right: 16),
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Align(
                          alignment: Alignment.center,
                          child: commonCacheImageWidget(ic_AppLogo, 60)),
                        !guestLogin?Align(
                          alignment: Alignment.centerRight,
                          child: NotificationBell(),
                        ):Container()
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
                          child: t13EditTextStyle(lbl_Search, SearchController,
                              isPassword: false))
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 140,
                child: FutureBuilder<List<CarouselImageModel>>(
                    future: ProductsService().getCarouselImages(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done)
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return snapshot.data![index].position
                                          .toString() ==
                                      "top"
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: CachedNetworkImage(
                                          imageUrl: snapshot.data![index].url
                                              .toString(),
                                          height: 280,
                                          memCacheHeight: 280,
                                          memCacheWidth: 420,
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                          value:
                                                              downloadProgress
                                                                  .progress)),
                                          errorWidget: (_, __, ___) {
                                            return SizedBox(
                                                height: 300, width: width);
                                          },
                                        ),
                                      ),
                                    )
                                  : Container(
                                      width: 0,
                                      height: 0,
                                    );
                            });
                      else
                        return Center(child: CircularProgressIndicator());
                    }),
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
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ListPage(
                                          title: mFavouriteList![index].name,
                                        )));
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: boxDecoration(
                                    radius: 33,
                                    showShadow: false,
                                    bgColor:
                                        mainGreyColorTheme.withOpacity(0.3)),
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
                  height: 470,
                  child: state.popularProducts.length != 0
                      ? GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.8,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: state.popularProducts.length,
                          itemBuilder: (context, index) {
                            Product temp = state.popularProducts[index];
                            return ItemElement(
                              product: temp,
                            );
                          })
                      : Center(child: CircularProgressIndicator()),
                ),
              ),
              SizedBox(
                height: 41,
              ),
              SizedBox(
                height: 140,
                child: FutureBuilder<List<CarouselImageModel>>(
                  future: ProductsService().getCarouselImages(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done)
                      return ListView.builder(
                          itemCount: snapshot.data!.length > 0
                              ? snapshot.data!.length
                              : 0,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return snapshot.data![index].position.toString() ==
                                    "bottom"
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: CachedNetworkImage(
                                        imageUrl: snapshot.data![index].url
                                            .toString(),
                                        height: 280,
                                        useOldImageOnUrlChange: true,
                                        memCacheHeight: 280,
                                        memCacheWidth: 420,
                                        progressIndicatorBuilder: (context, url,
                                                downloadProgress) =>
                                            Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        value: downloadProgress
                                                            .progress)),
                                        errorWidget: (_, __, ___) {
                                          return SizedBox(
                                              height: 300, width: width);
                                        },
                                      ),
                                    ),
                                  )
                                : Container(
                                    width: 0,
                                    height: 0,
                                  );
                          });
                    else
                      return Center(child: CircularProgressIndicator());
                  },
                ),
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
                  child: state.flashsaleProducts.length != 0
                      ? ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.flashsaleProducts.length,
                          itemBuilder: (context, index) {
                            Product temp = state.flashsaleProducts[index];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: SizedBox(
                                width: 140,
                                child: ItemElement(
                                  product: temp,
                                ),
                              ),
                            );
                          })
                      : Center(child: CircularProgressIndicator())),
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
                child: state.trendingProducts.length != 0
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.trendingProducts.length,
                        itemBuilder: (context, index) {
                          Product temp = state.trendingProducts[index];
                          return HorizontalItemElement(
                            product: temp,
                          );
                        })
                    : Center(child: CircularProgressIndicator()),
              )
            ]),
          )),
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
