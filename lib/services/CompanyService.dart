import 'package:dio/dio.dart';
import 'package:mymikano_app/models/CompanyModels.dart';
import 'package:mymikano_app/utils/appsettings.dart';

class CompanyService {
  Dio dio = Dio();

  Future<List<FounderModel>> fetchAboutUsInfo() async {
    List<FounderModel> founders = [];
    Response response = await dio.get(MikanoFoundersUrl);
    if (response.statusCode == 200) {
      for (var item in response.data) {
        FounderModel founder = FounderModel.fromJson(item);
        founders.add(founder);
      }
      return founders;
    }
    return founders;
  }

  Future<CompanyInfo> fetchCompanyInfo() async {
    CompanyInfo founder = CompanyInfo();
    Response response = await dio.get(MikanoCompanyInfoUrl);
    if (response.statusCode == 200) {
      CompanyInfo founder = CompanyInfo.fromJson(response.data);
      return founder;
    }
    return founder;
  }
}
