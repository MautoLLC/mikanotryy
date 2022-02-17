import 'package:flutter/material.dart';
import 'package:mymikano_app/State/RequestFormState.dart';
import 'package:mymikano_app/models/ComponentModel.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:provider/provider.dart';

class ComponentItem extends StatelessWidget {
  late ComponentModel Component;
  ComponentItem({Key? key, required this.Component}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RequestFormState>(
      builder: (context, state, child) => Container(
        height: 37,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(7)),
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(Component.componentName.toString()),
                  IconButton(
                      onPressed: () {
                        state.selectItem(state.items.firstWhere((element) => element.Component.idComponent == Component.idComponent));
                      },
                      icon: Icon(
                        Icons.close,
                        color: mainGreyColorTheme,
                      ))
                ],
              ),
              Container(height: 1, width: (9*Component.componentName.toString().length).toDouble() , color: Colors.green,)
            ],
          ),
        ),
      ),
    );
  }
}
