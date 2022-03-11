import 'package:dio/dio.dart';
import 'package:mymikano_app/models/MaintenanceRequestModel.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'DioClass.dart';

class MaintenanceRequestService {
  late Dio dio;

  Future<void> PrepareCall() async {
    dio = await DioClass.getDio();
  }

  Future<List<MaintenanceRequestModel>> fetchAllMaintenanceRequest() async {
    await PrepareCall();

    final response;
    List<MaintenanceRequestModel> listresult = [];
    try {
      response = await dio.get((GetMaintenaceRequestURL));
      if (response.statusCode == 200) {
        for (var item in response.data) {
          listresult.add(MaintenanceRequestModel.fromJson(item));
        }
      } else {
        print((GetMaintenaceRequestURL).toString());
        print(response.body.toString());
        throw Exception('Error fetching');
      }
    } on Exception catch (e) {
      print(e.toString());
    }
    return listresult;
  }

  Future<List<MaintenanceRequestModel>> fetchMaintenanceRequest() async {
    await PrepareCall();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response;
    List<MaintenanceRequestModel> listresult = [];

    try {
      response = await dio.get(GetMaintenaceRequestByUserIdURL.replaceAll(
          "{userID}", prefs.getString('UserID').toString()));

      if (response.statusCode == 200) {
        for (var item in response.data) {
          listresult.add(MaintenanceRequestModel.fromJson(item));
        }
      } else {
        print((GetMaintenaceRequestURL).toString());
        throw Exception('Error fetching');
      }
    } on Exception catch (e) {
      print(e.toString());
    }
    return listresult;
  }

  Future<MaintenanceRequestModel> fetchMaintenanceRequestByID(int id) async {
    await PrepareCall();
    final response = await dio.get((GetMaintenaceRequestURL + '/$id'));
    print(response.statusCode);
    if (response.statusCode == 200) {
      return MaintenanceRequestModel.fromJson(response.data);
    } else {
      print(response.data.toString());
      throw Exception('Error fetching');
    }
  }

  Future<dynamic> fetchMaintenanceRequestPriceByID(int id) async {
    await PrepareCall();
    final response = await dio
        .get(InspectionPriceURL.replaceAll("{maintenanceId}", id.toString()));
    if (response.statusCode == 200) {
      return response.data['price'];
    } else {
      throw Exception('Error fetching');
    }
  }

  Future<void> ChangeComponentStatusByID(int componentId, int statusId) async {
    await PrepareCall();
    String url = ChangeComponentStatusURL.replaceAll(
            "{inspectionChecklistItemID}", componentId.toString())
        .replaceAll("{componentStatusID}", statusId.toString());
    try {
      final response = await dio.put(url);
      if (response.statusCode == 204) {
        return;
      } else {
        throw Exception('Error fetching');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
