
import 'package:member360/features/base/data/models/active_plan_model/active_plan_model.dart';

import '../../../../core/helpers/di.dart';
import '../../../../core/requester/requester.dart';
import '../repositories/base_repository.dart';

class ActivePlansRequester extends Requester<List<ActivePlanModel>?> {
  late String params;

  ActivePlansRequester(this.params) {
    request(fromRemote: true);
    request();
  }

  void setLoadingState() {
    loadingState();
  }

  @override
  Future<void> request({bool fromRemote = true}) async {
    setLoadingState();
    var result = await getIt.get<BaseRepository>().getActivePlans(params);
    result.when(
      isSuccess: (data) {
        successState(data);
      },
      isError: (error) {
        failedState(error, () {
          request(fromRemote: fromRemote);
        });
      },
    );
  }

  void onChangeParams(String param) {
    params = param;
    request();
  }
}
