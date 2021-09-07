import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:mymikano_app/viewmodels/DashBoard_ModelView.dart';

class ToggleButton_Row extends StatefulWidget {
  //const ToggleButton_Row({required this.status=status}) : super(key: key);
  bool status;
  bool power;
  DashBoard_ModelView DashBoardModelView;
  ToggleButton_Row(
      {required this.status,
      required this.power,
      required this.DashBoardModelView});

  @override
  _ToggleButton_RowState createState() => _ToggleButton_RowState();
}

class _ToggleButton_RowState extends State<ToggleButton_Row> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              Text("Mode",
                  style: TextStyle(
                    fontSize: 16.0,
                    //fontStyle: FontStyle.italic,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                  )),
              Spacer(),
              FlutterSwitch(
                activeText: "Auto",
                inactiveText: "Manual",
                value: widget.status,
                activeColor: Colors.white,
                inactiveColor: Colors.white,
                activeTextColor: Color(Colors.grey[700]!.value),
                inactiveTextColor: Color(Colors.grey[700]!.value),
                toggleColor: Color(Colors.grey[700]!.value),
                switchBorder:
                    Border.all(color: Color(Colors.grey[700]!.value), width: 1),
                valueFontSize: 10.0,
                width: 80,
                height: 30,
                borderRadius: 30.0,
                showOnOff: true,
                onToggle: (val) {
                  setState(() {
                    widget.status = val;
                    //change the mode to manual//
                    widget.DashBoardModelView.SwitchControllerMode(
                        widget.status);
                    //and then let the second toggle for on and off appear//
                  });
                },
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        if (!widget.status)
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                Text("Generator",
                    style: TextStyle(
                      fontSize: 16.0,
                      //fontStyle: FontStyle.italic,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                    )),
                Spacer(),
                FlutterSwitch(
                  activeText: "On",
                  inactiveText: "Off",
                  value: widget.power,
                  activeColor: Colors.white,
                  inactiveColor: Colors.white,
                  activeTextColor: Color(Colors.grey[700]!.value),
                  inactiveTextColor: Color(Colors.grey[700]!.value),
                  toggleColor: Color(Colors.grey[700]!.value),
                  switchBorder: Border.all(
                      color: Color(Colors.grey[700]!.value), width: 1),
                  valueFontSize: 10.0,
                  width: 80,
                  height: 30,
                  borderRadius: 30.0,
                  showOnOff: true,
                  onToggle: (val) {
                    setState(() {
                      widget.power = val;
                      //turn off or on generator//
                      widget.DashBoardModelView.SwitchOnOff(widget.power);
                    });
                  },
                ),
              ],
            ),
          ),
      ],
    );
  }
}
