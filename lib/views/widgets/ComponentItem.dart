import 'package:flutter/material.dart';
import 'package:mymikano_app/State/RequestFormState.dart';
import 'package:mymikano_app/utils/AppColors.dart';
import 'package:provider/provider.dart';

class ComponentItem extends StatelessWidget {
  late String name;
  ComponentItem({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RequestFormState>(
      builder: (context, state, child) => Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(7)),
        child: Row(
          children: [
            Text(name),
            IconButton(
                onPressed: () {
                  state.deleteItem(name);
                },
                icon: Icon(
                  Icons.close,
                  color: mainGreyColorTheme,
                ))
          ],
        ),
      ),
    );
  }
}
