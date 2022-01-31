import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mymikano_app/State/ProductState.dart';
import 'package:mymikano_app/models/StoreModels/ProductModel.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:mymikano_app/utils/images.dart';
import 'package:mymikano_app/views/screens/ProductDetailsPage.dart';
import 'package:provider/provider.dart';

import 'AppWidget.dart';
import 'auto_size_text/auto_size_text.dart';

class ItemElement extends StatelessWidget {
  final Product product;
  const ItemElement({
    Key? key,
    required this.product
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Product temp = Product(
      id: int.parse(product.id.toString()),
      Name: product.Name,
      Price: double.parse(product.Price.toString()),
      Description: product.Description,
      Image: product.Image,
      Code: product.Code,
      Category: product.Category,
      Rating: product.Rating,
    );
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductDetailsPage(
                  product: temp,
                )));
      },
      child: Container(
        decoration: BoxDecoration(
            color: mainGreyColorTheme2,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        width: MediaQuery.of(context).size.width,
        child: Stack(children: [
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                          padding: EdgeInsets.fromLTRB(45.0, 10.0, 45.0, 10.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: commonCacheImageWidget(product.Image, 85,
                              fit: BoxFit.fill)),
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        product.Name,
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: "Poppins",
                          color: mainBlackColorTheme,
                          // overflow: TextOverflow.ellipsis,
                        ),
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      product.Code,
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: "Poppins",
                        color: mainGreyColorTheme,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "\$${product.Price}",
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: "Poppins",
                        color: mainBlackColorTheme,
                      ),
                    ),
                  ],
                ),
                Spacer(),
              ],
            ),
          ),
          LikeWidget(product: temp),
        ]),
      ),
    );
  }
}

class LikeWidget extends StatefulWidget {
  Product product;
  LikeWidget({Key? key, required this.product}) : super(key: key);

  @override
  State<LikeWidget> createState() => _LikeWidgetState();
}

class _LikeWidgetState extends State<LikeWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductState>(
      builder: (context, state, child) => Padding(
        padding: const EdgeInsets.all(12.0),
        child: Align(
          alignment: Alignment.bottomRight,
          child: GestureDetector(
            onTap: () {
              state.addorremoveProductToFavorite(widget.product);
            },
            child: commonCacheImageWidget(ic_heart, 20,
                color: !state.isInFavorite(widget.product)
                    ? null
                    : mainColorTheme),
          ),
        ),
      ),
    );
  }
}
