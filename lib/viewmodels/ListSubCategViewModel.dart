import 'package:mymikano_app/models/MaintenaceCategoryModel.dart';
import 'package:mymikano_app/services/fetchcategService.dart';


class ListSubCategViewModel {
  List<SubCategViewModel>? subcategs;

  Future<void> fetchSubCategories(int i) async {
    final apiresult = await Service().fetchSubCategs(i);
    this.subcategs = apiresult.map((e) => SubCategViewModel(e)).toList();
    // for(int i,i<2,i++)
    // print(subcategs![1].mcateg!.maintenanceCategoryName);
  //
  //    subcategs!.asMap().forEach((i, value) {
  // //   print(subcategs!.length);
  //    });

  }
}
class SubCategViewModel {

  final Categ? msubcateg ;
  SubCategViewModel(this.msubcateg);
}