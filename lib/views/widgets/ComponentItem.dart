import 'package:flutter/material.dart';
import 'package:mymikano_app/State/RequestFormState.dart';
import 'package:mymikano_app/models/ComponentModel.dart';
import 'package:mymikano_app/services/ComponentService.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:mymikano_app/views/screens/ComponentDetailScreen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class ComponentItem extends StatelessWidget {
  late ComponentModel Component;
  bool deletable;
  ComponentItem({Key? key, required this.Component, required this.deletable})
      : super(key: key);

  List<String> statuses = [
    "Good",
    "Poor",
    "Repair",
    "Satisfactory",
    "Replace",
    "N/A",
    "Awaiting"
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

  switchColor(String status) {
    switch (status.toLowerCase()) {
      case "good":
        return Colors.green;
      case "poor":
        return Colors.red;
      case "repair":
        return Colors.orange;
      case "satisfactory":
        return Colors.yellow;
      case "Replace":
        return Colors.blue;
      case "N/A":
        return Colors.grey;
      case "awaiting":
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RequestFormState>(
      builder: (context, state, child) => Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(7),
            border:
                Border.all(color: switchColor(Component.status.toString()))),
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(Component.componentName.toString()),
              deletable
                  ? IconButton(
                      onPressed: () {
                        ComponentService()
                            .deleteComponent(Component.idComponent!)
                            .then((value) {
                          if (value) {
                            toast("Component deleted");
                            state.deleteComponentById(Component.idComponent!);
                          } else {
                            toast("Error deleting component");
                          }
                        });
                      },
                      icon: Icon(
                        Icons.close,
                        color: switchColor(Component.status.toString()),
                      ))
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
