import 'package:flutter/material.dart';
import 'package:mymikano_app/utils/strings.dart';
import 'package:mymikano_app/views/widgets/TopRowBar.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({ Key? key }) : super(key: key);

  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              TopRowBar(title: lbl_Add_Address)
            ],
          ),
        )
      ),
    );
  }
}