import 'package:flutter/material.dart';
import 'package:mymikano_app/State/UserState.dart';
import 'package:mymikano_app/models/RealEstateModel.dart';
import 'package:mymikano_app/services/FetchRealEstatesService.dart';
import 'package:mymikano_app/utils/strings.dart';
import 'package:mymikano_app/views/widgets/SubTitleText.dart';
import 'package:mymikano_app/views/widgets/TopRowBar.dart';
import 'package:provider/provider.dart';

class UserDetailsPage extends StatelessWidget {
  int realEstateId;
  UserDetailsPage({required this.realEstateId});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserState>(
      builder: (context, state, child) => Scaffold(
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
                  Text(state.User.username)
                ],
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SubTitleText(title: lbl_Phone_Number),
                  Text(state.User.phoneNumber)
                ],
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SubTitleText(title: lbl_Email),
                  Text(state.User.email)
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
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Text(snapshot.data!.realEstateAddress);
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      })
                ],
              )
            ],
          )),
        ),
      ),
    );
  }
}
