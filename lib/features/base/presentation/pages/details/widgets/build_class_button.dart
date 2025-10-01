part of "details_widgets_imports.dart";

class BuildClassButton extends StatelessWidget {
  final DetailsController controller;
  final ClassModel details;
  const BuildClassButton(
      {super.key, required this.controller, required this.details});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: (int.parse(details.maxSlots.toString()) -
                  int.parse(details.attendancesCount.toString())) ==
              0 &&
          (details.waitLimit! - details.waitSpots!) == 0 &&
          details.alreadyBooked == false,
      replacement: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20).r,
        child: AppTextButton.maxCustom(
          text: details.alreadyBooked == true
              ? "Cancel"
              : (int.parse(details.maxSlots.toString()) -
                              int.parse(details.attendancesCount.toString())) ==
                          0 &&
                      (details.waitLimit! - details.waitSpots!) != 0 &&
                      details.waitList == true
                  ? "Book to waitlist"
                  : "Book",
          onPressed: () => details.alreadyBooked == true
              ? controller.cancelClass(context, classId: details.id!)
              : (int.parse(details.maxSlots.toString()) -
                              int.parse(details.attendancesCount.toString())) ==
                          0 &&
                      details.waitList == false
                  ? () {}
                  : controller.checkBooking(context, details),
          bgColor: (int.parse(details.maxSlots.toString()) -
                          int.parse(details.attendancesCount.toString())) ==
                      0 &&
                  details.waitList == false
              ? context.colors.disableGray
              : context.colors.secondary,
          txtColor: context.colors.white,
          textSize: 14.sp,
          maxHeight: 50.h,
        ),
      ),
      child: Gaps.empty,
    );
  }
}
