import 'package:flutter/material.dart';
import 'package:mymikano_app/State/LoadCalculationState.dart';
import 'package:mymikano_app/views/widgets/T13Widget.dart';
import 'package:mymikano_app/views/widgets/TopRowBar.dart';
import 'package:provider/provider.dart';

class LoadCalculationScreen extends StatefulWidget {
  const LoadCalculationScreen({ Key? key }) : super(key: key);

  @override
  State<LoadCalculationScreen> createState() => _LoadCalculationScreenState();
}

class _LoadCalculationScreenState extends State<LoadCalculationScreen> {

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<LoadCalculationState>(context, listen: false).clear();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<LoadCalculationState>(
      builder: (context, loadCalculationState, child) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: Column(
              children: [
                TopRowBar(title: 'Load Calculation'),
                Expanded(
                  child: loadCalculationState.getFieldsCount()!=0?ListView.builder(
                    itemCount: loadCalculationState.getFieldsCount(),
                    itemBuilder: (context, index){
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: DropdownButton<String>(
                                value: loadCalculationState.getcomponents(index),
                                isExpanded: true,
                                items: ['yellow', 'brown', 'silver'].map((String value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(), 
                                onChanged: (variable){
                                  loadCalculationState.setComponent(index, variable.toString());
                                },)),
                            Text(loadCalculationState.getcomponentQuatity(index).toString()),
                            Column(
                              children: [
                                IconButton(
                                  constraints: BoxConstraints.tight(Size(30,30)),
                                  padding: EdgeInsets.zero,
                                  onPressed: (){
                                    loadCalculationState.incrementComponentQuantity(index);
                                  }, 
                                  icon: Icon(Icons.add)
                                ),
                                IconButton(
                                  constraints: BoxConstraints.tight(Size(30,30)),
                                  padding: EdgeInsets.zero,
                                  onPressed: (){
                                    loadCalculationState.decrementComponentQuantity(index);
                                  }, 
                                  icon: Icon(Icons.minimize))
                              ],
                            )
                          ],
                        ),
                      );
                    }
                  ):Container(),
                ),
                IconButton(onPressed: (){
                  loadCalculationState.incrementFieldsCount();
                }, icon: Icon(Icons.add_circle, color: Colors.red,)),
                Row(
                  children: [
                    Text("Running Power: ${loadCalculationState.getrunningPower()}",
                    style: TextStyle(color: Colors.grey, fontSize: 22),),
                  ],
                ),
                Row(
                  children: [
                    Text("Starting Power: ${loadCalculationState.getstartingPower()}",
                    style: TextStyle(color: Colors.grey, fontSize: 22),),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.5,
                  child: T13Button(textContent: "Find My Generator", onPressed: (){}))
              ],
            ),
          )
        ),
      ),
    );
  }
}