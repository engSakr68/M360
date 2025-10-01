
import 'package:member360/features/base/data/models/invoice_model/invoice_model.dart';

import '../../../../core/helpers/di.dart';
import '../../../../core/requester/requester.dart';
import '../repositories/base_repository.dart';

class MemberInvoicesRequester extends Requester<List<InvoiceModel>?> {
  late String params;

  MemberInvoicesRequester(this.params) {
    request(fromRemote: true);
    request();
  }

  void setLoadingState() {
    loadingState();
  }

  @override
  Future<void> request({bool fromRemote = true}) async {
    setLoadingState();
    var result = await getIt.get<BaseRepository>().getMemberInvoices(params);
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
