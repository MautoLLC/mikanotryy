import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mymikano_app/models/EntryModel.dart';
import 'package:mymikano_app/utils/AppWidget.dart';
import 'package:mymikano_app/models/DashboardCardModel.dart';
import 'package:mymikano_app/utils/colors.dart';
import 'package:mymikano_app/viewmodels/ListMaintenanceCategoriesViewModel.dart';
import 'package:mymikano_app/views/screens/MaintenanceRequestScreen.dart';
import 'package:mymikano_app/models/MaintenaceCategoryModel.dart';


// ignore: must_be_immutable
class T5GridListing extends StatelessWidget {
  List<T5Category>? mFavouriteList;
  var isScrollable = false;

  T5GridListing(this.mFavouriteList, this.isScrollable);
  ListCategViewModel listCategViewModel=new ListCategViewModel();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return FutureBuilder(
          future:listCategViewModel.fetchCategories(),
          builder: (context, snapshot) {

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child:
      //        CircularProgressIndicator(),

              SpinKitChasingDots(
                //color: Colors.grey,
                itemBuilder: (BuildContext context, int index) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index.isEven ? t5Cat3 : Colors.black87,
                    ),
                  );
                },),


              );
            }
            else {

              return GridView.builder(
                  scrollDirection: Axis.vertical,
                  physics: isScrollable
                      ? ScrollPhysics()
                      : NeverScrollableScrollPhysics(),
                  itemCount:  listCategViewModel.maincategs!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      crossAxisSpacing: 25,
                      mainAxisSpacing: 25),
                  itemBuilder: (BuildContext context, int index) {
               Categ mainCategory=listCategViewModel.maincategs![index].mcateg!;
                    return GestureDetector(
                      onTap: ()  {
                        //ExpansionTileDemo().launch(context);
                        go4(mainCategory,context);
                        // getdataTree(mainCategoryId,context);
                     //   yr(mainCategoryId,context);
                     // SubmitMaintenanceRequest();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: boxDecoration(
                            radius: 10, showShadow: true, bgColor: Colors.white),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: width / 6,
                              width: width / 6,
                              margin: EdgeInsets.only(bottom: 4, top: 18),
                              padding: EdgeInsets.all(width / 30),
                              decoration: boxDecoration(
                                  bgColor:
                                  mFavouriteList![index].color
                                  //Colors.teal
                                  , radius: 10
                              ),
                              child: SvgPicture.asset(
                                mFavouriteList![index].icon,
                                color: t5White,
                              ),
                            ),
                            SizedBox(height: 20),
                            Expanded(
                              child:
                              // text(mFavouriteList![index].name,
                              //     textColor: appStore.textSecondaryColor,
                              //     fontSize: textSizeMedium,
                              //     maxLine: 2,
                              //     isCentered: true)
                              Text(listCategViewModel.maincategs![index].mcateg!.maintenanceCategoryName),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }
          }

    );
  }
  Future go4(Categ mainCategory,BuildContext context) async
  {
    ListCategViewModel listCategViewModel2=new ListCategViewModel();
    ListCategViewModel listCategViewModel3=new ListCategViewModel();
    ListCategViewModel listCategViewModel4=new ListCategViewModel();
    final List<Entry> data3 = <Entry>[];
    List<Entry> data3sub = <Entry>[];
    List<Entry> data4sub = <Entry>[];
    await  listCategViewModel2.fetchSubCategories(mainCategory.idMaintenanceCategory);
    var l=listCategViewModel2.subcategs!.length;
    print("sub1 list length :");
    print(l);

    for (var i = l- 1; i >= 0 ; i--)
    {
      listCategViewModel3.fetchSubCategories(listCategViewModel2.subcategs![i].mcateg!.idMaintenanceCategory).then((result) async
      {
        data3sub = [];
        for (var j = 0; j < listCategViewModel3.subcategs!.length; j++)
        {
          data4sub = [];
          listCategViewModel4.fetchSubCategories(listCategViewModel3.subcategs![j].mcateg!.idMaintenanceCategory).then((result) async
          {
            for (var k= 0; k< listCategViewModel4.subcategs!.length; k++) {
              Entry en = Entry(
                  listCategViewModel4.subcategs![k].mcateg!.idMaintenanceCategory,
                  listCategViewModel4.subcategs![k].mcateg!.maintenanceCategoryName.toString());
              data4sub.add(en);
            }
          });
          Entry e = Entry(listCategViewModel3.subcategs![j].mcateg!.
          idMaintenanceCategory,
              listCategViewModel3.subcategs![j].mcateg!
                  .maintenanceCategoryName
                  .toString(),
              data4sub
          );
          data3sub.add(e);
        }
        data3.add(Entry(listCategViewModel2.subcategs![i].mcateg!.
        idMaintenanceCategory,listCategViewModel2.subcategs![i].mcateg!.
        maintenanceCategoryName
            .toString(),
            data3sub));
      });
    }

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MaintenanceRequestScreen(mainCatg: mainCategory,mydata: data3,listlength: l,)),
    );
  }

//   Future yr (int keymaincatId,BuildContext context) async
// {
// //  bool bb= await hasSub(keymaincatId);
//   ListSubCategViewModel listCategViewModel2 = new ListSubCategViewModel();
//   ListSubCategViewModel listCategViewModel3 = new ListSubCategViewModel();
//   final List<Entry> data3 = <Entry>[];
//   List<Entry> data3sub = <Entry>[];
//
//   // await  listCategViewModel2.fetchSubCategories(keymaincatId);
//   // var l=listCategViewModel2.subcategs!.length;
//   //
//   // for (var i = l- 1; i >= 0 ; i--) {
//
//
//   //await hasSub(listCategViewModel2.subcategs![i].msubcateg!.idMaintenanceCategory);
//   if (await hasSub(keymaincatId) > 0) {
//     // await  listCategViewModel3.fetchSubCategories(listCategViewModel2.subcategs![i].msubcateg!.idMaintenanceCategory);
//     // for(var j=0;j<listCategViewModel3.subcategs!.length;j++)
//
//
//     print("has childrens");
//   }
//   else
//     print("no childrens");
//
//
//   // bool bb= await hasSub(keymaincatId);
//   // if(bb) {
//   //   print("has childrens");
//   // }
//   // else
//   //   print("no childrens");
// }

  //
  // Future go(int keymaincatId,BuildContext context) async
  // {
  //   ListSubCategViewModel listCategViewModel2=new ListSubCategViewModel();
  //   ListSubCategViewModel listCategViewModel3=new ListSubCategViewModel();
  //
  //   final List<Entry> data3 = <Entry>[];
  //   List<Entry> data3sub = <Entry>[];
  //
  //   await  listCategViewModel2.fetchSubCategories(keymaincatId);
  //   var l=listCategViewModel2.subcategs!.length;
  //   print("sub1 list length :");
  //   print(l);
  //
  //   for (var i = l- 1; i >= 0 ; i--)
  //   {
  //      //for (var i = 0; i <l ; i++) {
  //          listCategViewModel3.fetchSubCategories(listCategViewModel2.subcategs![i].msubcateg!.idMaintenanceCategory).then((result) async
  //         {
  //                  // print(listCategViewModel2.subcategs![i].msubcateg!.maintenanceCategoryName);
  //                  // print("index");
  //                  // print(i);
  //                  // print("LENGTH");
  //                  // print(listCategViewModel3.subcategs?.length);
  //
  //                  data3sub = [];
  //                 // if (listCategViewModel3.subcategs?.length != 0)
  //                 // {
  //                //  for (var j = listCategViewModel3.subcategs!.length - 1 ;j >= 0; j--) {
  //                     for (var j = 0; j < listCategViewModel3.subcategs!.length; j++)
  //                     {
  //                       Entry e = Entry(
  //                               listCategViewModel3.subcategs![j].msubcateg!
  //                               .maintenanceCategoryName
  //                               .toString());
  //                       data3sub.add(e);
  //                     }
  //               data3.add(Entry(listCategViewModel2.subcategs![i].msubcateg!.
  //                         idMaintenanceCategory
  //                         .toString(),
  //                          data3sub));
  //                 //}
  //               // else
  //               //   {
  //               // data3.add(Entry(listCategViewModel2.subcategs![i].msubcateg!.idMaintenanceCategory.toString(),
  //               //            data3sub));
  //               // print("bye");
  //               //   }
  //       });
  //
  //   }
  //
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) => MaintenanceRequestScreen(maincatId: keymaincatId,mydata: data3,)),
  //     );
  // }

  // Future getdataTree(int keymaincatId,BuildContext context) async
  // {
  //   ListSubCategViewModel listCategViewModel2=new ListSubCategViewModel();
  //   ListSubCategViewModel listCategViewModel3=new ListSubCategViewModel();
  //
  //   final List<Entry> data3 = <Entry>[];
  //   List<Entry> data3sub = <Entry>[];
  //
  //   int idcurrentsub;
  //   var c=5;
  //   idcurrentsub=keymaincatId;
  //  // do {
  //
  //    await listCategViewModel2.fetchSubCategories(idcurrentsub);
  //    var l = listCategViewModel2.subcategs!.length;
  //    print("sub1 list length :");
  //    print(l);
  //    for (var i = l - 1; i >= 0; i--) {
  //      print("idcurrentsub");
  //      print(idcurrentsub);
  //      listCategViewModel3.fetchSubCategories(
  //          listCategViewModel2.subcategs![i].msubcateg!.idMaintenanceCategory)
  //          .then((result) async
  //      {
  //        data3sub = [];
  //        var j;
  //       do {
  //         for (j = 0; j < listCategViewModel3.subcategs!.length; j++) {
  //           Entry e = Entry(
  //               listCategViewModel3.subcategs![j].msubcateg!
  //                   .maintenanceCategoryName
  //                   .toString());
  //           data3sub.add(e);
  //         }
  //         j--;
  //       }while(hasSub(listCategViewModel3.subcategs![j-1].msubcateg!.idMaintenanceCategory)==true);
  //
  //        data3.add(Entry(listCategViewModel2.subcategs![i].msubcateg!.
  //        idMaintenanceCategory
  //            .toString(),
  //            data3sub));
  //      });
  //      idcurrentsub =
  //          listCategViewModel3.subcategs![i].msubcateg!.idMaintenanceCategory;
  //    }
  //    c--;
  //    print("C");
  //    print(c);
  //  // }while(checkSubcateg(listCategViewModel3.subcategs![i].msubcateg!.idMaintenanceCategory)==true );
  //
  //
  //   for (var r=0;r<data3.length;r++)
  // {    print("data3[r]");
  //   print(data3[r]);}
  //   // Navigator.push(
  //   //   context,
  //   //   MaterialPageRoute(
  //   //       builder: (context) => MaintenanceRequestScreen(maincatId: keymaincatId,mydata: data3,)),
  //   // );
  // }
}
//
// Future<int> hasSub(int keymaincatId) async {
//   ListSubCategViewModel listCategViewModel2=new ListSubCategViewModel();
//   await listCategViewModel2.fetchSubCategories(keymaincatId);
//   var l = listCategViewModel2.subcategs!.length;
//
//
//
//   print("length : "+l.toString());
//
//   // if(l==0)
//   // return Future<bool>.value(false);
//   // else {
//   //   int getLengh(){
//   //     return l;
//   //   }
//     return Future<int>.value(l);
//   //}
// }
//

