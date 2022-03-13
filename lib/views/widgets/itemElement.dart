import 'package:flutter/material.dart';
import 'package:mymikano_app/State/ProductState.dart';
import 'package:mymikano_app/models/StoreModels/ProductModel.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:mymikano_app/utils/images.dart';
import 'package:mymikano_app/views/screens/ProductDetailsPage.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import 'AppWidget.dart';

class ItemElement extends StatefulWidget {
  final Product product;
  const ItemElement({Key? key, required this.product}) : super(key: key);

  @override
  State<ItemElement> createState() => _ItemElementState();
}

class _ItemElementState extends State<ItemElement> {
  bool guestLogin = true;

  init() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    guestLogin = await prefs.getBool("GuestLogin")!;
  }

  @override
  void initState() {
    init();
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    Product temp = Product(
      id: int.parse(widget.product.id.toString()),
      Name: widget.product.Name,
      Price: double.parse(widget.product.Price.toString()),
      Description: widget.product.Description,
      Image: widget.product.Image,
      Code: widget.product.Code,
      Category: widget.product.Category,
      Rating: widget.product.Rating,
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
            borderRadius: BorderRadius.all(Radius.circular(0))),
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
                          padding: EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(0))),
                          child: commonCacheImageWidget(widget.product.Image, 106,
                              fit: BoxFit.cover)),
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        widget.product.Name,
                        style: TextStyle(
                          fontSize: 14,
                          color: mainBlackColorTheme,
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
                      widget.product.Code,
                      style: TextStyle(
                        fontSize: 14,
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
                      "\$${widget.product.Price}",
                      style: TextStyle(
                        fontSize: 14,
                        color: mainBlackColorTheme,
                      ),
                    ),
                  ],
                ),
                Spacer(),
              ],
            ),
          ),
          guestLogin?Container():
          Consumer<ProductState>(
            builder: (context, state, child) => Padding(
              padding: const EdgeInsets.all(12.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  onTap: () {
                    state.addorremoveProductToFavorite(widget.product);
                  },
                  child: commonCacheImageWidget(ic_heart, 30,
                      color: state.allProducts
                              .firstWhere((element) => element.id == widget.product.id)
                              .liked
                          ? mainColorTheme
                          : null),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
