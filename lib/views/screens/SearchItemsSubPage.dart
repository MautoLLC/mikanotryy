import 'package:flutter/material.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:mymikano_app/utils/images.dart';
import 'package:mymikano_app/utils/strings.dart';
import 'package:mymikano_app/views/widgets/AppWidget.dart';
import 'package:mymikano_app/views/widgets/SubTitleText.dart';

class SearchItemSubPage extends StatelessWidget {
  const SearchItemSubPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        SubTitleText(title: lbl_Stored_Items),
        SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return Item();
            },
          ),
        ),
      ],
    );
  }
}

class Item extends StatelessWidget {
  const Item({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(color: lightBorderColor, width: 1))),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                // TODO Open category page
              },
              child: Container(
                alignment: Alignment.center,
                decoration: boxDecoration(
                    radius: 33,
                    showShadow: true,
                    bgColor: mainGreyColorTheme.withOpacity(0.3)),
                child: commonCacheImageWidget(
                  t3_mcb,
                  60,
                  width: 80,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Philips led bulb",
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Poppins",
                    color: mainBlackColorTheme,
                  ),
                ),
                SizedBox(
                  height: 11,
                ),
                Text(
                  "Code-2344",
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Poppins",
                    color: mainGreyColorTheme,
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "\$14.88",
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Poppins",
                    color: mainBlackColorTheme,
                  ),
                ),
                SizedBox(
                  height: 7,
                ),
                GestureDetector(
                  onTap: () {
                    // TODO logic
                  },
                  child: commonCacheImageWidget(ic_Cart, 24),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
