import 'package:dio/dio.dart';
import 'package:mymikano_app/models/TechnicianModel.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'DioClass.dart';

class UserService {
  late Dio dio;

  Future<void> PrepareCall() async {
    dio = await DioClass.getDio();
  }

  Future<bool> EditUserInfo(
      String firstName, String lastName, String phoneNumber) async {
    await PrepareCall();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = userEditInfoUrl.replaceAll(
        "{id}", prefs.getString('UserID').toString());
    try {
      Response response = await dio.put((url), data: {
        "id": prefs.getString('UserID').toString(),
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phoneNumber
      });
      if (response.statusCode == 204) {
        return true;
      } else {
        throw Exception('Error');
      }
    } catch (e) {
      throw Exception('Error');
    }
  }

  Future<TechnicianModel> GetUserInfo() async {
    await PrepareCall();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url =
        userGetInfoUrl.replaceAll("{id}", prefs.getString('UserID').toString());
    try {
      Response response = await dio.get(
        (url),
      );
      if (response.statusCode == 200) {
        TechnicianModel technicianModel =
            TechnicianModel.fromJson(response.data);
        return technicianModel;
      } else {
        throw Exception('Error');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<TechnicianModel> GetUserInfoByID(String userID) async {
    await PrepareCall();
    String url = userGetInfoUrl.replaceAll("{id}", userID);
    try {
      Response response = await dio.get(
        (url),
      );
      if (response.statusCode == 200) {
        TechnicianModel technicianModel =
            TechnicianModel.fromJson(response.data);
        return technicianModel;
      } else {
        throw Exception('Error');
      }
    } catch (e) {
      throw Exception('Error');
    }
  }
}
