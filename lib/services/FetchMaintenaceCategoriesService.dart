import 'package:dio/dio.dart';
import 'package:mymikano_app/models/MaintenaceCategoryModel.dart';
import 'package:mymikano_app/services/DioClass.dart';
import 'package:mymikano_app/utils/appsettings.dart';

class Service {
  var headers;
  late Dio dio;

  Future<void> PrepareCall() async {
    dio = await DioClass.getDio();
  }

  Future<List<Categ>> fetchCategs() async {
    final url = (GetMainCategoriesURL);

    await PrepareCall();
    final response = await dio.get(url);
    if (response.statusCode == 200) {
      List<Categ> listresult = [];
      for (var item in response.data) {
        listresult.add(Categ.fromJson(item));
      }
      return listresult;
    } else
      throw Exception('Error fetching');
  }

  Future<List<Categ>> fetchSubCategs(int idMainCat) async {
    final url = (GetSubCategoriesURL + idMainCat.toString());

    await PrepareCall();
    final response = await dio.get(url);
    if (response.statusCode == 200) {
      List<Categ> listresult = [];
      for (var item in response.data) {
        listresult.add(Categ.fromJson(item));
      }
      return listresult;
    } else {
      throw Exception('Error fetching');
    }
  }

  Future<List<Categ>> fetchAllSubCategs() async {
    final url = (GetSubCategoriesURL);

    await PrepareCall();
    final response = await dio.get(url);
    if (response.statusCode == 200) {
      List<Categ> listresult = [];
      for (var item in response.data) {
        listresult.add(Categ.fromJson(item));
      }
      return listresult;
    } else {
      throw Exception('Error fetching');
    }
  }

  Future<List<Categ>> fetchAllCategs() async {
    final url = (GetAllCategoriesURL);

    await PrepareCall();
    final response = await dio.get(url);
    if (response.statusCode == 200) {
      List<Categ> listresult = [];
      for (var item in response.data) {
        listresult.add(Categ.fromJson(item));
      }

      return listresult;
    } else
      throw Exception('Error fetching');
  }
}
