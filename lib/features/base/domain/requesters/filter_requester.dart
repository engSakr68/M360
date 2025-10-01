import 'package:member360/core/helpers/di.dart';
import 'package:member360/core/requester/requester.dart';
import 'package:member360/features/base/data/models/filter_model/filter_model.dart';
import 'package:member360/features/base/domain/repositories/base_repository.dart';

class FilterRequester extends Requester<FilterModel?> {

  FilterRequester() {
    request(fromRemote: true);
    request();
  }

  void setLoadingState() {
    loadingState();
  }

  @override
  Future<void> request({bool fromRemote = true}) async {
    setLoadingState();
    var result = await getIt.get<BaseRepository>().getFilter(fromRemote);
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
}
