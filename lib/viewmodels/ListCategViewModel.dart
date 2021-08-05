import 'package:mymikano_app/models/MaintenaceCategoryModel.dart';
import 'package:mymikano_app/services/fetchcategService.dart';

class ListCategViewModel {

  List<CategViewModel>? categs;

  List<CategViewModel>? allcategs;
  Future<void> fetchCategories() async {
    final apiresult = await Service().fetchCategs();
    this.categs = apiresult.map((e) => CategViewModel(e)).toList();
    print("sally");
    print(categs![1].mcateg!.maintenanceCategoryName);
  }

  Future<void> fetchAllCategories() async {
    final apiresult = await Service().fetchAllCategs();
    this.allcategs = apiresult.map((e) => CategViewModel(e)).toList();

  }
}

class CategViewModel {

  final Categ? mcateg ;
  CategViewModel(this.mcateg);
}

