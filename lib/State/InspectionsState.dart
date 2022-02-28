import 'package:flutter/material.dart';
import 'package:mymikano_app/models/InspectionModel.dart';
import 'package:mymikano_app/models/MaintenanceRequestModel.dart';
import 'package:mymikano_app/services/FetchInspectionsService.dart';
import 'package:mymikano_app/services/FetchMaintenanceRequestsService.dart';

class InspectionsState extends ChangeNotifier {
  List<InspectionModel> inspections = [];
  List<String> filters = [];

  InspectionsState() {
    fetchInspectionByUser();
  }

  void clear() {
    inspections = [];
    filters = [];
    notifyListeners();
  }

  void fetchInspectionByUser() async {
    inspections = await InspectionService().fetchInspectionsByUser();
    notifyListeners();
  }

  Future<MaintenanceRequestModel> fetchRelatedMaintenance(int id) async {
    return await MaintenanceRequestService().fetchMaintenanceRequestByID(id);
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
