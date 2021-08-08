import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mymikano_app/models/EntryModel.dart';
import 'package:mymikano_app/models/MaintenaceCategoryModel.dart';
import 'package:mymikano_app/viewmodels/ListMaintenanceCategoriesViewModel.dart';
import 'EntryExample.dart';

Future goAll() async
{
  ListCategViewModel listCategViewModel=new ListCategViewModel();
  final List<Entry> data = <Entry>[];
  final List<Entry> subdata =<Entry>[];
  await  listCategViewModel.fetchAllCategories();
  var l=listCategViewModel.allcategs!.length;
  print("list length :");
  print(l);
ListCategViewModel parentcat;
  for (var i = 0; i <l ; i++)
  {
    print(i.toString()+"i");
    print(listCategViewModel.allcategs![i].mcateg!.maintenanceCategoryParentId.toString()+"i");

    var parentid=listCategViewModel.allcategs![i].mcateg!.maintenanceCategoryParentId;

    if(parentid !=null)
{
//  print("no parent for categ id"+listCategViewModel.allcategs![i].mcateg!.idMaintenanceCategory.toString());
 // Entry en = Entry(listCategViewModel.subcategs![i].mcateg!.idMaintenanceCategory,listCategViewModel.subcategs![i].mcateg!.maintenanceCategoryName.toString());
  //final sub=  listCategViewModel.allcategs!.where((element) => element.mcateg!.maintenanceCategoryParentId== listCategViewModel.allcategs![i].mcateg!.idMaintenanceCategory);
//print(sub[0].mcateg!.maintenanceCategoryName.toString());

  for (var v in listCategViewModel.allcategs!) {
   if (v.mcateg!.maintenanceCategoryParentId == listCategViewModel.allcategs![i].mcateg!.idMaintenanceCategory) {
     print("subs : " + v.mcateg!.maintenanceCategoryName);

   }
   else print("");
   parentid=v.mcateg!.idMaintenanceCategory;
  }
// if(sub.length > 0 )
//  for(var j=0;j<sub.length;j++)
//  {
  //    Entry enn = Entry(sub[j].mcateg!.idMaintenanceCategory,listCategViewModel.allcategs![j].mcateg!.maintenanceCategoryName.toString());
  // subdata.add(enn);
  //print("ll");
  //}
// Entry en= Entry(listCategViewModel.subcategs![i].mcateg!.idMaintenanceCategory,listCategViewModel.subcategs![i].mcateg!.maintenanceCategoryName.toString(),subdata);
// data.add(en);
}


// else {
//
//  final idd=  listCategViewModel.allcategs!.where((element) => element.mcateg!.idMaintenanceCategory== listCategViewModel.allcategs![i].mcateg!.maintenanceCategoryParentId);
//
//  print(idd.toString()+"is the parent of"+listCategViewModel.allcategs![i].mcateg!.maintenanceCategoryName.toString());
//
//
//
//     }
  }

  for(var t=0;t<data.length;t++)
    print(data[t].title);
  //   for (var i = l- 1; i >= 0 ; i--)
  //   {
  //     listCategViewModel3.fetchSubCategories(listCategViewModel2.subcategs![i].mcateg!.idMaintenanceCategory).then((result) async
  //     {
  //       data3sub = [];
  //       for (var j = 0; j < listCategViewModel3.subcategs!.length; j++)
  //       {
  //         data4sub = [];
  //         listCategViewModel4.fetchSubCategories(listCategViewModel3.subcategs![j].mcateg!.idMaintenanceCategory).then((result) async
  //         {
  //           for (var k= 0; k< listCategViewModel4.subcategs!.length; k++) {
  //             Entry en = Entry(
  //                 listCategViewModel4.subcategs![k].mcateg!.idMaintenanceCategory,
  //                 listCategViewModel4.subcategs![k].mcateg!.maintenanceCategoryName.toString());
  //             data4sub.add(en);
  //           }
  //         });
  //         Entry e = Entry(listCategViewModel3.subcategs![j].mcateg!.
  //         idMaintenanceCategory,
  //             listCategViewModel3.subcategs![j].mcateg!
  //                 .maintenanceCategoryName
  //                 .toString(),
  //             data4sub
  //         );
  //         data3sub.add(e);
  //       }
  //       data3.add(Entry(listCategViewModel2.subcategs![i].mcateg!.
  //       idMaintenanceCategory,listCategViewModel2.subcategs![i].mcateg!.
  //       maintenanceCategoryName
  //           .toString(),
  //           data3sub));
  //     });
  //   }
  //
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //         builder: (context) => MaintenanceRequestScreen(mainCatg: mainCategory,mydata: data3,)),
  //   );
}

// ListCategViewModel MAINsub = new ListCategViewModel();
// MAINsub.fetchSubCategories(this.MCategory.idMaintenanceCategory);
//
// length=MAINsub.subcategs!.length;
// print(length);

class CategsList extends StatelessWidget {
  final ScrollController controller;

  CategsList(
      {Key ? key, required this.controller, required this.data, required this.MCategory, required this.fetchmainsub, required this.listlength})
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
  Categ MCategory;

  ListCategViewModel listCategViewModel2 = new ListCategViewModel();

 Future fetchmainsub;
int listlength;
  @override
  Widget build(BuildContext context) {
    int length;

ListCategViewModel MAINsub = new ListCategViewModel();
    MAINsub.fetchSubCategories(this.MCategory.idMaintenanceCategory).then((result) async
    {

length=MAINsub.subcategs!.length;
print("length");
print(length);

    });
    return FutureBuilder(
        future: fetchmainsub,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {

            if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            //  if (this.listlength == 0) {
            // //  return Text("NO SUBS");
            // return EntryItem(Entry(this.MCategory.idMaintenanceCategory,this.MCategory.maintenanceCategoryName), context);
            //  }
            else {

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
          else   return Center( child: const CircularProgressIndicator(),);
          }

    );
  }



}