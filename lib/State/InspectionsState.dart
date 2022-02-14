import 'package:flutter/material.dart';
import 'package:mymikano_app/models/MaintenanceRequestModel.dart';
import 'package:mymikano_app/services/FetchMaintenanceRequestsService.dart';

class InspectionsState extends ChangeNotifier {
  List<MaintenanceRequestModel> inspections = [];
  List<String> filters = [];

  InspectionsState() {
    fetchInspectionByUser();
  }

  void fetchAllInspection() async {
    inspections =
        await MaintenanceRequestService().fetchAllMaintenanceRequest();
    notifyListeners();
  }

  void fetchInspectionByUser() async {
    inspections = await MaintenanceRequestService().fetchMaintenanceRequest();
    notifyListeners();
  }

  void sortInspections() {
    inspections = inspections.reversed.toList();
    notifyListeners();
  }

  void modifyFilters(String filter) {
    if (filters.contains(filter)) {
      filters.remove(filter);
    } else {
      filters.add(filter);
    }
    notifyListeners();
  }
}
