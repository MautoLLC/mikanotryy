import 'package:flutter/material.dart';
import 'package:mymikano_app/models/StoreModels/OrderModel.dart';
import 'package:mymikano_app/models/StoreModels/ProductModel.dart';
import 'package:mymikano_app/views/widgets/TopRowBar.dart';
import 'package:mymikano_app/views/widgets/itemElement.dart';

class OrderDetailsPage extends StatelessWidget {
  Order order;
  OrderDetailsPage({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              TopRowBar(title: "Order ${order.id}"),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("OrderID: ${order.id}"),
                      Text("Item Count: ${order.orderItems!.fold(0, (previousValue, element) => int.parse(previousValue.toString()) + element.quantity)}"),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Order Total Price: ${order.orderTotal}"),
                      Text("Status: ${order.orderStatus}"),
                    ],
                  ),
                ],
              ),
              Divider(),
              SizedBox(
                height: 30,
              ),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) => GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            (constraints.constrainWidth() ~/ 310).toInt() + 1,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 20.0,
                        childAspectRatio: 0.8),
                    itemCount: order.orderItems!.length,
                    itemBuilder: (context, index){
                      Product product = order.orderItems!.elementAt(index).product!;
                      return ItemElement(product: product);
                    }
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
