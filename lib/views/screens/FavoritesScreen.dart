import 'package:flutter/material.dart';
import 'package:mymikano_app/models/StoreModels/ProductModel.dart';
import 'package:mymikano_app/services/StoreServices/GetProducts.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/utils/images.dart';
import 'package:mymikano_app/utils/strings.dart';
import 'package:mymikano_app/views/widgets/AppWidget.dart';
import 'package:mymikano_app/views/widgets/TopRowBar.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  int numOfItems = 10;
  void OnDismissed() {
    //TODO : Remove from favorites
    numOfItems--;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TopRowBar(title: lbl_Favorites),
            SizedBox(height: 40),
            FutureBuilder(
              future: ProductsService().getProducts(),
              builder: (context, AsyncSnapshot<List<Product>> snapshot) {
                if (snapshot.hasData) {
                  numOfItems = snapshot.data!.length;
                  return Expanded(
                    child: Column(
                      children: [
                        Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: mainGreyColorTheme.withOpacity(0.18),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              commonCacheImageWidget(ic_favorite, 20),
                              SizedBox(width: 5),
                              Text(
                                  numOfItems == 0
                                      ? "You have no favorites yet"
                                      : "You have ${snapshot.data!.length} items in your Favorites",
                                  style: TextStyle(
                                      color: mainGreyColorTheme,
                                      fontSize: 12,
                                      fontFamily: PoppinsFamily)),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return FavoritesItem(
                                id: snapshot.data![index].id,
                                title: snapshot.data!.elementAt(index).Name,
                                price: snapshot.data!
                                    .elementAt(index)
                                    .Price
                                    .toString(),
                                image: snapshot.data!.elementAt(index).Image,
                                OnPressed: OnDismissed,
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )
          ],
        ),
      )),
    );
  }
}

class FavoritesItem extends StatelessWidget {
  final String title;
  final int id;
  final String image;
  final String code;
  final String price;
  final Function OnPressed;
  const FavoritesItem({
    Key? key,
    required this.id,
    this.title = "Philips led bulb",
    this.image = t3_led,
    this.code = "Code-2344",
    this.price = "14.88",
    required this.OnPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      behavior: HitTestBehavior.deferToChild,
      background: Container(
        color: Colors.transparent,
      ),
      secondaryBackground: DeleteBtn(),
      direction: DismissDirection.endToStart,
      key: Key(this.id.toString()),
      onDismissed: (direction) {
        OnPressed();
        // Then show a snackbar.
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("$title dismissed")));
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 9.0),
        child: Container(
          height: 100,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: mainGreyColorTheme.withOpacity(0.18),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
            child: Stack(children: [
              Row(
                children: [
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: 6, top: 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: commonCacheImageWidget(image, 65),
                        )
                      ]),
                  SizedBox(width: 22),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 200,
                            child: Text(
                              title,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: "Poppins",
                                color: mainBlackColorTheme,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            code,
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: "Poppins",
                              color: mainGreyColorTheme,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "\$${price}",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: "Poppins",
                              color: mainColorTheme,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: GestureDetector(
                    onTap: () {
                      // TODO add to cart logic
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          bottom: 6, top: 6, left: 16, right: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: mainColorTheme, width: 1),
                        color: Colors.transparent,
                      ),
                      child: Text(lbl_Add_To_Cart,
                          style: TextStyle(
                              color: mainColorTheme,
                              fontSize: 14,
                              fontFamily: PoppinsFamily)),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget DeleteBtn() => Container(
        alignment: Alignment.centerRight,
        color: Colors.transparent,
        child: Container(
          width: 60,
          padding: EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: mainColorTheme,
          ),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      );
}
