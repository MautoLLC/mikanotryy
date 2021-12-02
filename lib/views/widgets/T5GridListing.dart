import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mymikano_app/models/EntryModel.dart';
import 'package:mymikano_app/views/widgets/AppWidget.dart';
import 'package:mymikano_app/models/DashboardCardModel.dart';
import 'package:mymikano_app/viewmodels/ListMaintenanceCategoriesViewModel.dart';
import 'package:mymikano_app/views/screens/MaintenanceRequestScreen.dart';
import 'package:mymikano_app/models/MaintenaceCategoryModel.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class T5GridListing extends StatelessWidget {
  List<T5Category>? mFavouriteList;
  var isScrollable = false;

  T5GridListing(this.mFavouriteList, this.isScrollable);
  ListCategViewModel listCategViewModel = new ListCategViewModel();
  bool pressed = false;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return FutureBuilder(
        future: listCategViewModel.fetchCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SpinKitCircle(
                color: Colors.black,
                size: 65,
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
                child: Text(snapshot.error.toString(),
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

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        if(!pressed){
                          pressed = true;
                          goAll(mainCategory, context);
                          Future.delayed(Duration(seconds: 2), () {
                            pressed = false;
                          });
                        }
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
                                                                                            Spacer(),
                                Container(
                                  height: width / 4.5,
                                  width: width / 4.5,
                                  // margin: EdgeInsets.only(top: 18),
                                  decoration: boxDecoration(radius: 10),
                                  child: SizedBox(
                                                                  width: MediaQuery.of(context).size.width*0.5,
                              height: MediaQuery.of(context).size.height*0.5,
                                    child: Image.network(
                                      listCategViewModel.maincategs![index].mcateg!
                                          .maintenanceCategoryIcon,
                                          
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Expanded(
                                  child: Text(
                                    listCategViewModel.maincategs![index].mcateg!
                                        .maintenanceCategoryName,
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: SizerUtil.deviceType ==
                                                DeviceType.mobile?16:24),
                                  ),
                                ),
                                                            Spacer(),
                              ],
                            ),
                          ),
                          // Positioned(
                          //     right: 0,
                          //     top: 0,
                          //     child: Icon(Icons.keyboard_arrow_right))
                        ],
                      ),
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
}
