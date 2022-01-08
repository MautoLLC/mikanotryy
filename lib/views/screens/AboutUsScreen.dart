import 'package:flutter/material.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/views/widgets/TitleText.dart';
import 'package:nb_utils/nb_utils.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  static const List<String> Names = [
    'Rachel Hasting',
    'Henrique Proba',
    'Melody Walker',
  ];

  static const List<String> Titles = [
    'Chief Technical Officer',
    'Chief Technology Officer',
    'Chief Financial Officer',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 40.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: backArrowColor,
                      ),
                      onPressed: () {
                        finish(context);
                      },
                    ),
                    Spacer(),
                    TitleText(
                      title: 'About Us',
                    ),
                    Spacer(),
                    Spacer(),
                  ],
                ),
              ),
              Text(
                'Company Profile',
                style: TextStyle(fontSize: 18, fontFamily: PoppinsFamily),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 11.0, 0.0, 30.0),
                child: Text(
                  'One of the fastest-growing private company in the world.  Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: PoppinsFamily,
                      color: mainGreyColorTheme),
                ),
              ),
              Text(
                'Get to Know Us',
                style: TextStyle(fontSize: 18, fontFamily: PoppinsFamily),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                child: ListView.builder(
                  itemCount: Names.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: index != Names.length - 1
                                  ? lightBorderColor
                                  : Colors.transparent,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
                          child: Row(
                            children: [
                              Container(
                                width: 80,
                                height: 60,
                                child: Text(''),
                                // child: commonCacheImageWidget(listmrequestsViewModel
                                //             .maintenanceRequests![index]
                                //             .mMaintenacerequest!
                                //             .maintenanceCategory!
                                //             .maintenanceCategoryIcon, 25),
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(
                                        mainGreyColorTheme.red,
                                        mainGreyColorTheme.green,
                                        mainGreyColorTheme.blue,
                                        0.3),
                                    borderRadius: BorderRadius.circular(24)),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    14.3, 0.0, 0.0, 0.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      Names[index],
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: PoppinsFamily),
                                    ),
                                    Text(
                                      Titles[index],
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: PoppinsFamily,
                                          color: mainGreyColorTheme),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
