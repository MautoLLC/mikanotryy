import 'package:flutter/material.dart';
import 'package:mymikano_app/State/ProductState.dart';
import 'package:mymikano_app/models/StoreModels/ProductCartModel.dart';
import 'package:mymikano_app/models/StoreModels/ProductModel.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/utils/images.dart';
import 'package:mymikano_app/utils/strings.dart';
import 'package:mymikano_app/views/widgets/AppWidget.dart';
import 'package:mymikano_app/views/widgets/SubTitleText.dart';
import 'package:mymikano_app/views/widgets/TitleText.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

int Quantity = 1;

class ProductDetailsPage extends StatelessWidget {
  Product product;
  bool isFavorite = false;
  RegExp exp = RegExp(r"<[^>]/*>", multiLine: true, caseSensitive: true);
  RegExp exp2 = RegExp(r"<[^>]*/>", multiLine: true, caseSensitive: true);
  RegExp exp3 = RegExp(r"</[^>]*>", multiLine: true, caseSensitive: true);

  ProductDetailsPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Quantity = 1;
    return Consumer<ProductState>(
      builder: (context, state, child) => Scaffold(
          body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: [
              Stack(children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                          height: size.height / 2,
                          padding: EdgeInsets.fromLTRB(45.0, 10.0, 45.0, 10.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: commonCacheImageWidget(product.Image, 85,
                              fit: BoxFit.fitWidth)),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () => finish(context),
                        icon: Icon(Icons.arrow_back_ios_new)),
                    FavoriteWidget(
                      isFavorite: isFavorite,
                    )
                  ],
                ),
              ]),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(child: SubTitleText(title: product.Name)),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 18,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: product.Rating,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Icon(Icons.star, color: mainColorTheme);
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  QuantityChooser(),
                  Text(
                    '\$${product.Price}',
                    style: TextStyle(fontSize: 20, fontFamily: PoppinsFamily),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  TitleText(title: lbl_About_the_product),
                  SizedBox(height: 11),
                  Text(
                    product.Description.replaceAll(exp, "")
                        .replaceAll(exp2, "\n")
                        .replaceAll(exp3, "\n"),
                    maxLines: 1000,
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: PoppinsFamily,
                        color: mainGreyColorTheme),
                  )
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // TODO Buy Now
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                          color: mainBlackColorTheme,
                        ),
                        child: Center(
                            child: Text(lbl_Buy_Now,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontFamily: PoppinsFamily))),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        CartProduct p = CartProduct(product: product, quantity: Quantity);
                        state.addProduct(p);
                        toast("${product.Name} added to cart");
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                          color: mainColorTheme,
                        ),
                        child: Center(
                            child: Text(lbl_Add_To_Cart,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontFamily: PoppinsFamily))),
                      ),
                    ),
                  )
                ],
              )
            ]),
          ),
        ),
      )),
    );
  }
}

class QuantityChooser extends StatefulWidget {
  const QuantityChooser({
    Key? key,
  }) : super(key: key);

  @override
  State<QuantityChooser> createState() => _QuantityChooserState();
}

class _QuantityChooserState extends State<QuantityChooser> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(30)),
            border: Border.all(color: lightBorderColor, width: 1)),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: IconButton(
                  onPressed: () {
                    Quantity > 0 ? Quantity-- : null;
                    setState(() {});
                  },
                  icon: Icon(
                    Icons.minimize,
                    color: mainGreyColorTheme,
                  )),
            ),
            Text(
              Quantity.toString(),
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: PoppinsFamily),
            ),
            IconButton(
                onPressed: () {
                  Quantity++;
                  setState(() {});
                },
                icon: Icon(Icons.add, color: mainGreyColorTheme)),
          ],
        ));
  }
}

class FavoriteWidget extends StatefulWidget {
  bool isFavorite;
  FavoriteWidget({Key? key, required this.isFavorite}) : super(key: key);

  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          setState(() {
            widget.isFavorite = !widget.isFavorite;
          });
        },
        child: commonCacheImageWidget(ic_heart, 30,
            color: widget.isFavorite ? mainColorTheme : null));
  }
}
