import 'package:flutter/material.dart';
import 'package:mymikano_app/utils/AppColors.dart';

class AlarmPage extends StatelessWidget {
  AlarmPage({Key? key}) : super(key: key);

  List<bool> state = [
    true,
    false,
    true,
    true,
    false,
    true,
    true,
    false,
    true,
    true,
    false,
    true,
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 40.0),
      child: ListView.builder(
        itemCount: 12,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: lightBorderColor,
                  width: 0.5,
                ),
              ),
            ),
            child: Row(
              children: [
                Text('Alarm $index'),
                Spacer(),
                AlarmSwicth(
                  state: state[index],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class AlarmSwicth extends StatefulWidget {
  bool state;
  AlarmSwicth({Key? key, required this.state}) : super(key: key);

  @override
  State<AlarmSwicth> createState() => _AlarmSwicthState();
}

class _AlarmSwicthState extends State<AlarmSwicth> {
  @override
  Widget build(BuildContext context) {
    return Switch(
        value: widget.state,
        onChanged: (value) {
          setState(() {
            widget.state = value;
          });
        });
  }
}
