import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mymikano_app/models/EntryModel.dart';
import 'package:mymikano_app/utils/colors.dart';

class EntryItem extends StatelessWidget {

  const EntryItem(this.entry,this.context);
  final Entry entry;
  final BuildContext context;


  Widget _buildTiles(Entry root) {

    if (root.children.isEmpty) return ListTile(
        title: Text(root.title),
        onTap: ()  {
         // Navigator.pop(context,root.title);
          Navigator.pop(context,root);
        // print("root id entry"+root.idEntry.toString());

        }
    ); // Closing the sheet.);
    return  Card(
        shape:OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: t13_edit_text_color, width: 0.0),
        ),
        child:Theme(
            data: ThemeData().copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              key: PageStorageKey<Entry>(root),
              title: Text(root.title),
              iconColor: Colors.white,
              textColor: Colors.black,
              children: root.children.map(_buildTiles).toList(),
            )
        ));
  }
  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }




}