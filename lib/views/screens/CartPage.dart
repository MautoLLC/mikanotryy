import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mymikano_app/State/CurrencyState.dart';
import 'package:mymikano_app/State/ProductState.dart';
import 'package:mymikano_app/models/StoreModels/ProductCartModel.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:mymikano_app/utils/images.dart';
import 'package:mymikano_app/utils/strings.dart';
import 'package:mymikano_app/views/widgets/AppWidget.dart';
import 'package:mymikano_app/views/widgets/T13Widget.dart';
import 'package:mymikano_app/views/widgets/TitleText.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import 'CheckoutScreen.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool isFirst = true;

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<ProductState>(context, listen: false).clearCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ProductState, CurrencyState>(
        builder: (context, ProductState, currencyState, child) {
      if (isFirst) {
        ProductState.updateCart();
        isFirst = false;
      }
      return Scaffold(
          body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // IconButton(
                    //   icon: Icon(
                    //     Icons.arrow_back_ios,
                    //     color: Colors.transparent,
                    //   ),
                    //   onPressed: () {
                    //     // finish(context);
                    //   },
                    // ),
                    // Spacer(),
                    TitleText(
                      title: lbl_My_Cart,
                    ),
                    // Spacer(),
                    // GestureDetector(
                    //     onTap: () {
                    //       ProductState.toggleSelectMode();
                    //     },
                    //     child: Text(
                    //       lbl_Select,
                    //       style: TextStyle(
                    //           color: ProductState.selectMode
                    //               ? mainColorTheme
                    //               : mainGreyColorTheme,
                    //           fontSize: 15),
                    //     ))
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
                          "You have ${ProductState.productsInCart.length} items in your list cart",
                          style: TextStyle(
                              color: mainGreyColorTheme, fontSize: 12)),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: ProductState.productsInCart.length,
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
                      "${ProductState.selectedProducts.length != 0 ? ProductState.selectedProducts.fold(0, (previousValue, element) => previousValue.toString().toDouble() + (element.quantity)) : ProductState.productsInCart.length != 0 ? ProductState.productsInCart.fold(0, (previousValue, element) => previousValue.toString().toDouble() + (element.quantity)) : 0}",
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(lbl_Total_Price, style: TextStyle(fontSize: 14)),
                    Text(
                      "${currencyState.currency.currencySymbol} ${ProductState.selectedProducts.length != 0 ? NumberFormat.decimalPattern().format(ProductState.selectedProducts.fold(0, (total, product) => (total.toString()).toDouble() + product.product.Price * product.quantity)) : ProductState.productsInCart.length != 0 ? NumberFormat.decimalPattern().format(ProductState.productsInCart.fold(0, (total, product) => (total.toString()).toDouble() + product.product.Price * product.quantity)) : 0}",
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                T13Button(
                  textContent: lbl_Checkout,
                  onPressed: () {
                    if (ProductState.selectedProducts.length == 0)
                      ProductState.selectedProducts =
                          ProductState.productsInCart;
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CheckoutScreen()));
                  },
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
  final CartProduct product;
  final Function OnPressed;

  const CartItem({
    Key? key,
    required this.product,
    required this.OnPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<ProductState, CurrencyState>(
        builder: (context, ProductState, currencyState, child) {
      return Dismissible(
          behavior: HitTestBehavior.deferToChild,
          background: Container(
            color: Colors.transparent,
          ),
          secondaryBackground: DeleteBtn(),
          direction: ProductState.selectMode
              ? DismissDirection.none
              : DismissDirection.endToStart,
          key: UniqueKey(),
          onDismissed: (direction) {
            OnPressed();
            // Then show a snackbar.
            toast("${product.product.Name} removed from cart");
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
                                        product.product.Image, 65),
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
                                          !ProductState.selectMode ? 100 : 150,
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
                                      "${currencyState.currency.currencySymbol} ${NumberFormat.decimalPattern().format(product.product.Price)}",
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
                            if (!ProductState.selectMode)
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          ProductState.decreaseCartItemQuantity(
                                              product);
                                        },
                                        icon: Icon(
                                          Icons.remove_circle,
                                          color: mainGreyColorTheme,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        product.quantity.toString(),
                                        style: TextStyle(
                                            color: mainGreyColorTheme,
                                            fontSize: 14),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          ProductState.increaseCartItemQuantity(
                                              product);
                                        },
                                        icon: Icon(
                                          Icons.add_circle,
                                          color: mainGreyColorTheme,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                          ],
                        ),
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
