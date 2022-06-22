import 'package:flutter/material.dart';
import 'package:mymikano_app/State/ProductState.dart';
import 'package:mymikano_app/State/UserState.dart';
import 'package:mymikano_app/models/StoreModels/ProductModel.dart';
import 'package:mymikano_app/utils/strings.dart';
import 'package:mymikano_app/views/widgets/TopRowBar.dart';
import 'package:mymikano_app/views/widgets/itemElement.dart';
import 'package:provider/provider.dart';

class PurchasesScreen extends StatefulWidget {
  const PurchasesScreen({Key? key}) : super(key: key);

  @override
  _PurchasesScreenState createState() => _PurchasesScreenState();
}

class _PurchasesScreenState extends State<PurchasesScreen> {
  init() async {
    await Provider.of<ProductState>(context, listen: false).fetchPurchases();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ProductState, UserState>(
      builder: (context, state, userState, child) => Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              children: [
                TopRowBar(title: lbl_Purchases),
                SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:
                                      (constraints.constrainWidth() ~/ 310)
                                              .toInt() +
                                          1,
                                  crossAxisSpacing: 10.0,
                                  mainAxisSpacing: 20.0,
                                  childAspectRatio: 0.8),
                          itemCount: state.purchasedProducts.length,
                          itemBuilder: (context, index) {
                            Product temp = state.purchasedProducts[index];
                            return ItemElement(
                              product: temp,
                            );
                          });
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
