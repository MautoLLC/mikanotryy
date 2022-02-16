import 'package:dio/dio.dart';
import 'package:mymikano_app/utils/appsettings.dart';

import 'DioClass.dart';

class RequestFormService{
    late Dio dio;

  Future<void> PrepareCall() async {
    dio = await DioClass.getDio();
  }

  Future<bool> SubmitRequestForm(String RequestId, String status) async {
    await PrepareCall();
    String url = RequestFormUrl.replaceAll("{idrequest}", RequestId);
    try {
      Response response = await dio.put(url,
        queryParameters: {
          "statusID": status
        }
      );
      if (response.statusCode == 204) {
        return true;
      } else {
        throw Exception('Error');
      }
    } catch (e) {
      throw Exception('Error');
    }
  }
}