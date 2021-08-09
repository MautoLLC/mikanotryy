import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mymikano_app/models/EntryModel.dart';
import 'package:mymikano_app/models/MaintenaceCategoryModel.dart';
import 'package:mymikano_app/viewmodels/ListMaintenanceCategoriesViewModel.dart';
import 'EntryExample.dart';

Future goAll(int id) async
{
//   ListCategViewModel listCategViewModel=new ListCategViewModel();
  final List<Entry> data = <Entry>[];
   List<Entry> subdata =<Entry>[];
//   await  listCategViewModel.fetchAllCategories();
//   var l=listCategViewModel.allcategs!.length;
//   print("list length :");
//   print(l);
// ListCategViewModel parentcat;
//   int parentcategid;
//
//   String parentcategname;
 List<Categ> listsubs=[];
//
//   for (var i = 0; i <l ; i++)
//   {

  //  parentcategid=listCategViewModel.allcategs![i].mcateg!.idMaintenanceCategory;

//    parentcategname=listCategViewModel.allcategs![i].mcateg!.maintenanceCategoryName;
int idcurr=id;
    listsubs= await checksub(idcurr);

   //print("length of sbs list "+listsubs.length.toString());

//  while(listsubs.length!=0) {
  //  for(var i=0;i<listsubs.length;i++)
  for (var v in listsubs) {
    idcurr = v.idMaintenanceCategory;
    listsubs = await checksub(idcurr);
    print("length of" + v.maintenanceCategoryName.toString() + " sbs list " +
        listsubs.length.toString());
    subdata=[];
    for (var k in listsubs) {
      idcurr = k.idMaintenanceCategory;
      listsubs = await checksub(idcurr);
      print("length of" + k.maintenanceCategoryName.toString() + " sbs list " +
          listsubs.length.toString());
      subdata=[];
      for (var j in listsubs) {
        idcurr = j.idMaintenanceCategory;
        listsubs = await checksub(idcurr);
        print("length of" + j.maintenanceCategoryName.toString() + " sbs list " +
            listsubs.length.toString());
        Entry s= Entry(j.idMaintenanceCategory!,j.maintenanceCategoryName!);
        subdata.add(s);
    }
      Entry p= Entry(k.idMaintenanceCategory!,v.maintenanceCategoryName!,subdata);
      subdata.add(p);
    }
    Entry p= Entry(v.idMaintenanceCategory!,v.maintenanceCategoryName!,subdata);

    data.add(p);
}


  }
  //  for (var v in listCategViewModel.allcategs!) {
 //    if (v.mcateg!.maintenanceCategoryParentId == parentcategid) {
 //      print("Category " + parentcategname.toString()
 //      //    listCategViewModel.allcategs![i].mcateg!.maintenanceCategoryName
 //      //        .toString()
 //          + " subs : " + v.mcateg!.maintenanceCategoryName);
 //    parentcategid = v.mcateg!.idMaintenanceCategory;
 //      //Entry s= Entry(v.mcateg!.idMaintenanceCategory!,v.mcateg!.maintenanceCategoryName!);
 //      //   subdata.add(s);
 //    }
 //    //  Entry p= Entry(listCategViewModel.allcategs![i].mcateg!.idMaintenanceCategory,listCategViewModel.allcategs![i].mcateg!.maintenanceCategoryName.toString(),subdata);
 //    // data.add(p);
 // }

//}

Future<List<Categ>> checksub(int idParentCat) async {
  List<Categ> listsubs=[];

  ListCategViewModel listCategViewModel=new ListCategViewModel();

  await  listCategViewModel.fetchAllCategories();


  int parentcategid;
  String parentcategname;

    for (var v in listCategViewModel.allcategs!) {
      if (v.mcateg!.maintenanceCategoryParentId == idParentCat) {
        // print("Category " + idParentCat.toString()
        //
        //   + " subs : " + v.mcateg!.maintenanceCategoryName);
        listsubs.add(v.mcateg!);
      }
    }

  return listsubs;
}

class CategsList extends StatelessWidget {
  final ScrollController controller;

  CategsList(
      {Key ? key, required this.controller, required this.data, required this.listlength})
      : super(key: key);

  // final List<Entry> data = <Entry>[
  //   Entry(
  //     1,
  //     'Heading 1',
  //     <Entry>[
  //       Entry(
  //         2,
  //         'Sub Heading 1',
  //         <Entry>[
  //           Entry(3,'Row 1'),
  //           Entry(4,'Row 2'),
  //           Entry(5,'Row 3'),
  //         ],
  //       ),
  //       Entry(1,'Sub Heading 2',
  //         <Entry>[
  //           Entry(2,'Row 1'),
  //           Entry(3,'Row 2'),
  //           Entry(4,'Row 3'),
  //         ],
  //       ),
  //       Entry(4,'Sub Heading 3',
  //         <Entry>[
  //           Entry(5,'Row 1'),
  //           Entry(6,'Row 2'),
  //           Entry(7,'Row 3'),
  //         ],),
  //     ],
  //   ),
  //   Entry(
  //     1,'Heading 2',
  //     <Entry>[
  //       Entry(2,'Sub Heading 1'),
  //       Entry(3,'Sub Heading 2'),
  //     ],
  //   ),
  //   Entry(
  //     4,'Heading 3',
  //     <Entry>[
  //       Entry(5,'Sub Heading 1',
  //         <Entry>[
  //           Entry(6,'Row 1'),
  //           Entry(7,'Row 2'),
  //           Entry(8,'Row 3'),
  //         ],),
  //       Entry(2,'Sub Heading 2',
  //         <Entry>[
  //           Entry(3,'Row 1'),
  //           Entry(4,'Row 2'),
  //           Entry(5,'Row 3'),
  //         ],),
  //       Entry(
  //         6,'Sub Heading 3',
  //         <Entry>[
  //           Entry(2,'Row 1'),
  //           Entry(3,'Row 2'),
  //           Entry(4,'Row 3'),
  //           Entry(5,'Row 4'),
  //         ],
  //       ),
  //     ],
  //   ),
  // ];
  List<Entry> data = <Entry>[];
  int listlength;
  @override
  Widget build(BuildContext context) {

              return Container(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      controller: controller,
                      // assign controller here
                      shrinkWrap: true,
                      itemCount: this.listlength
                      ,
                      itemBuilder: (context, int index) {
                        return EntryItem(data[index], context);
                      }

                  )
              );


  }



}