import 'package:flutter/material.dart';
import 'package:mymikano_app/State/UserState.dart';
import 'package:mymikano_app/models/CompanyModels.dart';
import 'package:mymikano_app/services/CompanyService.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/utils/images.dart';
import 'package:mymikano_app/utils/strings.dart';
import 'package:mymikano_app/views/widgets/ImageBox.dart';
import 'package:mymikano_app/views/widgets/T13Widget.dart';
import 'package:mymikano_app/views/widgets/TopRowBar.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  List<String> ListIcons = [ic_Mail, ic_Location];
  @override
  Widget build(BuildContext context) {
    return Consumer<UserState>(
      builder: (context, state, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TopRowBar(title: lbl_Contact_Us),
                  SizedBox(height: 40.0),
                  FutureBuilder<CompanyInfo>(
                      future: CompanyService().fetchCompanyInfo(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Wrap(
                            spacing: 20,
                            children: [
                              Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        0.0, 0.0, 0.0, 20.0),
                                    child: Row(
                                      children: [
                                        ImageBox(image: ListIcons[0]),
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
                                                snapshot.data!.companyEmail
                                                        .toString(),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: PoppinsFamily),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        0.0, 0.0, 0.0, 20.0),
                                    child: Row(
                                      children: [
                                        ImageBox(image: ListIcons[1]),
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
                                                snapshot
                                                        .data!.companyAddress
                                                        .toString(),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: PoppinsFamily),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              t13EditTextStyle(lbl_Full_Name, fullNameController,
                                  isPassword: false),
                              SizedBox(
                                height: 20,
                              ),
                              t13EditTextStyle(lbl_hint_Email, emailController,
                                  isPassword: false),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: 180,
                                child: Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 50.0),
                                  child: TextFormField(
                                    textAlignVertical: TextAlignVertical.top,
                                    expands: true,
                                    style: TextStyle(
                                        fontSize: textSizeMedium,
                                        fontFamily: PoppinsFamily),
                                    cursorColor: black,
                                    controller: messageController,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.fromLTRB(26, 14, 4, 14),
                                      hintText: 'message',
                                      hintStyle: TextStyle(
                                          height: 1.4, color: textFieldHintColor),
                                      filled: true,
                                      fillColor: lightBorderColor,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 0.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 0.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // Spacer(),
                              T13Button(
                                  textContent: 'Send',
                                  onPressed: () {
                                    state
                                        .sendContactUsRequest(
                                            fullNameController.text,
                                            emailController.text,
                                            messageController.text)
                                        .then((value) {
                                      fullNameController.text = '';
                                      emailController.text = '';
                                      messageController.text = '';
                                    });
                                  }),
                              SizedBox(
                                height: 16,
                              ),
                            ],
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
