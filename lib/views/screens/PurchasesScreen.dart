import 'package:flutter/material.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:mymikano_app/utils/images.dart';
import 'package:mymikano_app/utils/strings.dart';
import 'package:mymikano_app/views/widgets/AppWidget.dart';
import 'package:mymikano_app/views/widgets/SubTitleText.dart';
import 'package:mymikano_app/views/widgets/TopRowBar.dart';
import 'package:mymikano_app/views/widgets/itemElement.dart';

class PurchasesScreen extends StatefulWidget {
  const PurchasesScreen({ Key? key }) : super(key: key);

  @override
  _PurchasesScreenState createState() => _PurchasesScreenState();
}

class _PurchasesScreenState extends State<PurchasesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            children: [
              TopRowBar(title: lbl_Purchases),
              SizedBox(height: 30,),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 20.0,
                    childAspectRatio: 0.8
                    ),
                  itemBuilder: (context, index) {
                    return ItemElement(title: "Philips led bulb", image: t3_mcb, code: "Code-2344", price: "\$14.88",);
                  }
                ),
              )
            ],
          ),
        ),
      ),
      
    );
  }
}