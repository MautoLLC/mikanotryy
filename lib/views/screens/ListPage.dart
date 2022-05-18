import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mymikano_app/State/ProductState.dart';
import 'package:mymikano_app/models/StoreModels/ProductModel.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/utils/strings.dart';
import 'package:mymikano_app/views/widgets/NotificationBell.dart';
import 'package:mymikano_app/views/widgets/T13Widget.dart';
import 'package:mymikano_app/views/widgets/TitleText.dart';
import 'package:mymikano_app/views/widgets/itemElement.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class ListPage extends StatefulWidget {
  final String title;
  bool fromNavigationBar;
  ListPage({Key? key, required this.title, this.fromNavigationBar = false})
      : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  TextEditingController seearchController = TextEditingController();

  bool isfirst = true;

  @override
  void dispose() {
    // TODO: implement dispose
    Provider.of<ProductState>(context, listen: false).clearListOfProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductState>(builder: (context, state, child) {
      if (isfirst) {
        state.clearListOfProducts();
        state.page = 1;
        state.getListOfProducts();
        isfirst = false;
      }
      return Scaffold(
        backgroundColor: Colors.white,
        body: NotificationListener<ScrollEndNotification>(
          onNotification: (ScrollEndNotification notification) {
            if (notification.metrics.pixels ==
                notification.metrics.maxScrollExtent) {
              state.Paginate();
            }
            return true;
          },
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Stack(
                  children: <Widget>[
                    !widget.fromNavigationBar
                        ? Align(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                                onPressed: () {
                                  finish(context);
                                },
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  size: 32.0,
                                )),
                          )
                        : Container(),
                    Align(
                        alignment: Alignment.center,
                        child: TitleText(title: widget.title)),
                    Align(
                        alignment: Alignment.centerRight,
                        child: NotificationBell())
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  style: TextStyle(
                      fontSize: textSizeMedium, fontFamily: PoppinsFamily),
                  obscureText: false,
                  cursorColor: black,
                  controller: seearchController,
                  onChanged: state.fillListOfProductsToShow,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(26, 14, 4, 14),
                    hintText: lbl_Search,
                    hintStyle: primaryTextStyle(color: textFieldHintColor),
                    filled: true,
                    fillColor: lightBorderColor,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 0.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 0.0),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    DropdownButton(
                        icon: Icon(Icons.sort, color: black, size: 25),
                        items: [
                          DropdownMenuItem(
                            child: Text('Sort By Price Low to High'),
                            value: 'price_low_to_high',
                          ),
                          DropdownMenuItem(
                            child: Text('Sort By Price High to Low'),
                            value: 'price_high_to_low',
                          ),
                          DropdownMenuItem(
                            child: Text('A to Z'),
                            value: 'a_to_z',
                          ),
                          DropdownMenuItem(
                            child: Text('Z to A'),
                            value: 'z_to_a',
                          ),
                        ],
                        onChanged: (value) {
                          switch (value) {
                            case 'price_low_to_high':
                              state.sortByPriceLowToHigh();
                              break;
                            case 'price_high_to_low':
                              state.sortByPriceHighToLow();
                              break;
                            case 'a_to_z':
                              state.sortByPriceAToZ();
                              break;
                            case 'z_to_a':
                              state.sortByPriceZToA();
                              break;
                          }
                        }),
                    IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.5,
                                );
                              });
                        },
                        icon: Icon(Icons.filter_1, size: 25, color: black)),
                  ],
                ),
                Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10),
                    itemCount: seearchController.text.length != 0
                        ? state.ListOfProductsToShow.length
                        : state.ListOfProducts.length,
                    itemBuilder: (context, index) {
                      if ((seearchController.text.length != 0
                              ? state.ListOfProductsToShow.length
                              : state.ListOfProducts.length) !=
                          0) {
                        return ItemElement(
                          product: (seearchController.text.length != 0
                              ? state.ListOfProductsToShow
                              : state.ListOfProducts)[index],
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          )),
        ),
      );
    });
  }
}
