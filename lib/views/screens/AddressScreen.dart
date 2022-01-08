import 'package:flutter/material.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/utils/strings.dart';
import 'package:mymikano_app/views/widgets/SubTitleText.dart';
import 'package:mymikano_app/views/widgets/TopRowBar.dart';
import 'package:mymikano_app/utils/AppColors.dart';

import 'AddAddressScreen.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  List<String> ListLocationTitle = [
    "Address 1",
    "Address 2",
  ];

  List<String> ListLocationAddress = [
    "Estate bldg st 9 apt 23/4",
    "Estate bldg st 9 apt 23/4",
  ];

  List<bool> SwitchValue = [
    true,
    false,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            TopRowBar(title: lbl_Address),
            SizedBox(height: 30),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: ListLocationTitle.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                  child: Stack(children: [
                    Row(
                      children: [
                        Container(
                          width: 80,
                          height: 60,
                          child: Icon(Icons.location_pin),
                          decoration: BoxDecoration(
                              color: mainGreyColorTheme.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(30)),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(14.3, 0.0, 0.0, 0.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ListLocationTitle[index],
                                style: TextStyle(
                                    fontSize: 14,
                                    color: mainBlackColorTheme,
                                    fontFamily: PoppinsFamily),
                              ),
                              SizedBox(height: 11),
                              Text(
                                ListLocationAddress[index],
                                style: TextStyle(
                                    fontSize: 14,
                                    color: mainGreyColorTheme,
                                    fontFamily: PoppinsFamily),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Switch(
                          value: SwitchValue[index],
                          onChanged: (value) {
                            setState(() {
                              SwitchValue[index] = value;
                            });
                          }),
                    )
                  ]),
                );
              },
            ),
            SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                    child: Divider(
                  color: lightBorderColor,
                  thickness: 1,
                )),
              ],
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddAddressScreen())),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.add_circle_outlined,
                    color: mainGreyColorTheme,
                    size: 30,
                  ),
                  SizedBox(width: 20),
                  SubTitleText(title: lbl_Add_Address),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
