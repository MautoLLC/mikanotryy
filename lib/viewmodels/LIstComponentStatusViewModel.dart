import 'package:mymikano_app/models/ComponentStatusModel.dart';
import 'package:mymikano_app/services/ChangeComponentStatusService.dart';
import 'package:mymikano_app/services/FetchComponentStatusService.dart';

class ListComponentStatusesViewModel {
  List<ComponentStatusViewModel>? componentStatuses;

  Future<void> fetchComponentStatus() async {
    final apiresult = await ComponentStatusService().fetchComponentStatus();
    this.componentStatuses =
        apiresult.map((e) => ComponentStatusViewModel(e)).toList();
  }

  Future<void> changeComponentStatus(int? itemId, int? statusId) async {
    final apiresult = await changeChecklistItemStatus(itemId, statusId);
    print(apiresult);
  }
}

class ComponentStatusViewModel {
  final ComponentStatus? mcomponentStatus;
  ComponentStatusViewModel(this.mcomponentStatus);
}
