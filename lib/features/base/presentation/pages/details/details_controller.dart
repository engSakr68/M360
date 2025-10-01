part of "details_imports.dart";

class DetailsController {
  final ObsValue<ActivePlanModel?> plansCubit = ObsValue.withInit(null);

  void checkBooking(BuildContext context, ClassModel details) {
    showDialog(
      context: context,
      builder: (cxt) {
        return AlertDialog(
          backgroundColor: context.colors.white,
          shadowColor: context.colors.white,
          surfaceTintColor: context.colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20).r,
          ),
          alignment: Alignment.center,
          content: Text(
            "This session costs \$${details.price}. Book the session?",
            softWrap: true,
            textAlign: TextAlign.center,
            style: AppTextStyle.s16_w500(color: context.colors.black),
          ),
          actions: [
            SizedBox(
              width: 100.w,
              child: AppTextButton.maxCustom(
                onPressed: () => bookClass(context, classId: details.id!),
                maxHeight: 40.h,
                text: 'Book',
                txtColor: context.colors.white,
                bgColor: context.colors.primary,
              ),
            ),
            SizedBox(
              width: 100.w,
              child: AppTextButton.maxCustom(
                onPressed: () {
                  AutoRouter.of(context).popForced();
                },
                maxHeight: 40.h,
                text: 'Ignore',
                txtColor: context.colors.primary,
                bgColor: context.colors.white,
                borderColor: context.colors.primary,
              ),
            ),
          ],
        );
      },
    );
  }

  Future<bool> bookClass(BuildContext context, {required int classId}) async {
      var bookResponse = await getIt<BaseRepository>().bookClass(classId);
      return _handleBookResponse(bookResponse);
  }

  bool _handleBookResponse(MyResult<BookModel> response) {
    final context = getIt<GlobalContext>().context();
    return response.when(isSuccess: (bookModel) {
      AppSnackBar.showSimpleToast(
        color: context.colors.black,
        msg: "Class booked successfully",
        type: ToastType.success,
      );
      AutoRouter.of(context).push(Dashboard(index: 0));
      return true;
    }, isError: (error) {
      // AppSnackBar.showSimpleToast(
      //   msg: error.message,
      //   type: ToastType.error,
      // );
      return false;
    });
  }

  Future<bool> cancelClass(BuildContext context, {required int classId}) async {
      var cancelResponse = await getIt<BaseRepository>().cancelClass(classId);
      return _handleCancelResponse(cancelResponse);
  }

  bool _handleCancelResponse(MyResult<String> response) {
    final context = getIt<GlobalContext>().context();
    return response.when(isSuccess: (data) {
      AppSnackBar.showSimpleToast(
        color: context.colors.black,
        msg: data??"",
        type: ToastType.success,
      );
      AutoRouter.of(context).push(Dashboard(index: 0));
      return true;
    }, isError: (error) {
      // AppSnackBar.showSimpleToast(
      //   msg: error.message,
      //   type: ToastType.error,
      // );
      return false;
    });
  }
}
