import 'package:dio/dio.dart';
import 'package:mymikano_app/models/RealEstateModel.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:mymikano_app/services/DioClass.dart';

class RealEstatesService {
  late Dio dio;

  Future<void> PrepareCall() async {
    dio = await DioClass.getDio();
  }

  Future<List<RealEstate>> fetchRealEstatesService() async {
    await PrepareCall();
    final response = await dio.get((GetRealEstatesURL));

    if (response.statusCode == 200) {
      List<RealEstate> listresult = [];
      for (var item in response.data) {
        listresult.add(RealEstate.fromJson(item));
      }
      return listresult;
    } else
      throw Exception('Error fetching');
  }

  Future<RealEstate> fetchRealEstatesById(int id) async {
    await PrepareCall();
    final response = await dio
        .get((GetRealEstatesByIdURL).replaceAll("{id}", id.toString()));

    if (response.statusCode == 200) {
      return RealEstate.fromJson(response.data);
    } else
      throw Exception('Error fetching');
  }
}
