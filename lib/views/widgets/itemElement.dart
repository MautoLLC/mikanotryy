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
  final String title;
  final String image;
  final String code;
  final String price;
  final String id;
  final String Description;
  final String Category;
  final int Rating;
  const ItemElement({
    Key? key,
    this.id = '0',
    this.Description = '',
    this.Category = '',
    this.Rating = 0,
    required this.title,
    required this.image,
    required this.code,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Product temp = Product(
      id: int.parse(id),
      Name: title,
      Price: double.parse(price),
      Description: Description,
      Image: image,
      Code: code,
      Category: Category,
      Rating: Rating,
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
                          child: commonCacheImageWidget(image, 85,
                              fit: BoxFit.fitWidth)),
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        title,
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
                  height: 6,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "\$${price}",
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
