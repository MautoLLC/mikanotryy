import 'package:flutter/material.dart';
import 'package:mymikano_app/models/ComponentStatusModel.dart';
import 'package:mymikano_app/models/InspectionChecklistItem.dart';
import 'package:mymikano_app/models/InspectionModel.dart';
import 'package:mymikano_app/models/MaintenaceCategoryModel.dart';
import 'package:mymikano_app/services/ChangeComponentStatusService.dart';
import 'package:mymikano_app/utils/QiBusConstant.dart';
import 'package:mymikano_app/viewmodels/LIstComponentStatusViewModel.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:mymikano_app/utils/colors.dart';
import 'package:mymikano_app/utils/AppWidget.dart';
import 'Booking.dart';
import 'InspectionScreen.dart';

class BankingShareInformation extends StatefulWidget {
  static var tag = "/BankingShareInformation";
  late final InspectionChecklistItem? checklistItem;
  late final InspectionModel mInspection;
  Categ category;
  List<ComponentStatusViewModel> statusList=[];
  BankingShareInformation({ Key? key, required this.checklistItem, required this.mInspection,required this.statusList,required this.category}) : super(key: key);

  @override
  _BankingShareInformationState createState() => _BankingShareInformationState();
}

class _BankingShareInformationState extends State<BankingShareInformation> {

  late String defaultValue ;
  late String currentValue ;
  late int idStsSelected;

  int mIsSelect = 0;

  var mTime = 0;
  int _selected =0;
  @override
  void initState() {
    defaultValue = widget.checklistItem!.componentStatus!.componentStatusDescription;
    currentValue= widget.checklistItem!.componentStatus!.componentStatusDescription;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("helloi");
    print(this.widget.statusList.length);
    print("hellpp");
    print(this.widget.statusList[0].mcomponentStatus!.componentStatusDescription.toString());
    return Scaffold(
      // backgroundColor: Banking_app_Background,
      body: Container(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              30.height,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  30.height,
                  Text(widget.checklistItem!.customComponent.componentName +"\nDetails", style: boldTextStyle(size: 30, color: Banking_TextColorPrimary)),
                ],
              ),
              20.height,

              20.height,
              ticketInfo(t13_name, widget.checklistItem!.customComponent.componentName ,Colors.black),

              Divider(height: 24),
              ticketInfo(t13_description ,widget.checklistItem!.customComponent.componentDescription ,Colors.black),


              Divider(height: 24),

              ticketInfo(t13_provider,widget.checklistItem!.customComponent.componentProvider ,Colors.black),

              Divider(height: 24),
              ticketInfo(t13_unit_price,"\$"+widget.checklistItem!.customComponent.componentUnitPrice.toString() ,Colors.black),

              Divider(height: 24),
              text(t13_status),
              GridView.builder(

                scrollDirection: Axis.vertical,
                itemCount: this.widget.statusList.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {

                  return Container(
                      padding: EdgeInsets.only(top: 8, bottom: 8),
                      // padding: EdgeInsets.all(8),
                      // margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: currentValue == this.widget.statusList[index].mcomponentStatus!.componentStatusDescription ? switchColor(this.widget.statusList[index].mcomponentStatus!.componentStatusDescription.toString()) : Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: currentValue == this.widget.statusList[index].mcomponentStatus!.componentStatusDescription.toString() ? white : grey),
                      ),
                      child: Center(child:Text(this.widget.statusList[index].mcomponentStatus!.componentStatusDescription.toString(), style: primaryTextStyle(color: currentValue == this.widget.statusList[index].mcomponentStatus!.componentStatusDescription.toString() ? white : grey)),
                      )).onTap(() {
                         idStsSelected=this.widget.statusList[index].mcomponentStatus!.idComponentStatus;
                    mIsSelect = index;
                    setState(() {
                      currentValue = this.widget.statusList[index].mcomponentStatus!.componentStatusDescription.toString();
                    });
                  }, splashColor: white);
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 8, crossAxisSpacing:8, childAspectRatio: 3),
                // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1, mainAxisSpacing:16, crossAxisSpacing:16, childAspectRatio: 8),
              ),
              40.height,
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        // finish(context);
                        _cancel();
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: 8, bottom: 8),
                        decoration: BoxDecoration(border: Border.all(color: food_textColorPrimary), borderRadius: BorderRadius.circular(24)),
                        child: Text(t13_cancel, style: primaryTextStyle()).center(),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        // finish(context);
                        _save();
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: 8, bottom: 8),
                        decoration: BoxDecoration(color: t5Cat3, borderRadius: BorderRadius.circular(24)),
                        child: Text(t13_save, style: primaryTextStyle(color: food_white)).center(),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _save() async {
    // toast(currentValue);
    // toast(widget.checklistItem!.idInspectionChecklistItem!.toString());
   // toast(idStsSelected.toString());
    await  changeChecklistItemStatus(widget.checklistItem!.idInspectionChecklistItem!, idStsSelected);
    //finish(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => T13InspectionScreen(mInspection:widget.mInspection,statusList: this.widget.statusList,category: this.widget.category,),
      ),
    );
  }
  _cancel() async {

    currentValue=defaultValue;
    toast(currentValue);
    finish(context);
    // Navigator.pop(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => T13InspectionScreen(),
    //   ),
    // );

  }

  switchColor<Color>(String status) {

      if (status.toUpperCase() ==this.widget.statusList[5].mcomponentStatus!.componentStatusDescription.toString().toUpperCase()) {
        return Colors.grey;
      }
      else if (status.toUpperCase() == this.widget.statusList[4].mcomponentStatus!.componentStatusDescription.toString().toUpperCase()) {
        return Colors.amberAccent;
      }
      else if (status.toUpperCase() == this.widget.statusList[1].mcomponentStatus!.componentStatusDescription.toString().toUpperCase()) {
        return Colors.red;
      }
      else if (status.toUpperCase() == this.widget.statusList[2].mcomponentStatus!.componentStatusDescription.toString().toUpperCase()) {
        return Colors.orange;
      }
      else if (status.toUpperCase() ==this.widget.statusList[0].mcomponentStatus!.componentStatusDescription.toString().toUpperCase()) {
        return Colors.blue;
      }
      else if (status.toUpperCase() == this.widget.statusList[3].mcomponentStatus!.componentStatusDescription.toString().toUpperCase()) {
        return Colors.green;
      }
      else {
        return Colors.grey;
      }

  }
}