import 'package:flutter/material.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/utils/images.dart';
import 'package:mymikano_app/utils/strings.dart';
import 'package:mymikano_app/views/widgets/AppWidget.dart';
import 'package:mymikano_app/views/widgets/SubTitleText.dart';
import 'package:mymikano_app/views/widgets/T13Widget.dart';
import 'package:mymikano_app/views/widgets/TitleText.dart';
import 'package:mymikano_app/views/widgets/TopRowBar.dart';
import 'package:nb_utils/nb_utils.dart';

class CardsScreen extends StatefulWidget {
  const CardsScreen({Key? key}) : super(key: key);

  @override
  _CardsScreenState createState() => _CardsScreenState();
}

class _CardsScreenState extends State<CardsScreen> {
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cardHolderNameController = TextEditingController();
  TextEditingController cardExpiryDateController = TextEditingController();
  TextEditingController cardCvvController = TextEditingController();

  List<String> ListIcons = [ic_visa, ic_mastercard];

  List<String> ListCardNumber = ["1423 4242 4242 4242", "1423 4242 4242 6437"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopRowBar(title: lbl_Cards),
            SizedBox(height: 40),
            SubTitleText(title: lbl_Saved_cards),
            SizedBox(height: 10),
            Text("List of all credit cards you saved",
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: PoppinsFamily,
                    color: mainGreyColorTheme)),
            SizedBox(height: 21),
            SizedBox(
              height: 150,
              child: ListView.builder(
                itemCount: ListIcons.length,
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                    child: Row(
                      children: [
                        Container(
                          width: 80,
                          height: 60,
                          child: commonCacheImageWidget(ListIcons[index], 25),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(
                                  mainGreyColorTheme.red,
                                  mainGreyColorTheme.green,
                                  mainGreyColorTheme.blue,
                                  0.3),
                              borderRadius: BorderRadius.circular(24)),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(14.3, 0.0, 0.0, 0.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "*** ${ListCardNumber[index].substring(15, 19)}",
                                style: TextStyle(
                                    fontSize: 14, fontFamily: PoppinsFamily),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            //TODO : Delete Card
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: mainGreyColorTheme,
                                borderRadius: BorderRadius.circular(24)),
                            height: 20,
                            width: 20,
                            child: Icon(
                              Icons.close_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Divider(
                    color: lightBorderColor,
                    thickness: 1,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            SubTitleText(title: lbl_Add_Card_Info),
            SizedBox(height: 10),
            t13EditTextStyle(lbl_Card_Number, cardNumberController,
                isPassword: false),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: t13EditTextStyle(lbl_Valid, cardExpiryDateController,
                        isPassword: false)),
                SizedBox(width: 10),
                Expanded(
                    child: t13EditTextStyle(lbl_CVV, cardCvvController,
                        isPassword: false)),
              ],
            ),
            SizedBox(height: 10),
            t13EditTextStyle(lbl_Card_Name, cardHolderNameController,
                isPassword: false),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: T13Button(
                  textContent: lbl_Add_Card,
                  onPressed: () {
                    // TODO : Add Card
                    finish(context);
                  }),
            )
          ],
        ),
      )),
    );
  }
}
