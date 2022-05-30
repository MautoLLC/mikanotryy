import 'package:flutter/material.dart';
import 'package:mymikano_app/State/ProductState.dart';
import 'package:mymikano_app/models/StoreModels/ProductCartModel.dart';
import 'package:mymikano_app/models/StoreModels/ProductFavoriteModel.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/utils/images.dart';
import 'package:mymikano_app/utils/strings.dart';
import 'package:mymikano_app/views/widgets/AppWidget.dart';
import 'package:mymikano_app/views/widgets/TopRowBar.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  bool isfirst = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductState>(builder: (context, state, child) {
      if (isfirst) {
        state.getFavorites();
        isfirst = false;
      }
      return Scaffold(
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TopRowBar(title: lbl_Favorites),
              SizedBox(height: 40),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      height: 55,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(33),
                        color: mainGreyColorTheme.withOpacity(0.1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          commonCacheImageWidget(ic_favorite, 20,
                              color: mainGreyColorTheme),
                          SizedBox(width: 5),
                          Text(
                              state.favoriteProducts.length == 0
                                  ? "You have no favorites yet"
                                  : "You have ${state.favoriteProducts.length} items in your Favorites",
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
                        itemCount: state.favoriteProducts.length,
                        itemBuilder: (context, index) {
                          return FavoritesItem(
                            product: state.favoriteProducts[index],
                            OnPressed: () {
                              state.addorremoveProductToFavorite(
                                  state.favoriteProducts[index].product);
                            },
                          );
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )),
      );
    });
  }
}

class FavoritesItem extends StatelessWidget {
  final FavoriteProduct product;
  final Function OnPressed;
  const FavoritesItem({
    Key? key,
    required this.product,
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
      key: Key(this.product.id.toString()),
      onDismissed: (direction) {
        OnPressed();
        // Then show a snackbar.
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("${product.product.Name} dismissed")));
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 9.0),
        child: Container(
          height: 100,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: mainGreyColorTheme2,
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
                          child:
                              commonCacheImageWidget(product.product.Image, 65),
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
                              product.product.Name,
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
                            product.product.Code,
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
                            "\$${product.product.Price}",
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
                  child: Consumer<ProductState>(
                      builder: (context, ProductState, child) {
                    return GestureDetector(
                      onTap: () {
                        // TODO add to cart logic
                        CartProduct p =
                            CartProduct(product: product.product, quantity: 1);
                        ProductState.addProduct(p);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                                Text("${product.product.Name} added to cart")));
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
                    );
                  }),
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
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: mainColorTheme,
          ),
          child: Center(
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        ),
      );
}
