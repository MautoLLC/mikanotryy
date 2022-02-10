import 'package:flutter/material.dart';
import 'package:mymikano_app/models/DashboardCardModel.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:mymikano_app/utils/DataGenerator.dart';
import 'package:mymikano_app/utils/strings.dart';
import 'package:mymikano_app/views/widgets/AppWidget.dart';
import 'package:mymikano_app/views/widgets/SubTitleText.dart';

import 'ListPage.dart';

class SearchCategoriesSubPage extends StatelessWidget {
  SearchCategoriesSubPage({Key? key}) : super(key: key);
  List<T5Category> mFavouriteList = getDItems();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        SubTitleText(title: lbl_Shop_by_Category),
        SizedBox(height: 10),
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.7,
              crossAxisSpacing: 10.0,
            ),
            itemCount: 5,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          // TODO Open category page
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ListPage(title: mFavouriteList[index].name,)));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: boxDecoration(
                              radius: 33,
                              showShadow: false,
                              bgColor: mainGreyColorTheme.withOpacity(0.3)),
                          child: commonCacheImageWidget(
                            mFavouriteList[index].icon,
                            60,
                            width: 80,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      mFavouriteList[index].name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
