import 'package:flutter/material.dart';
import 'package:mymikano_app/State/UserState.dart';
import 'package:mymikano_app/models/RealEstateModel.dart';
import 'package:mymikano_app/models/TechnicianModel.dart';
import 'package:mymikano_app/services/FetchRealEstatesService.dart';
import 'package:mymikano_app/services/UserService.dart';
import 'package:mymikano_app/utils/strings.dart';
import 'package:mymikano_app/views/widgets/SubTitleText.dart';
import 'package:mymikano_app/views/widgets/TopRowBar.dart';
import 'package:provider/provider.dart';

class UserDetailsPage extends StatelessWidget {
  int realEstateId;
  String userId;
  UserDetailsPage({required this.realEstateId, required this.userId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TechnicianModel>(
        future: UserService().GetUserInfoByID(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: SafeArea(
                    child: Column(
                  children: [
                    TopRowBar(title: lbl_User_Details),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SubTitleText(title: lbl_UserName),
                        Text(snapshot.data!.username.toString())
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SubTitleText(title: lbl_Phone_Number),
                        Text(snapshot.data!.phoneNumber)
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SubTitleText(title: lbl_Email),
                        Text(snapshot.data!.email)
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SubTitleText(title: lbl_Address),
                        FutureBuilder<RealEstate>(
                            future: RealEstatesService()
                                .fetchRealEstatesById(this.realEstateId),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return Text(snapshot.data!.realEstateAddress);
                              } else {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                            })
                      ],
                    )
                  ],
                )),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
