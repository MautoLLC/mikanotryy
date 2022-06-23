import 'package:flutter/material.dart';
import 'package:mymikano_app/State/ProductState.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:mymikano_app/utils/strings.dart';
import 'package:mymikano_app/views/widgets/NotificationBell.dart';
import 'package:mymikano_app/views/widgets/T13Widget.dart';
import 'package:mymikano_app/views/widgets/TitleText.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import 'SearchCategoriesSubPage.dart';
import 'SearchItemsSubPage.dart';
//TODO Unused
class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController SearchController = new TextEditingController();
  bool guestLogin = true;

  bool ifAlreadyInitialized = false;

  init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    guestLogin = await prefs.getBool("GuestLogin")!;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductState>(
      builder: (context, state, child) {
        return Scaffold(
            body: DefaultTabController(
          length: 2,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: TitleText(
                          title: lbl_Search,
                        ),
                      ),
                      if (!guestLogin)
                        Align(
                          alignment: Alignment.centerRight,
                          child: NotificationBell(),
                        )
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      Expanded(
                          child: t13EditTextStyle(lbl_Search, SearchController,
                              isPassword: false))
                    ],
                  ),
                  SizedBox(height: 40.0),
                  Text(
                    lbl_num_of_item_stored,
                    style: TextStyle(fontSize: 15, color: mainGreyColorTheme),
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: [
                      Text(
                        state.allProductNumbers.toString(),
                        style:
                            TextStyle(fontSize: 32, color: mainBlackColorTheme),
                      ),
                      SizedBox(width: 23.0),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 5.0),
                        decoration: BoxDecoration(
                            color: GreenColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12)),
                        child: Text(
                          "+15",
                          style: TextStyle(fontSize: 10, color: GreenColor),
                        ),
                      )
                    ],
                  ),
                  TabBar(
                    padding: EdgeInsets.zero,
                    indicatorPadding: EdgeInsets.zero,
                    labelPadding: EdgeInsets.zero,
                    indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(
                        width: 4.0,
                        color: mainColorTheme,
                      ),
                      insets: EdgeInsets.fromLTRB(0.0, 0.0, 150.0, 0.0),
                    ),
                    indicatorColor: mainColorTheme,
                    indicatorWeight: 4,
                    labelStyle: boldTextStyle(color: mainBlackColorTheme),
                    tabs: [
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              lbl_Items,
                              style: TextStyle(color: mainBlackColorTheme),
                            ),
                          ],
                        ),
                      ),
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              lbl_Categories,
                              style: TextStyle(color: mainBlackColorTheme),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(children: [
                      SearchItemSubPage(),
                      // SearchCategoriesSubPage()
                    ]),
                  )
                ],
              ),
            ),
          ),
        ));
      },
    );
  }
}
