
import 'package:mymikano_app/models/ComponentStatusModel.dart';
import 'package:mymikano_app/services/FetchComponentStatusService.dart';

class ListComponentStatusesViewModel {

  List<ComponentStatusViewModel>? componentStatuses;


  Future<void> fetchComponentStatus() async {
    final apiresult = await ComponentStatusService().fetchComponentStatus();
    this.componentStatuses = apiresult.map((e) => ComponentStatusViewModel(e)).toList();
  }

}

class ComponentStatusViewModel {

  final ComponentStatus? mcomponentStatus ;
  ComponentStatusViewModel(this.mcomponentStatus);
}

