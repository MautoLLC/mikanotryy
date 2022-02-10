import 'package:flutter/material.dart';
import 'package:mymikano_app/State/UserState.dart';
import 'package:mymikano_app/models/StoreModels/AddressModel.dart';
import 'package:mymikano_app/services/StoreServices/CustomerService.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/utils/images.dart';
import 'package:mymikano_app/utils/strings.dart';
import 'package:mymikano_app/views/widgets/ImageBox.dart';
import 'package:mymikano_app/views/widgets/SubTitleText.dart';
import 'package:mymikano_app/views/widgets/TopRowBar.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:provider/provider.dart';

import 'AddAddressScreen.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserState>(
      builder: (context, state, child) => Scaffold(
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              TopRowBar(title: lbl_Address),
              SizedBox(height: 30),
              FutureBuilder(
                future: CustomerService().GetShippingAddressesForLoggedInUser(),
                builder: (context, AsyncSnapshot<List<Address>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                          child: Stack(children: [
                            Row(
                              children: [
                                ImageBox(
                                  image: ic_Location_Pin,
                                  color: Colors.black,
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      14.3, 0.0, 0.0, 0.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data!
                                            .elementAt(index)
                                            .city
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: mainBlackColorTheme,
                                            fontFamily: PoppinsFamily),
                                      ),
                                      SizedBox(height: 11),
                                      Text(
                                        snapshot.data!
                                            .elementAt(index)
                                            .address1
                                            .toString(),
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
                                  value: snapshot.data!.elementAt(index).chosen,
                                  onChanged: (value) {
                                    state.addAddress(
                                        snapshot.data!
                                            .elementAt(index)
                                            .address1
                                            .toString(),
                                        snapshot.data!
                                            .elementAt(index)
                                            .city
                                            .toString());
                                  }),
                            )
                          ]),
                        );
                      },
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
              SizedBox(height: 4),
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
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AddAddressScreen())),
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
      ),
    );
  }
}
