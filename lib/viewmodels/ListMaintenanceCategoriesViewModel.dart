import 'package:mymikano_app/models/MaintenaceCategoryModel.dart';
import 'package:mymikano_app/services/FetchMaintenaceCategoriesService.dart';

class ListCategViewModel {
  List<CategViewModel>? maincategs;
  List<CategViewModel>? subcategs;
  List<CategViewModel>? allcategs;

  Future<void> fetchCategories() async {
    final apiresult = await Service().fetchCategs();
    this.maincategs = apiresult.map((e) => CategViewModel(e)).toList();
  }

  Future<void> fetchAllCategories() async {
    final apiresult = await Service().fetchAllCategs();
    this.allcategs = apiresult.map((e) => CategViewModel(e)).toList();
  }

  Future<void> fetchSubCategories(int i) async {
    final apiresult = await Service().fetchSubCategs(i);
    this.subcategs = apiresult.map((e) => CategViewModel(e)).toList();
  }
}

class CategViewModel {
  late final Categ? mcateg;

  CategViewModel(this.mcateg);

  @override
  String toString() {
    return 'Categ: { ${mcateg!.maintenanceCategoryName.toString()}';
  }
}
