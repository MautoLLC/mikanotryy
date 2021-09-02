import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class InputOutput_Row extends StatelessWidget {
  int Value;
  InputOutput_Row({required this.Value});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
      child: Column(
        children: [
          Container(
            height: 30,
            color: Colors.grey[200],
            child: Row(
              children: [
                Expanded(flex: 1, child: Text('1')),
                Expanded(
                    flex: 5,
                    child: Text(
                      'GCB FeedBack',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                Expanded(
                    flex: 1,
                    child: Container(
                        height: 30,
                        alignment: Alignment.center,
                        color: Value == 0 ? Colors.grey[200] : Colors.green,
                        child: Text(Value.toString()))),
              ],
            ),
          ),
          SizedBox(
            height: 2,
          )
        ],
      ),
    );
  }
}
