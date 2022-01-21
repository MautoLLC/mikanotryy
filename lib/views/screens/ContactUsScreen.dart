import 'package:flutter/material.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/utils/colors.dart';
import 'package:mymikano_app/utils/images.dart';
import 'package:mymikano_app/utils/strings.dart';
import 'package:mymikano_app/views/widgets/AppWidget.dart';
import 'package:mymikano_app/views/widgets/ImageBox.dart';
import 'package:mymikano_app/views/widgets/T13Widget.dart';
import 'package:mymikano_app/views/widgets/TopRowBar.dart';
import 'package:nb_utils/nb_utils.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  List<String> ListLabels = [lbl_Company_Email, lbl_Company_Address];

  List<String> ListIcons = [ic_Mail, ic_Location];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopRowBar(title: lbl_Contact_Us),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: ListLabels.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                    child: Row(
                      children: [
                        ImageBox(image: ListIcons[index]),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(14.3, 0.0, 0.0, 0.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ListLabels[index],
                                style: TextStyle(
                                    fontSize: 14, fontFamily: PoppinsFamily),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              t13EditTextStyle(lbl_Full_Name, fullNameController),
              SizedBox(
                height: 20,
              ),
              t13EditTextStyle(lbl_hint_Email, emailController),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 50.0),
                  child: TextFormField(
                    expands: true,
                    style: TextStyle(
                        fontSize: textSizeMedium, fontFamily: fontRegular),
                    cursorColor: black,
                    controller: messageController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(26, 14, 4, 14),
                      hintText: 'message',
                      hintStyle: primaryTextStyle(color: black),
                      filled: true,
                      fillColor: t13_edit_text_color,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: t13_edit_text_color, width: 0.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: t13_edit_text_color, width: 0.0),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
                child: T13Button(textContent: 'Send', onPressed: () {}),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
