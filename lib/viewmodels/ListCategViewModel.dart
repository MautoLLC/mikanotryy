import 'package:mymikano_app/models/categ.dart';
import 'package:mymikano_app/services/fetchcategService.dart';

class ListCategViewModel {

  List<CategViewModel>? categs;

  Future<void> fetchCategories() async {
    final apiresult = await Service().fetchCategs();
    this.categs = apiresult.map((e) => CategViewModel(e)).toList();
  }
}


class CategViewModel {

  final Categ? mcateg ;
  CategViewModel(this.mcateg);
}

