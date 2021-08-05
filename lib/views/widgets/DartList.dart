import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mymikano_app/models/Entry.dart';
import 'EntryExample.dart';
class DaysList extends StatelessWidget {
  final ScrollController controller;

  DaysList({Key ? key, required this.controller}) : super(key: key);
  final List<Entry> data = <Entry>[
    Entry(
      1,
      'Heading 1',
      <Entry>[
        Entry(
          2,
          'Sub Heading 1',
          <Entry>[
            Entry(3,'Row 1'),
            Entry(4,'Row 2'),
            Entry(5,'Row 3'),
          ],
        ),
        Entry(1,'Sub Heading 2',
          <Entry>[
            Entry(2,'Row 1'),
            Entry(3,'Row 2'),
            Entry(4,'Row 3'),
          ],
        ),
        Entry(4,'Sub Heading 3',
          <Entry>[
            Entry(5,'Row 1'),
            Entry(6,'Row 2'),
            Entry(7,'Row 3'),
          ],),
      ],
    ),
    Entry(
      1,'Heading 2',
      <Entry>[
        Entry(2,'Sub Heading 1'),
        Entry(3,'Sub Heading 2'),
      ],
    ),
    Entry(
      4,'Heading 3',
      <Entry>[
        Entry(5,'Sub Heading 1',
          <Entry>[
            Entry(6,'Row 1'),
            Entry(7,'Row 2'),
            Entry(8,'Row 3'),
          ],),
        Entry(2,'Sub Heading 2',
          <Entry>[
            Entry(3,'Row 1'),
            Entry(4,'Row 2'),
            Entry(5,'Row 3'),
          ],),
        Entry(
          6,'Sub Heading 3',
          <Entry>[
            Entry(2,'Row 1'),
            Entry(3,'Row 2'),
            Entry(4,'Row 3'),
            Entry(5,'Row 4'),
          ],
        ),
      ],
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only( left: 16.0, right: 16.0),
        child:ListView.builder(
          scrollDirection: Axis.vertical,
          controller: controller, // assign controller here
          shrinkWrap: true,
          itemBuilder: (context, int index) =>
              EntryItem(data[index],context),
          itemCount: data.length,
        )
    );

  }
}