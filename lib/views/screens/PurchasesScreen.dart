import 'package:flutter/material.dart';
import 'package:mymikano_app/State/CurrencyState.dart';
import 'package:mymikano_app/State/ProductState.dart';
import 'package:mymikano_app/State/UserState.dart';
import 'package:mymikano_app/models/StoreModels/OrderModel.dart';
import 'package:mymikano_app/utils/strings.dart';
import 'package:mymikano_app/views/screens/OrderDetailsPage.dart';
import 'package:mymikano_app/views/widgets/TopRowBar.dart';
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
    return Consumer3<ProductState, UserState, CurrencyState>(
      builder: (context, state, userState, currencyState, child) => Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(children: [
              TopRowBar(title: lbl_Purchases),
              SizedBox(
                height: 30,
              ),
              Expanded(
                  child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      itemCount: state.ordersHistory.length,
                      itemBuilder: (context, index) {
                        Order temp = state.ordersHistory[index];
                        return ListTile(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => OrderDetailsPage(
                                        order: temp,
                                      )))),
                          title: Row(
                            children: [
                              Text("Order ${temp.id.toString()}"),
                              Spacer(),
                              Text(
                                  "${temp.orderTotal.toString()} ${currencyState.currency.currencySymbol}")
                            ],
                          ),
                          trailing: Icon(Icons.arrow_forward_ios),
                          isThreeLine: false,
                          subtitle: Row(
                            children: [
                              Text(temp.billingAddress!.city.toString()),
                              Spacer(),
                              Text("${temp.orderStatus.toString()}")
                            ],
                          ),
                        );
                      }))
            ]),
          ),
        ),
      ),
    );
  }
}
