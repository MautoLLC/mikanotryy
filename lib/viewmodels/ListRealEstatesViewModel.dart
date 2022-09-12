import 'package:mymikano_app/models/RealEstateModel.dart';
import 'package:mymikano_app/services/FetchRealEstatesService.dart';

class ListRealEstatesViewModel {
  List<RealEstatesViewModel>? realEstates;

  Future<void> fetchRealEstates() async {
    final apiresult = await RealEstatesService().fetchRealEstatesService();
    this.realEstates = apiresult.map((e) => RealEstatesViewModel(e)).toList();
  }
}

class RealEstatesViewModel {
  final RealEstate? mrealEstate;

  RealEstatesViewModel(this.mrealEstate);
}
