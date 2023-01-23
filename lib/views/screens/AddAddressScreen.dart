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
  TextEditingController PhoneNumberController = TextEditingController();
  int selectedIndex = 1149;

  var states = [
    {'id': 1149, 'Name': "Abia"},
    {'id': 1150, 'Name': "Adamawa"},
    {'id': 1151, 'Name': "Akwa Ibom"},
    {'id': 1152, 'Name': "Anambra"},
    {'id': 1153, 'Name': "Bauchi"},
    {'id': 1154, 'Name': "Bayelsa"},
    {'id': 1155, 'Name': "Benue"},
    {'id': 1156, 'Name': "Borno"},
    {'id': 1157, 'Name': "Cross River"},
    {'id': 1158, 'Name': "Delta"},
    {'id': 1159, 'Name': "Ebonyi"},
    {'id': 1160, 'Name': "Edo"},
    {'id': 1161, 'Name': "Enugu"},
    {'id': 1162, 'Name': "Ekiti"},
    {'id': 1163, 'Name': "FCT"},
    {'id': 1164, 'Name': "Gombe"},
    {'id': 1165, 'Name': "Imo"},
    {'id': 1166, 'Name': "Jigawa"},
    {'id': 1167, 'Name': "Kaduna"},
    {'id': 1168, 'Name': "Kano"},
    {'id': 1169, 'Name': "Katsina"},
    {'id': 1170, 'Name': "Kebbi"},
    {'id': 1171, 'Name': "Kogi"},
    {'id': 1172, 'Name': "Kwara"},
    {'id': 1173, 'Name': "Lagos"},
    {'id': 1174, 'Name': "Nasarawa"},
    {'id': 1175, 'Name': "Niger"},
    {'id': 1176, 'Name': "Ogun"},
    {'id': 1177, 'Name': "Ondo"},
    {'id': 1178, 'Name': "Osun"},
    {'id': 1179, 'Name': "Oyo"},
    {'id': 1180, 'Name': "Plateau"},
    {'id': 1181, 'Name': "Rivers"},
    {'id': 1182, 'Name': "Sokoto"},
    {'id': 1183, 'Name': "Taraba"},
    {'id': 1184, 'Name': "Yobe"},
    {'id': 1185, 'Name': "Zamafara"},
  ];

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
                    child: DropdownButton(
                        isExpanded: true,
                        value: selectedIndex,
                        items: states.map((e) {
                          return DropdownMenuItem(
                            child: Text(e['Name'].toString()),
                            value: int.parse(e['id'].toString()),
                          );
                        }).toList(),
                        onChanged: (index) {
                          selectedIndex = int.parse(index.toString());
                          setState(() {});
                        }),
                  ),
                ],
              ),
              SizedBox(height: 10),
              t13EditTextStyle(lbl_Phone_Number, PhoneNumberController,
                  isPassword: false, keyboardType: TextInputType.phone),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: T13Button(
                    textContent: lbl_Add_Address,
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      state.addAddress(
                          addressController.text,
                          CityController.text,
                          PhoneNumberController.text,
                          selectedIndex);
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
