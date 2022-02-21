import 'package:flutter/material.dart';
import 'package:mymikano_app/State/RequestFormState.dart';
import 'package:mymikano_app/models/ComponentModel.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:provider/provider.dart';

class ComponentItem extends StatelessWidget {
  late ComponentModel Component;
  bool deletable;
  ComponentItem({Key? key, required this.Component, required this.deletable}) : super(key: key);

  switchColor(String status){
    switch(status.toLowerCase()){
      case "satisfactory":
        return DoneColor;
      case "Approved":
        return AssignedColor;
      case "Rejected":
        return PendingColor;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RequestFormState>(
      builder: (context, state, child) => Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(7), border: Border.all(color: switchColor(Component.status.toString()))),
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(Component.componentName.toString()),
              deletable?
                IconButton(
                    onPressed: () {
                      state.selectItem(state.selectedItems.firstWhere((element) => element.Component.idComponent == Component.idComponent));
                    },
                    icon: Icon(
                      Icons.close,
                      color: switchColor(Component.status.toString()),
                    )):Container()
            ],
          ),
        ),
      ),
    );
  }
}
