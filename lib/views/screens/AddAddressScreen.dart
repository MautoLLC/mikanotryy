import 'package:flutter/material.dart';
import 'package:mymikano_app/State/UserState.dart';
import 'package:mymikano_app/utils/strings.dart';
import 'package:mymikano_app/views/widgets/SubTitleText.dart';
import 'package:mymikano_app/views/widgets/T13Widget.dart';
import 'package:mymikano_app/views/widgets/TopRowBar.dart';
import 'package:provider/provider.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({Key? key}) : super(key: key);

  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  TextEditingController addressController = TextEditingController();
  TextEditingController CityController = TextEditingController();
  TextEditingController StateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<UserState>(
      builder: (context, state, child) => Scaffold(
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopRowBar(title: lbl_Add_Address),
              SizedBox(height: 30),
              SubTitleText(title: lbl_New_Address),
              SizedBox(height: 10),
              t13EditTextStyle(lbl_Address, addressController,
                  isPassword: false),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: t13EditTextStyle(lbl_City, CityController,
                          isPassword: false)),
                  SizedBox(width: 10),
                  Expanded(
                      child: t13EditTextStyle(lbl_State, StateController,
                          isPassword: false)),
                ],
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: T13Button(
                    textContent: lbl_Add_Address,
                    onPressed: () {
                      state.addAddress(
                        addressController.text,
                        CityController.text,
                      );
                      Navigator.pop(context);
                    }),
              )
            ],
          ),
        )),
      ),
    );
  }
}
