import 'package:flutter/material.dart';
import 'package:mymikano_app/models/InspectionModel.dart';
import 'package:mymikano_app/models/MaintenanceRequestModel.dart';
import 'package:mymikano_app/services/FetchInspectionsService.dart';
import 'package:mymikano_app/services/FetchMaintenanceRequestsService.dart';

class ListInspectionsViewModel {
  List<InspectionsViewModel>? inspections;

  Future<List<InspectionsViewModel>?> fetchInspections() async {
    final apiresult = await InspectionService().fetchInspections();
    print(apiresult.length);
    this.inspections = apiresult.map((e) => InspectionsViewModel(e)).toList();
    return inspections;
  }

  Future<void> fetchTechnicianInspections(int idTechnician) async {
    final apiresult =
        await InspectionService().fetchTechnicianInspections(idTechnician);
    this.inspections = apiresult.map((e) => InspectionsViewModel(e)).toList();
  }

  Future<void> fetchInspectionbyid(int id) async {
    final apiresult = await InspectionService().fetchInspectionbyId(id);

    this.inspections = apiresult.map((e) => InspectionsViewModel(e)).toList();
  }
}

class InspectionsViewModel {
  late final InspectionModel? mInspection;
  InspectionsViewModel(this.mInspection);
}
