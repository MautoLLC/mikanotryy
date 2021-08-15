import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mymikano_app/models/ComponentModel.dart';
import 'package:mymikano_app/models/InspectionModel.dart';
import 'package:mymikano_app/services/AddCustomComponentService.dart';
import 'package:mymikano_app/utils/QiBusConstant.dart';
import 'package:mymikano_app/viewmodels/LIstComponentStatusViewModel.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:mymikano_app/models/QiBusModel.dart';
import 'package:mymikano_app/utils/colors.dart';
import 'package:mymikano_app/utils/AppWidget.dart';
import 'Booking.dart';
import 'package:mymikano_app/viewmodels/ListInspectionChecklistItemsViewModel.dart';
import 'ComponentDetailsScreen.dart';


class T13InspectionScreen extends StatefulWidget {
  static String tag = '/T13DescriptionScreen';
  late final String title;
  InspectionModel mInspection;
  List<ComponentStatusViewModel> statusList=[];
  T13InspectionScreen({Key? key, required this.mInspection, required this.statusList}) : super(key: key);
  @override
  T13InspectionScreenState createState() => T13InspectionScreenState();
}

class T13InspectionScreenState extends State<T13InspectionScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  ComponentModel _component = new ComponentModel(componentName: '',componentDescription: '', componentProvider: '', componentUnitPrice: 0);

  final _formKey = GlobalKey<FormState>();


  var holder_1 = [];


  bool selected=true ;

  late Future fetchchecklist;
  
  late QIBusBookingModel mList;
  ListInspectionChecklistItemsViewModel icvm=new ListInspectionChecklistItemsViewModel();
  @override
  void initState() {
    super.initState();
    init();
    fetchchecklist=icvm.fetchInspectionItems(this.widget.mInspection.idInspection);

  }

  init() async {
    if(this.widget.mInspection != null)
    mList = QIBusBookingModel(this.widget.mInspection.technicianID.toString(), this.widget.mInspection.inspectionStartTime.toString(), this.widget.mInspection.inspectionDuration.toString(), this.widget.mInspection.inspectionComments.toString());
else
mList=QIBusBookingModel("", "", ""," ");
    setState(() {});
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  _refreshAction() {
    setState(() {
      fetchchecklist=icvm.fetchInspectionItems(this.widget.mInspection.idInspection) ;
    });
  }

  @override
  Widget build(BuildContext context) {

    changeStatusColor(Colors.black);
    return Scaffold(
      key: _scaffoldKey,

      body: SafeArea(

        child:SingleChildScrollView(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.all(8),
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.arrow_back_rounded) ,
                          onPressed: () {
                            finish(context);
                          },
                        ),

                        SizedBox(width: 10),

                        text("Inspection", fontSize: textSizeNormal),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(spacing_standard_new),
                    child:Container(
                      margin: EdgeInsets.all(spacing_standard_new),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child:Booking(mList),
                          ),
                          SizedBox(height:20),
                          Container(
                            padding: EdgeInsets.all(spacing_middle),
                            decoration: boxDecoration(showShadow: true, bgColor: Colors.white, radius: 30),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                            children: <Widget>[
                              text("Category ", fontFamily: 'Medium',textColor: Colors.black).paddingAll(8),
                                  Container(
                                    decoration: BoxDecoration(  color:Colors.white, borderRadius: BorderRadius.circular(12.0),boxShadow: [BoxShadow(blurRadius:7,color: Colors.black12 ,offset: Offset(3,3))]),
                                    padding: EdgeInsets.fromLTRB(spacing_standard_new, spacing_control, spacing_standard_new, spacing_control),
                                    child: text(this.widget.mInspection.maintenanceRequestID.toString(), textColor: t5Cat1),
                                  ),]),
                                  SizedBox(height:10),
                                  text("Inspection Checklist", fontFamily: 'Medium',textColor: Colors.black).paddingAll(8),
                                  SizedBox(height:8),

                                      FutureBuilder(
                                      future: fetchchecklist,
                                      builder: (BuildContext context,  snapshot) {
                                      if(snapshot.connectionState == ConnectionState.done) {
                                      if (snapshot.hasError) {
                                      return Text('${snapshot.error}');
                                      }
                                       return
                                             ListView.builder(

                                      itemCount: icvm.inpectionItems!.length,

                                      physics:BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (BuildContext context, int index) {
                                        return  Container(

                                            child: Card(
                                                margin: EdgeInsets.symmetric(vertical: 5),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(20),
                                                ),
                                                child: new ListTile(

                                                  shape:RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),

                                                  title: new Text( icvm.inpectionItems![index].inspectionchecklistItem!.customComponent.componentName.toString()),
                                                  leading: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: <Widget>[
                                                        icvm.inpectionItems![index].inspectionchecklistItem!.componentStatus!.componentStatusDescription.toString()== "satisfactory"? Icon(Icons.check_box_rounded, color: Colors.green,size: 24,):Icon(Icons.check_box_outline_blank_rounded, size: 24,),
                                                      ]
                                                  ),
                                                  trailing: Icon(Icons.keyboard_arrow_right),
                                                  subtitle:
                                                  Row(
                                                    children: <Widget>[
                                                      Expanded(
                                                          flex: 1,
                                                          child: Container(
                                                            child: LinearProgressIndicator(
                                                                backgroundColor: Color.fromRGBO(209, 224, 224, 0.2),
                                                                value: 2,
                                                                valueColor:
                                                                // ComponentList[index].status == "Satisfactory"?
                                                                AlwaysStoppedAnimation(switchColor(icvm.inpectionItems![index].inspectionchecklistItem!.componentStatus!.componentStatusDescription.toString()))),

                                                          )),

                                                      Expanded(
                                                        flex: 4,
                                                        child: Padding(
                                                            padding: EdgeInsets.only(left: 10.0),
                                                            child: Text(icvm.inpectionItems![index].inspectionchecklistItem!.componentStatus!.componentStatusDescription.toString())),
                                                      )
                                                    ],
                                                  ),
                                                    onTap: () =>  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) => BankingShareInformation(checklistItem: icvm.inpectionItems![index].inspectionchecklistItem,mInspection: this.widget.mInspection,statusList: this.widget.statusList,),
                                                      ),
                                                    )
                                                )
                                            ),
                                            decoration: new BoxDecoration(
                                              borderRadius: BorderRadius.circular(20.0),
                                              boxShadow: [BoxShadow(blurRadius:7,color: Colors.black12 ,offset: Offset(3,3))],
                                            ));
                                      }
                                  ); }
                             else   return Center( child: const CircularProgressIndicator(),); } ),
                                  SizedBox(height:20),
                                  SizedBox(
                                      width: double.infinity,
                                      height: 50,
                                      child: RaisedButton.icon(
                                        onPressed: (){
                                          mFormBottomSheet(context);
                                        },
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                        label: Text('Add new custom component',
                                          style: TextStyle(color: Colors.white),),
                                        icon: Icon(Icons.add, color:Colors.white),
                                        textColor: Colors.white,
                                        splashColor: t5Cat3.withOpacity(0.7),
                                        color: t5Cat3,
                                      )),
                                ]),
                          ),
                          SizedBox(height: 40),

                        ],
                      ),
                    ),
                  ),
                ])
        ),

      ),

    );
  }

  switchColor<Color>(String status) {
    if (status.toUpperCase() == "N/A".toUpperCase()) {
      return Colors.grey;
    }
    else if (status.toUpperCase() == 'poor'.toUpperCase()) {
      return Colors.yellow;
    }
    else if (status.toUpperCase() == 'repair'.toUpperCase()) {
      return Colors.red;
    }
    else if (status.toUpperCase() == 'good'.toUpperCase()) {
      return Colors.orange;
    }
    else if (status.toUpperCase() == 'replace'.toUpperCase()) {
      return Colors.blue;
    }
    else if(status.toUpperCase() == 'satisfactory'.toUpperCase()) {
      return Colors.green;
    }
    else{
      return Colors.grey;
    }
  }


  _onSubmit() async {
    var form = _formKey.currentState;
    if (form!.validate()) {
      form.save();

    //  ComponentList.add(Component(0,_component.name,_component.description,"",0.0,"poor"));
       ComponentModel c=new ComponentModel(componentName: _component.componentName,componentDescription:_component.componentDescription ,componentProvider:"" , componentUnitPrice: 0);
     await AddCustomComponentService(c,this.widget.mInspection.idInspection);

    setState(() {
      fetchchecklist= icvm.fetchInspectionItems(this.widget.mInspection.idInspection);});
      toast("Component "+_component.componentName+" added successfully !");
      form.reset();
    }
  }



  mFormBottomSheet(BuildContext aContext) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: aContext,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
            child: Container(
            padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)), color:t5White),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height:57,
                    decoration: BoxDecoration(
                        color: t5Cat3, // or some other color
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24.0),
                            topRight: Radius.circular(24.0)
                        )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Text('Add Custom Component', style: primaryTextStyle(size: 18,color:Colors.white))

                      ],
                    ).paddingAll(15.0),
                  ),

                  8.height,
                Padding(
                    padding: const EdgeInsets.only(bottom :0.0),
                  child:Container(
                    color:Colors.white,
                    padding: EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Task/Job Name",
                            style: primaryTextStyle(color: Colors.black),
                          ),
                          8.height,
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: TextFormField(
                              style: TextStyle(fontSize: 16, fontFamily: fontRegular),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(24, 16, 24, 16),
                                hintText: "Enter Name",
                                hintStyle: primaryTextStyle(color: grey),
                                filled: true,
                                fillColor:Colors.white,
                                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Color(0xFFA8ABAD), width: 1.0)),
                                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Color(0xFFA8ABAD), width: 1.0)),
                              ),
                              validator: (val) =>
                              (val!.length == 0 ? 'This field is mandatory' : null),
                              onSaved: (val) => setState(() => _component.componentName = val!),
                            ),
                          ),
                          16.height,
                          Text(
                            "Task/Job Description",
                            style: primaryTextStyle(color:Colors.black),
                          ),
                          8.height,
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: TextFormField(
                              maxLines: 3,
                              style: TextStyle(fontSize: 16, fontFamily: fontRegular),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(24, 16, 24, 16),
                                hintText: "Enter Description",
                                hintStyle: primaryTextStyle(color: grey),
                                filled: true,
                                fillColor:Colors.white,
                                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Color(0xFFA8ABAD), width: 1.0)),
                                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Color(0xFFA8ABAD), width: 1.0)),
                              ),
                              validator: (val) =>
                              (val!.length == 0 ? 'This field is mandatory' : null),
                              onSaved: (val) => setState(() => _component.componentDescription = val!),
                            ),
                          ),


                          30.height,
                          GestureDetector(
                            onTap: () {

                              _onSubmit();
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: boxDecoration(bgColor: t5Cat3, radius: 20),
                              padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                              child: Center(
                                child: Text(
                                  "Submit",
                                  style: primaryTextStyle(color: white),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ) )]) ));
      },
    );
  }

}
