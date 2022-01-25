import 'package:flutter/material.dart';
import 'package:mymikano_app/State/ProductState.dart';
import 'package:mymikano_app/models/StoreModels/ProductModel.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:mymikano_app/utils/images.dart';
import 'package:mymikano_app/utils/strings.dart';
import 'package:mymikano_app/views/widgets/AppWidget.dart';
import 'package:mymikano_app/views/widgets/T13Widget.dart';
import 'package:mymikano_app/views/widgets/TitleText.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductState>(builder: (context, ProductState, child) {
      return Scaffold(
          body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: backArrowColor,
                      ),
                      onPressed: () {
                        finish(context);
                      },
                    ),
                    Spacer(),
                    TitleText(
                      title: lbl_My_Cart,
                    ),
                    Spacer(),
                    GestureDetector(
                        onTap: () {
                          ProductState.toggleSelectMode();
                        },
                        child: Text(
                          lbl_Select,
                          style: TextStyle(
                              color: ProductState.selectMode
                                  ? mainColorTheme
                                  : mainGreyColorTheme,
                              fontSize: 15),
                        ))
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
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
                      commonCacheImageWidget(ic_Cart, 20,
                          color: mainGreyColorTheme),
                      SizedBox(width: 5),
                      Text(
                          "You have ${ProductState.totalProducts} items in your list cart",
                          style: TextStyle(
                              color: mainGreyColorTheme, fontSize: 12)),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: ProductState.totalProducts,
                  itemBuilder: (context, index) {
                    return CartItem(
                        product: ProductState.productsInCart[index],
                        OnPressed: () {
                          ProductState.removeFromSelected(
                              ProductState.productsInCart[index]);
                          ProductState.removeProduct(
                              ProductState.productsInCart[index]);
                        });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(lbl_Item_Selected, style: TextStyle(fontSize: 14)),
                    Text(
                      "${ProductState.selectedProductsCount}",
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(lbl_Total_Price, style: TextStyle(fontSize: 14)),
                    Text(
                      "\$${ProductState.selectedProductsPrice}",
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                T13Button(
                  textContent: lbl_Checkout,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ));
    });
  }
}

class CartItem extends StatelessWidget {
  final Product product;
  final Function OnPressed;
  const CartItem({
    Key? key,
    required this.product,
    required this.OnPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductState>(builder: (context, ProductState, child) {
      return Dismissible(
          behavior: HitTestBehavior.deferToChild,
          background: Container(
            color: Colors.transparent,
          ),
          secondaryBackground: DeleteBtn(),
          direction: ProductState.selectMode
              ? DismissDirection.none
              : DismissDirection.endToStart,
          key: Key(this.product.id.toString()),
          onDismissed: (direction) {
            OnPressed();
            // Then show a snackbar.
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("${product.Name} removed from cart")));
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 9.0),
            child: Row(
              children: [
                if (ProductState.selectMode)
                  Checkbox(
                      value: ProductState.isProductSelected(product),
                      onChanged: (value) {
                        ProductState.toggleProductSelection(product);
                      }),
                Expanded(
                  child: Container(
                    height: 100,
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
                                    child: commonCacheImageWidget(
                                        product.Image, 65),
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
                                      width:
                                          !ProductState.selectMode ? 200 : 150,
                                      child: Text(
                                        product.Name,
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
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "\$${product.Price}",
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
                        // Align(
                        //   alignment: Alignment.bottomRight,
                        //   child: Padding(
                        //     padding: const EdgeInsets.only(bottom: 12),
                        //     child: GestureDetector(
                        //         onTap: () {
                        //           // TODO add to cart logic
                        //         },
                        //         child: Container(
                        //           padding: EdgeInsets.only(
                        //               bottom: 6, top: 6, left: 16, right: 16),
                        //           decoration: BoxDecoration(
                        //             borderRadius: BorderRadius.circular(20),
                        //             border: Border.all(color: mainColorTheme, width: 1),
                        //             color: Colors.transparent,
                        //           ),
                        //           child: Text(lbl_Add_To_Cart,
                        //               style: TextStyle(
                        //                   color: mainColorTheme,
                        //                   fontSize: 14)),
                        //         ),
                        //     ),
                        //   ),
                        // ),
                      ]),
                    ),
                  ),
                ),
              ],
            ),
          ));
    });
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
