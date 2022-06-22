import 'package:flutter/material.dart';
import 'package:mymikano_app/State/CurrencyState.dart';
import 'package:mymikano_app/State/ProductState.dart';
import 'package:mymikano_app/State/UserState.dart';
import 'package:mymikano_app/models/TechnicianModel.dart';
import 'package:mymikano_app/services/PaymentService.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:mymikano_app/utils/images.dart';
import 'package:mymikano_app/utils/strings.dart';
import 'package:mymikano_app/views/screens/CardsScreen.dart';
import 'package:mymikano_app/views/widgets/ImageBox.dart';
import 'package:mymikano_app/views/widgets/SubTitleText.dart';
import 'package:mymikano_app/views/widgets/T13Widget.dart';
import 'package:mymikano_app/views/widgets/TopRowBar.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import 'AddressScreen.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer3<UserState, ProductState, CurrencyState>(
        builder: (context, state, productState, currencyState, child) => Scaffold(
                body: SafeArea(
                  child: CustomScrollView(slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TopRowBar(title: lbl_Checkout),
                            SizedBox(height: 40.0),
                            Container(
                              padding: const EdgeInsets.fromLTRB(
                                  0.0, 0.0, 0.0, 20.0),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: lightBorderColor,
                                          width: 1.0))),
                              child: Row(
                                children: [
                                  ImageBox(
                                    image: ic_Location_Pin,
                                    color: Colors.black,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        14.3, 0.0, 0.0, 0.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          lbl_Delivery_Address,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: mainBlackColorTheme),
                                        ),
                                        SizedBox(height: 11),
                                        Text(
                                          state.ChosenAddress.address1
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: mainGreyColorTheme),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddressScreen()));
                                        },
                                        icon: Icon(Icons.edit,
                                            color: mainGreyColorTheme)),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 20.0),
                            SubTitleText(title: lbl_Method_Of_Payment),
                            SizedBox(height: 20.0),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      productState.setCashOnDelivery(true);
                                    },
                                    child: Container(
                                      padding:
                                          EdgeInsets.fromLTRB(0, 20, 0, 20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50.0)),
                                        color: productState.getCashOnDelivery
                                            ? mainColorTheme
                                            : mainGreyColorTheme
                                                .withOpacity(0.3),
                                      ),
                                      child: Center(
                                          child: Text(lbl_Pay_Cash,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18))),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5.0),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      productState.setCashOnDelivery(false);
                                    },
                                    child: Container(
                                      padding:
                                          EdgeInsets.fromLTRB(0, 20, 0, 20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50.0)),
                                        color: !productState.getCashOnDelivery
                                            ? mainColorTheme
                                            : mainGreyColorTheme
                                                .withOpacity(0.3),
                                      ),
                                      child: Center(
                                          child: Text(lbl_Pay_With_Card,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18))),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.0),
                            // if (!productState.getCashOnDelivery)
                            //   Wrap(
                            //     children: [
                            //       Row(
                            //         mainAxisAlignment: MainAxisAlignment.end,
                            //         children: [
                            //           GestureDetector(
                            //             onTap: () {
                            //               Navigator.of(context).push(
                            //                   MaterialPageRoute(
                            //                       builder: (context) =>
                            //                           CardsScreen()));
                            //             },
                            //             child: Text(
                            //               lbl_Add_Card,
                            //               style: TextStyle(
                            //                   fontSize: 15,
                            //                   color: mainGreyColorTheme),
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //       SizedBox(height: 10.0),
                            //       Container(
                            //         decoration: BoxDecoration(
                            //             border: Border(
                            //                 bottom: BorderSide(
                            //                     color: lightBorderColor,
                            //                     width: 1.0))),
                            //         padding: const EdgeInsets.fromLTRB(
                            //             0.0, 0.0, 0.0, 20.0),
                            //         child: Row(
                            //           children: [
                            //             ImageBox(
                            //               image: ic_visa,
                            //             ),
                            //             Padding(
                            //               padding: const EdgeInsets.fromLTRB(
                            //                   14.3, 0.0, 0.0, 0.0),
                            //               child: Column(
                            //                 mainAxisAlignment:
                            //                     MainAxisAlignment.center,
                            //                 crossAxisAlignment:
                            //                     CrossAxisAlignment.start,
                            //                 children: [
                            //                   Text(
                            //                     "*** 8901",
                            //                     style: TextStyle(fontSize: 14),
                            //                   ),
                            //                 ],
                            //               ),
                            //             ),
                            //             Spacer(),
                            //             GestureDetector(
                            //               onTap: () {
                            //                 //TODO : Delete Card
                            //               },
                            //               child: Container(
                            //                 decoration: BoxDecoration(
                            //                     color: mainGreyColorTheme,
                            //                     borderRadius:
                            //                         BorderRadius.circular(24)),
                            //                 height: 20,
                            //                 width: 20,
                            //                 child: Icon(
                            //                   Icons.keyboard_arrow_down_rounded,
                            //                   color: Colors.white,
                            //                   size: 20,
                            //                 ),
                            //               ),
                            //             ),
                            //           ],
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            Row(
                              children: [
                                Checkbox(
                                    value: state.checkedValueForOrder,
                                    onChanged: (value) {
                                      state.setcheckedValueForOrder(value!);
                                    }),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.75,
                                  child: Text(
                                    txt_Terms_Of_User_Order,
                                    style: TextStyle(
                                        color: mainGreyColorTheme,
                                        fontSize: 14),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 40.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  lbl_Products,
                                  style: TextStyle(fontSize: 14),
                                ),
                                Text(
                                  productState.selectedProducts
                                      .fold(
                                          0,
                                          (total, product) =>
                                              (total.toString()).toDouble() +
                                              product.quantity)
                                      .toString(),
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  lbl_Discount,
                                  style: TextStyle(fontSize: 14),
                                ),
                                Text(
                                  '${currencyState.currency!.currencySymbol}' + "0.00",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  lbl_Delivery,
                                  style: TextStyle(fontSize: 14),
                                ),
                                Text(
                                  lbl_Free_of_charge,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.0),
                            Container(
                              height: 1,
                              width: MediaQuery.of(context).size.width,
                              color: lightBorderColor,
                            ),
                            SizedBox(height: 20.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  lbl_Total,
                                  style: TextStyle(fontSize: 14),
                                ),
                                Text(
                                  '${currencyState.currency!.currencySymbol}' +
                                      "${productState.selectedProductsPrice}",
                                  style: TextStyle(
                                      fontSize: 14, color: mainColorTheme),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.0),
                            T13Button(
                                textContent: lbl_Pay,
                                onPressed: () async {
                                  if (state.checkedValueForOrder) {
                                    TechnicianModel user = state.User;
                                    if (!productState.getCashOnDelivery) {
                                      if (await PaymentService().pay(
                                          user.id,
                                          user.username,
                                          user.email,
                                          user.phoneNumber,
                                                  productState
                                                      .selectedProductsPrice.toInt())) {
                                        Fluttertoast.showToast(
                                            msg: "Payment Successful",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.green,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                            productState
                                        .checkout(state.ChosenAddress)
                                        .then((value) {
                                      if (value) {
                                        Navigator.pop(context);
                                      }
                                    });
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: "Payment Failed",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      }
                                    } else {
                                      productState
                                        .checkout(state.ChosenAddress)
                                        .then((value) {
                                      if (value) {
                                        Navigator.pop(context);
                                      }
                                    });
                                    }

                                    
                                  } else {
                                    toast(
                                        "Terms and services checkbox is unchecked");
                                  }
                                }),
                            SizedBox(height: 20.0),
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            );
  }
}
