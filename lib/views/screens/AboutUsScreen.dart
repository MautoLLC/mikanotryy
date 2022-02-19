import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mymikano_app/models/CompanyModels.dart';
import 'package:mymikano_app/services/CompanyService.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/utils/images.dart';
import 'package:mymikano_app/utils/strings.dart';
import 'package:mymikano_app/views/widgets/AppWidget.dart';
import 'package:mymikano_app/views/widgets/TitleText.dart';
import 'package:mymikano_app/views/widgets/TopRowBar.dart';
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

  static const List<String> images = [
    ic_Founder1,
    ic_Founder2,
    ic_Founder3,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
          child: FutureBuilder<List<FounderModel>>(
            future: CompanyService().fetchAboutUsInfo(),
            builder: (context, snapshot) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TopRowBar(title: lbl_About_us),
                  SizedBox(height: 40.0),
                              Text(
                                'Company Profile',
                                style: TextStyle(
                                    fontSize: 18, fontFamily: PoppinsFamily),
                              ),
                              SizedBox(height: 20.0),
                              FutureBuilder<CompanyInfo>(
                                future: CompanyService().fetchCompanyInfo(),
                                builder: (context, snapshot) {
                                  if(snapshot.connectionState == ConnectionState.done){
                                    return Text(
                                    snapshot.data!.companyProfile.toString(),
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: PoppinsFamily,
                                        color: mainGreyColorTheme),
                                  );
                                  } else {
                                    return Center(child: CircularProgressIndicator());
                                  }
                                  
                                }
                              ),
                              SizedBox(height: 20.0),
                              Text(
                                'Get to Know Us',
                                style: TextStyle(
                                    fontSize: 18, fontFamily: PoppinsFamily),
                              ),
                              SizedBox(height: 20.0),
                              ListView.builder(
                                itemCount: Names.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        0.0, 0.0, 0.0, 16.0),
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
                                        padding: const EdgeInsets.fromLTRB(
                                            0.0, 0.0, 0.0, 16.0),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 80,
                                              height: 60,
                                              child: 
                                                  CachedNetworkImage(
                                                    imageUrl: snapshot.data![index].image.toString(),
                                                    height: 10,
                                                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                              Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                                                    errorWidget: (_, __, ___) {
                                                      return SizedBox(height: 10, width: 10);
                                                    },
                                                  ),
                                              decoration: BoxDecoration(
                                                  color: mainGreyColorTheme
                                                      .withOpacity(0.3),
                                                  borderRadius:
                                                      BorderRadius.circular(24)),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  14.3, 0.0, 0.0, 0.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    snapshot.data![index].fullName
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontFamily:
                                                            PoppinsFamily),
                                                  ),
                                                  SizedBox(
                                                    height: 11,
                                                  ),
                                                  Text(
                                                    snapshot.data![index].position
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: PoppinsFamily,
                                                        color:
                                                            mainGreyColorTheme),
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
                              )
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}
