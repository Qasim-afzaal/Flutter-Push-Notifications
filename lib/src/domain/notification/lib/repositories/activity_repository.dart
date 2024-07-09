
import 'package:flutter_push_notification/src/data/api_repository/api_repository.dart';
import 'package:flutter_push_notification/src/domain/notification/lib/model/acitivity_model.dart';

class ActivityRespository {
  ActivityRespository._();

  static ActivityRespository get instance => ActivityRespository._();
  ActivtyLogsModel? _activtyLogsModel;
  ActivtyLogsModel? get activtyLogsModel => _activtyLogsModel;
  Future<void> getAllAcivityLogs() async {
    final response = await ApiRepository.sendGetRequest(
        "EnterYourPort",
        "Enter End Point",
        "authTokken");
    print(response);

    if (response["success"] == true) {
      _activtyLogsModel = ActivtyLogsModel.fromJson(response);
    } else {
      throw response["message"];
    }
  }
}
