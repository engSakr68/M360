
import 'package:member360/features/base/data/models/trainer_model/trainer_model.dart';
import 'package:member360/features/base/domain/entities/pt_session_model.dart';

import '../../../../core/helpers/di.dart';
import '../../../../core/requester/requester.dart';
import '../repositories/base_repository.dart';

class TrainersRequester extends Requester<List<TrainerModel>> {
  late PTSessionParams params;

  TrainersRequester(this.params) {
    request(fromRemote: true);
    request();
  }

  void setLoadingState() {
    loadingState();
  }

  @override
  Future<void> request({bool fromRemote = true}) async {
    setLoadingState();
    var result = await getIt.get<BaseRepository>().getTrainers(params);
    result.when(
      isSuccess: (data) {
        successState(data??[]);
      },
      isError: (error) {
        failedState(error, () {
          request(fromRemote: fromRemote);
        });
      },
    );
  }

  void onChangeParams(PTSessionParams param) {
    params = param;
    request();
  }
}
