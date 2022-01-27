import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mymikano_app/State/ProductState.dart';
import 'package:mymikano_app/models/StoreModels/ProductModel.dart';
import 'package:mymikano_app/utils/strings.dart';
import 'package:mymikano_app/views/widgets/SubTitleText.dart';
import 'package:mymikano_app/views/widgets/VerticalItemElement.dart';
import 'package:provider/provider.dart';

class SearchItemSubPage extends StatelessWidget {
  const SearchItemSubPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductState>(
      builder: (context, state, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          SubTitleText(title: lbl_Stored_Items),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                Random random = new Random();
                Product temp = state.allProducts[random.nextInt(state.allProducts.length)];
                return VerticalItemElement(
                  product: temp,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}