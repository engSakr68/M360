
import 'package:member360/features/base/data/models/class_model/class_model.dart';
import 'package:member360/features/base/domain/entities/class_params.dart';

import '../../../../core/helpers/di.dart';
import '../../../../core/requester/requester.dart';
import '../repositories/base_repository.dart';

class ClassCalendarRequester extends Requester<List<ClassModel>?> {
  late ClassParams params;

  ClassCalendarRequester(this.params) {
    request(fromRemote: true);
    request();
  }

  void setLoadingState() {
    loadingState();
  }

  @override
  Future<void> request({bool fromRemote = true}) async {
    setLoadingState();
    var result = await getIt.get<BaseRepository>().getClassCalendar(params);
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

  void onChangeParams(ClassParams param) {
    params = param;
    request();
  }
}
