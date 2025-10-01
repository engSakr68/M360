import 'package:member360/core/helpers/di.dart';
import 'package:member360/core/requester/requester.dart';
import 'package:member360/features/auth/data/models/user_info_model/user_info_model.dart';
import 'package:member360/features/base/domain/repositories/base_repository.dart';

class ProfileRequester extends Requester<UserInfoModel?> {

  ProfileRequester() {
    request(fromRemote: true);
    request();
  }

  void setLoadingState() {
    loadingState();
  }

  @override
  Future<void> request({bool fromRemote = true}) async {
    setLoadingState();
    var result = await getIt.get<BaseRepository>().getProfile(fromRemote);
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
