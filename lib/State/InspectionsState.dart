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
      if(filter == "In Progress") {
        removeFiltersInProgress();
      } else {
        filters.remove(filter);
      }
    } else {
      if(filter == "In Progress") {
        fillFiltersInProgress();
      } else {
        filters.add(filter);
      }
    }
    notifyListeners();
  }

  void fillFiltersInProgress(){
    filters.add("Awaiting pricing by admin");
    filters.add("Awaiting pricing approval by client");
    filters.add("Pricing declined by client. Awaiting new pricing by admin");
    filters.add("Pricing approved by client. Awaiting admin approval");
    filters.add("Pricing approved by admin. Inspection in progress by technician");
    filters.add("Inspection completed by technician. Awaiting admin confirmation");
    filters.add("Inspection completion confirmed by admin. Awaiting user approval");
    filters.add("In Progress");
    notifyListeners();
  }

  void removeFiltersInProgress(){
    filters.remove("Awaiting pricing by admin");
    filters.remove("Awaiting pricing approval by client");
    filters.remove("Pricing declined by client. Awaiting new pricing by admin");
    filters.remove("Pricing approved by client. Awaiting admin approval");
    filters.remove("Pricing approved by admin. Inspection in progress by technician");
    filters.remove("Inspection completed by technician. Awaiting admin confirmation");
    filters.remove("Inspection completion confirmed by admin. Awaiting user approval");
    filters.remove("In Progress");
    notifyListeners();
  }
  
}
