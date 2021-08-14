import 'package:mymikano_app/models/MaintenanceRequestModel.dart';
import 'package:mymikano_app/services/FetchMaintenanceRequestsService.dart';


class ListMaintenanceRequestsViewModel {

  List<MaintenanceRequestsViewModel>?maintenanceRequests;


  Future<void> fetchMaintenanceRequests() async {
    final apiresult = await MaintenanceRequestService().fetchMaintenanceRequest();
    this.maintenanceRequests = apiresult.map((e) => MaintenanceRequestsViewModel(e)).toList();
  }


}

class MaintenanceRequestsViewModel {

  final MaintenanceRequestModel? mMaintenacerequest ;
  MaintenanceRequestsViewModel(this.mMaintenacerequest);
}

