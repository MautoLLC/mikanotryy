import 'package:flutter/material.dart';
import 'package:mymikano_app/State/InspectionsState.dart';
import 'package:mymikano_app/State/RequestFormState.dart';
import 'package:mymikano_app/models/ComponentModel.dart';
import 'package:mymikano_app/services/MaintenanceRequestsService.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:mymikano_app/utils/strings.dart';
import 'package:mymikano_app/views/widgets/SubTitleText.dart';
import 'package:mymikano_app/views/widgets/TopRowBar.dart';
import 'package:provider/provider.dart';

class ComponentDetailScreen extends StatefulWidget {
  ComponentModel item;
  String inspectionStatus;
  ComponentDetailScreen({required this.item, required this.inspectionStatus});

  @override
  State<ComponentDetailScreen> createState() => _ComponentDetailScreenState();
}

class _ComponentDetailScreenState extends State<ComponentDetailScreen> {
  List<String> statuses = [
    "good",
    "poor",
    "repair",
    "satisfactory",
    "replace",
    "N/A",
    "awaiting"
  ];

  List<Color> statusesColors = [
    Colors.green,
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.blue,
    Colors.grey,
    Colors.purple
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(children: [
          TopRowBar(title: lbl_Component_Details),
          SizedBox(
            height: 16.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SubTitleText(
                title: lbl_Name,
              ),
              Text(this.widget.item.componentName.toString())
            ],
          ),
          SizedBox(
            height: 16.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SubTitleText(
                title: lbl_Description,
              ),
              Text(this.widget.item.componentDescription.toString())
            ],
          ),
          SizedBox(
            height: 16.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SubTitleText(
                title: lbl_Price,
              ),
              Text(this.widget.item.componentUnitPrice.toString())
            ],
          ),
          SizedBox(
            height: 16.0,
          ),
          Container(
            color: lightBorderColor,
            height: 1,
          ),
          SizedBox(
            height: 16.0,
          ),
          Expanded(
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                ),
                itemCount: statuses.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if(this.widget.inspectionStatus!="Done"){
                        MaintenanceRequestService().ChangeComponentStatusByID(
                          this.widget.item.idChecklist!.toInt(), index + 1);
                      Provider.of<RequestFormState>(context, listen: false)
                          .updateComponentStatus(
                              this.widget.item.idComponent!, statuses[index]);
                      setState(() {});
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: this.widget.item.status!.toLowerCase() ==
                                statuses[index]
                            ? statusesColors[index]
                            : Colors.transparent,
                        border: Border.all(
                            color: this.widget.item.status!.toLowerCase() ==
                                    statuses[index]
                                ? statusesColors[index]
                                : lightBorderColor,
                            width: 1),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Center(
                        child: Text(
                          statuses[index],
                          style: TextStyle(
                              color: this.widget.item.status!.toLowerCase() ==
                                      statuses[index]
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                    ),
                  );
                }),
          )
        ]),
      )),
    );
  }
}
