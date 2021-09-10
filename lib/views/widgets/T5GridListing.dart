import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mymikano_app/models/EntryModel.dart';
import 'package:mymikano_app/utils/AppWidget.dart';
import 'package:mymikano_app/models/DashboardCardModel.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/utils/colors.dart';
import 'package:mymikano_app/viewmodels/ListMaintenanceCategoriesViewModel.dart';
import 'package:mymikano_app/views/screens/MaintenanceRequestScreen.dart';
import 'package:mymikano_app/models/MaintenaceCategoryModel.dart';

// ignore: must_be_immutable
class T5GridListing extends StatelessWidget {
  List<T5Category>? mFavouriteList;
  var isScrollable = false;

  T5GridListing(this.mFavouriteList, this.isScrollable);
  ListCategViewModel listCategViewModel = new ListCategViewModel();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return FutureBuilder(
        future: listCategViewModel.fetchCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SpinKitChasingDots(
                itemBuilder: (BuildContext context, int index) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index.isEven ? t5Cat3 : Colors.black87,
                    ),
                  );
                },
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
                child: Text(
                    "Please check you internet connection and try again !",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Colors.black)));
          } else {
            return GridView.builder(
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: listCategViewModel.maincategs!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    crossAxisSpacing: 25,
                    mainAxisSpacing: 25),
                itemBuilder: (BuildContext context, int index) {
                  Categ mainCategory =
                      listCategViewModel.maincategs![index].mcateg!;

                  return GestureDetector(
                    onTap: () {
                      goAll(mainCategory, context);
                    },
                    child: Stack(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          decoration: boxDecoration(
                              radius: 10,
                              showShadow: true,
                              bgColor: Colors.white),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: width / 4.5,
                                width: width / 4.5,
                                margin: EdgeInsets.only(top: 18),
                                decoration: boxDecoration(radius: 10),
                                child: Image.asset(
                                  mFavouriteList![index].icon,
                                ),
                              ),
                              SizedBox(height: 20),
                              Expanded(
                                child: Text(
                                  listCategViewModel.maincategs![index].mcateg!
                                      .maintenanceCategoryName,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                            right: 0,
                            top: 0,
                            child: Icon(Icons.keyboard_arrow_right))
                      ],
                    ),
                  );
                });
          }
        });
  }

  Future goAll(Categ mainCategory, BuildContext context) async {
    final List<Entry> data = <Entry>[];
    List<Entry> subdata = <Entry>[];
    List<Entry> subdata2 = <Entry>[];

    List<Categ> listsubs = [];

    int idcurr;
    ListCategViewModel listCategViewModel = new ListCategViewModel();

    await listCategViewModel.fetchAllCategories();
    List<CategViewModel> all = listCategViewModel.allcategs!;
    listsubs = await checksub(mainCategory.idMaintenanceCategory, all);
    int length;
    length = listsubs.length;
    if (listsubs.length > 0)
      for (var v in listsubs) {
        idcurr = v.idMaintenanceCategory;
        listsubs = await checksub(idcurr, all);
        if (listsubs.length > 0)
          for (var k in listsubs) {
            subdata = [];
            idcurr = k.idMaintenanceCategory;
            listsubs = await checksub(idcurr, all);

            if (listsubs.length > 0)
              for (var j in listsubs) {
                subdata2 = [];
                idcurr = j.idMaintenanceCategory;
                listsubs = await checksub(idcurr, all);
                Entry s =
                    Entry(j.idMaintenanceCategory, j.maintenanceCategoryName);
                subdata.add(s);
              }
            Entry p = Entry(
                k.idMaintenanceCategory, k.maintenanceCategoryName, subdata);
            subdata2.add(p);
          }
        Entry p =
            Entry(v.idMaintenanceCategory, v.maintenanceCategoryName, subdata2);
        subdata2 = [];
        data.add(p);
      }

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MaintenanceRequestScreen(
                mainCatg: mainCategory,
                mydata: data,
                listlength: length,
              )),
    );
  }

  Future<List<Categ>> checksub(
      int idParentCat, List<CategViewModel> all) async {
    List<Categ> listsubs = [];

    for (var v in all) {
      if (v.mcateg!.maintenanceCategoryParentId == idParentCat) {
        listsubs.add(v.mcateg!);
      }
    }

    return listsubs;
  }

  Future go4(Categ mainCategory, BuildContext context) async {
    ListCategViewModel listCategViewModel2 = new ListCategViewModel();
    ListCategViewModel listCategViewModel3 = new ListCategViewModel();
    ListCategViewModel listCategViewModel4 = new ListCategViewModel();
    final List<Entry> data3 = <Entry>[];
    List<Entry> data3sub = <Entry>[];
    List<Entry> data4sub = <Entry>[];
    await listCategViewModel2
        .fetchSubCategories(mainCategory.idMaintenanceCategory);
    var l = listCategViewModel2.subcategs!.length;
    print("sub1 list length :");
    print(l);
    for (var i = l - 1; i >= 0; i--) {
      listCategViewModel3
          .fetchSubCategories(
              listCategViewModel2.subcategs![i].mcateg!.idMaintenanceCategory)
          .then((result) async {
        data3sub = [];
        for (var j = 0; j < listCategViewModel3.subcategs!.length; j++) {
          data4sub = [];
          listCategViewModel4
              .fetchSubCategories(listCategViewModel3
                  .subcategs![j].mcateg!.idMaintenanceCategory)
              .then((result) async {
            for (var k = 0; k < listCategViewModel4.subcategs!.length; k++) {
              Entry en = Entry(
                  listCategViewModel4
                      .subcategs![k].mcateg!.idMaintenanceCategory,
                  listCategViewModel4
                      .subcategs![k].mcateg!.maintenanceCategoryName
                      .toString());
              data4sub.add(en);
            }
          });
          Entry e = Entry(
              listCategViewModel3.subcategs![j].mcateg!.idMaintenanceCategory,
              listCategViewModel3.subcategs![j].mcateg!.maintenanceCategoryName
                  .toString(),
              data4sub);
          data3sub.add(e);
        }
        data3.add(Entry(
            listCategViewModel2.subcategs![i].mcateg!.idMaintenanceCategory,
            listCategViewModel2.subcategs![i].mcateg!.maintenanceCategoryName
                .toString(),
            data3sub));
      });
    }

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MaintenanceRequestScreen(
                mainCatg: mainCategory,
                mydata: data3,
                listlength: l,
              )),
    );
  }
}
