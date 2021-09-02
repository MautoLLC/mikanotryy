import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Engine_State extends StatelessWidget {
  String EngineState;
  String BreakerState;
  Engine_State({required this.EngineState, required this.BreakerState});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[800],
      padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            'Engine State',
            style: TextStyle(
                fontFamily: 'CG',
                fontSize: 20.0,
                color: Colors.grey,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(EngineState, style: TextStyle(color: Colors.white)),
          Divider(
            color: Colors.orange,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Breaker State',
            style: TextStyle(
                fontFamily: 'CG',
                fontSize: 20.0,
                color: Colors.grey,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            BreakerState,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
